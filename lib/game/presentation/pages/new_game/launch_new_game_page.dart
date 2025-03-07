import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/services/game_service.dart';
import '../../../../core/utils/log.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/strok_text.dart';
import '../../../../core/widgets/trapezed_painter.dart';
import '../../../domain/entities/match_entity.dart';
import '../../manager/match/match_bloc.dart';
import '../game/game_page.dart';

class LaunchNewGamePage extends StatefulWidget {
  const LaunchNewGamePage({super.key});

  @override
  State<LaunchNewGamePage> createState() => _LaunchNewGamePageState();
}

class _LaunchNewGamePageState extends State<LaunchNewGamePage> {
  StreamSubscription? _matchSubscription;

  @override
  void dispose() {
    _matchSubscription?.cancel();
    super.dispose();
  }

  void _subscribeToMatchUpdates(String matchId) {
    // Cancel any existing subscription
    _matchSubscription?.cancel();

    // Get the GameService instance
    final gameService = GameService();

    // Subscribe to match updates
    _matchSubscription = gameService.listenToMatch(matchId).listen((snapshot) {
      Log.info(snapshot.data());
      if (!mounted) return;

      final matchData = snapshot.data() as Map<String, dynamic>?;
      if (matchData != null) {
        context.read<MatchBloc>().add(GameMatchUpdated(matchData));
      }
    }, onError: (error) {
      //context.read<GameBloc>().add(const GameError('Failed to listen to match updates'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MatchBloc, MatchState>(
          listenWhen: (previous, current) =>
              previous.match?.id != current.match?.id,
          listener: (context, state) {
            if (state.match?.id != null) {
              _subscribeToMatchUpdates(state.match!.id);
            }
          },
        ),
        BlocListener<MatchBloc, MatchState>(
          listenWhen: (previous, current) =>
              previous.match?.status != current.match?.status,
          listener: (context, state) {
            Log.info(state.match?.status);
            if (state.match?.status == MatchStatus.player2Entered) {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 5,),
                      Text('Joueur 2 rejoint la partie ...'),
                    ],
                  ),
                ),
              );
            } else if (state.match?.status == MatchStatus.gameCreated) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GamePage()),
              );
            }
          },
        ),
      ],
      child: Stack(
        children: [
          Image.asset(
            'assets/images/bg_1.png',
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.sizeOf(context).width * .7,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomPaint(
                    painter: TrapezedPainter(color: Colors.amber),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: CustomPaint(
                        painter: TrapezedPainter(color: Colors.amber.shade200),
                        child: IntrinsicHeight(
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * .7,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            child: BlocBuilder<MatchBloc, MatchState>(
                                builder: (context, state) {
                              switch (state.status) {
                                case Status.loading:
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  );

                                case Status.failed:
                                  return const Center(
                                      child:
                                          Text('Une erreur s\'est produite'));
                                default:
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/person.svg',
                                        colorFilter: const ColorFilter.mode(
                                            Colors.blue, BlendMode.srcIn),
                                        semanticsLabel: 'Red dash paths',
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const StrokeText(
                                        text: 'Partager ce code à votre ami(e)',
                                        strokeColor: Colors.black,
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "CarterOne",
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      CustomTextField(
                                        initialValue: state.match?.code,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                          hintText: 'Code de la partie',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Clipboard.setData(
                                                    const ClipboardData(
                                                        text: "Your Copy text"))
                                                .then((_) {
                                              if (!context.mounted) return;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Copied to your clipboard !'),
                                                ),
                                              );
                                            });
                                          },
                                          child:
                                              const StrokeText(text: 'Copier'),
                                        ),
                                      ),
                                    ],
                                  );
                              }
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
