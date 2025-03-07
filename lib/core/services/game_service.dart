import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class GameService {

  // Factory constructor to return the singleton instance
  GameService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _matchesRef => _firestore.collection('matches');

  CollectionReference get _gamesRef => _firestore.collection('games');

  CollectionReference get _usersRef => _firestore.collection('users');

  // Create a new match with a unique code
  Future<Map<String, dynamic>> createNewMatch(
    String userId,
    String username,
    Map<String, dynamic> config,
  ) async {
    // Generate a random 6-character code
    final String matchCode = await _generateUniqueMatchCode();

    final matchData = {
      'code': matchCode,
      'isPublic': false,
      'status': 'waiting', // 'waiting', 'player_2_entered', 'game_created', 'active', 'completed', 'abandoned'
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'config': {
        'timePerTurn': config['timePerTurn'] ?? 30,
        'maxRematchCount': config['maxRematchCount'] ?? 3,
      },
      'currentGameId': null,
      'players': [
        {
          'id': userId,
          'username': username,
          'isReady': true,
        },
        {
          'id': null,
          'username': null,
          'isReady': false,
        }
      ],
      'gameHistory': [],
      'rematchCount': 0,
      'rematchRequests': []
    };

    // Add the match to Firestore
    final docRef = await _matchesRef.add(matchData);

    return {
      'id': docRef.id, //Match id
      'code': matchCode, //match code
    };
  }

  // Generate a unique match code that doesn't already exist
  Future<String> _generateUniqueMatchCode() async {
    bool isUnique = false;
    String code = '';

    while (!isUnique) {
      code = _generateRandomCode();

      // Check if this code already exists
      final snapshot = await _matchesRef
          .where('matchCode', isEqualTo: code)
          .where('status', whereIn: ['waiting', 'active']).get();

      isUnique = snapshot.docs.isEmpty;
    }

    return code;
  }

  // Generate a random 6-character alphanumeric code
  String _generateRandomCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  // Join a match using a match code
  Future<Map<String, dynamic>> joinMatchWithCode(
      String userId, String username, String matchCode) async {
    // Query for match with this code
    final snapshot = await _matchesRef
        .where('matchCode', isEqualTo: matchCode)
        .where('status', isEqualTo: 'waiting')
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('Match not found or already in progress');
    }

    final matchDoc = snapshot.docs.first;
    final matchData = matchDoc.data() as Map<String, dynamic>;

    // Check if user is already in this match
    if (matchData['players'][0]['userId'] == userId) {
      return {
        'matchId': matchDoc.id,
        'alreadyJoined': true,
      };
    }

    // Check if match is full
    if (matchData['players'][1]['userId'] != null) {
      throw Exception('Match is already full');
    }

    // Make a copy of the players array
    List<Map<String, dynamic>> updatedPlayers = List.from(matchData['players']);

// Update only player 2's data
    updatedPlayers[1] = {
      'userId': userId,
      'username': username,
      'isReady': true,
    };

// Update the entire players array to ensure nothing is lost
    await matchDoc.reference.update({
      'players': updatedPlayers,
      'status': 'player2Entered',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    // Create the first game for this match
    final gameId = await _createNewGame(matchDoc.id, matchData['players']);

    // Update match with the new game
    await matchDoc.reference.update({
      'currentGameId': gameId,
      'status': 'gameCreated',
      'gameHistory': FieldValue.arrayUnion([gameId]),
    });

    return {
      'matchId': matchDoc.id,
      'gameId': gameId,
      'alreadyJoined': false,
    };
  }

  // Create a new game for a match
  Future<String> _createNewGame(String matchId, List<dynamic> players) async {
    // Randomly select first player
    final random = Random();
    final startingPlayerIndex = random.nextInt(2);

    final gameData = {
      'matchId': matchId,
      'status': 'active',
      'startedAt': FieldValue.serverTimestamp(),
      'endedAt': null,
      'currentWord': '',
      'currentPlayerId': players[startingPlayerIndex]['userId'],
      'turnStartedAt': FieldValue.serverTimestamp(),
      'turns': [],
      'winner': null,
      'validWord': null,
    };

    final docRef = await _gamesRef.add(gameData);
    return docRef.id;
  }

  // Find available public matches
  Future<List<Map<String, dynamic>>> findPublicMatches(String userId) async {
    final snapshot = await _matchesRef
        .where('isPublic', isEqualTo: true)
        .where('status', isEqualTo: 'waiting')
        .limit(10)
        .get();

    final List<Map<String, dynamic>> availableMatches = [];

    for (var doc in snapshot.docs) {
      final match = doc.data() as Map<String, dynamic>;
      // Don't include matches created by current user
      if (match['players'][0]['userId'] != userId) {
        availableMatches.add({
          'matchId': doc.id,
          'matchCode': match['matchCode'],
          'creatorName': match['players'][0]['username'],
          'config': match['config'],
        });
      }
    }

    return availableMatches;
  }

  // Set match visibility (public/private)
  Future<void> setMatchVisibility(String matchId, bool isPublic) async {
    await _matchesRef.doc(matchId).update({
      'isPublic': isPublic,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Play a turn - add a letter to the word
  Future<Map<String, dynamic>> playTurn(
      String gameId, String userId, String letter) async {
    // Get current game state
    final gameDoc = await _gamesRef.doc(gameId).get();

    if (!gameDoc.exists) {
      throw Exception('Game not found');
    }

    final gameData = gameDoc.data() as Map<String, dynamic>;

    // Check if it's this player's turn
    if (gameData['currentPlayerId'] != userId) {
      throw Exception('Not your turn');
    }

    // Check if game is still active
    if (gameData['status'] != 'active') {
      throw Exception('Game is not active');
    }

    // Add the letter to the current word
    final String newWord = gameData['currentWord'] + letter;

    // Record this turn
    final turnData = {
      'userId': userId,
      'letter': letter,
      'timestamp': FieldValue.serverTimestamp(),
    };

    // Get match data to find the other player
    final matchDoc = await _matchesRef.doc(gameData['matchId']).get();
    final matchData = matchDoc.data() as Map<String, dynamic>;
    String nextPlayerId;

    if (matchData['players'][0]['userId'] == userId) {
      nextPlayerId = matchData['players'][1]['userId'];
    } else {
      nextPlayerId = matchData['players'][0]['userId'];
    }

    // TODO: Check if the word is complete/valid
    // This would connect to your dictionary service
    bool isValidWord = await _checkIfValidWord(newWord);
    Map<String, dynamic> updateData;

    if (isValidWord && newWord.length >= 3) {
      // Player won by completing a valid word
      updateData = {
        'currentWord': newWord,
        'turns': FieldValue.arrayUnion([turnData]),
        'status': 'completed',
        'endedAt': FieldValue.serverTimestamp(),
        'winner': userId,
        'validWord': newWord,
      };
    } else {
      // Continue the game
      updateData = {
        'currentWord': newWord,
        'turns': FieldValue.arrayUnion([turnData]),
        'currentPlayerId': nextPlayerId,
        'turnStartedAt': FieldValue.serverTimestamp(),
      };
    }

    // Update the game
    await gameDoc.reference.update(updateData);

    return {
      'currentWord': newWord,
      'isGameOver': isValidWord && newWord.length >= 3,
      'nextPlayerId': isValidWord && newWord.length >= 3 ? null : nextPlayerId,
      'isValidWord': isValidWord && newWord.length >= 3,
    };
  }

  // Check if word is valid using your dictionary service
  Future<bool> _checkIfValidWord(String word) async {
    // Replace this with your actual dictionary lookup implementation
    // For example, you might use an API or a local dictionary
    if (word.length < 3) return false;

    // Placeholder implementation
    // In a real app, you'd connect to a word validation service or database
    final List<String> sampleWords = [
      'apple',
      'cat',
      'dog',
      'app',
      'bat',
      'card'
    ];
    return sampleWords.contains(word.toLowerCase());
  }

  // Request a rematch
  Future<bool> requestRematch(String matchId, String userId) async {
    final matchDoc = await _matchesRef.doc(matchId).get();

    if (!matchDoc.exists) {
      throw Exception('Match not found');
    }

    final matchData = matchDoc.data() as Map<String, dynamic>;

    // Check if maximum rematch count has been reached
    if (matchData['rematchCount'] >= matchData['config']['maxRematchCount']) {
      throw Exception('Maximum number of rematches reached');
    }

    // Add this user to rematch requests
    await matchDoc.reference.update({
      'rematchRequests': FieldValue.arrayUnion([userId]),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    // Check if both players have requested rematch
    List<dynamic> updatedRequests = List.from(matchData['rematchRequests']);
    updatedRequests.add(userId);

    // If both players requested rematch, start a new game
    if (updatedRequests.length == 2) {
      return await _startRematch(matchId, matchData);
    }

    return false; // Still waiting for other player
  }

  // Start a rematch with a new game
  Future<bool> _startRematch(
      String matchId, Map<String, dynamic> matchData) async {
    try {
      // Create a new game
      final gameId = await _createNewGame(matchId, matchData['players']);

      // Update the match
      await _matchesRef.doc(matchId).update({
        'currentGameId': gameId,
        'gameHistory': FieldValue.arrayUnion([gameId]),
        'rematchCount': FieldValue.increment(1),
        'rematchRequests': [],
        'status': 'active',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      print('Error starting rematch: $e');
      return false;
    }
  }

  // Listen to match updates
  Stream<DocumentSnapshot> listenToMatch(String matchId) {
    return _matchesRef.doc(matchId).snapshots();
  }

  // Listen to game updates
  Stream<DocumentSnapshot> listenToGame(String gameId) {
    return _gamesRef.doc(gameId).snapshots();
  }
}
