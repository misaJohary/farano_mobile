import 'package:farano/core/widgets/custom_text_field.dart';
import 'package:farano/core/widgets/text_in_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../domain/entities/player_entity.dart';
import '../../manager/game/game_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg_2.png',
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
        ),
        SafeArea(
          minimum: const EdgeInsets.only(top: 50),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.pause_circle_filled_rounded,
                size: 40,
              ),
            ),
          ),
        ),
        SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocConsumer<GameBloc, GameState>(
              listenWhen: (previous, current) =>
                  current.game != null && previous.game?.id != current.game?.id,
              listener: (context, state) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: TextButton(
                            onPressed: () {},
                            child: const Text('Ready'),
                          ),
                          actions: [
                            TextButton(onPressed: () {}, child: const Text('ok')),
                          ],
                        ));
              },
              builder: (context, state) {
                final game = state.game;
                if (game == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final currentWord = game.currentWord;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ScoreWidget(
                      player: PlayerEntity.first(),
                    ),
                    ScoreWidget(
                      player: PlayerEntity.second(),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: currentWord
                                    .split('')
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.all(5),
                                    child: TextInBox(
                                      fontSize: 25,
                                      letter: e.value.toUpperCase(),
                                      foregroundColor: e.key.isOdd
                                          ? Colors.red
                                          : Colors.blue,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .7,
                                    height: 50,
                                    child: CustomTextField(
                                      controller: _controller,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Submit'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    super.key,
    required this.player,
  });

  final PlayerEntity player;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/person.svg',
              width: 20,
              colorFilter: ColorFilter.mode(
                  player.id == 'P1' ? Colors.red : Colors.blue,
                  BlendMode.srcIn),
            ),
            SizedBox(
              width: 8,
            ),
            Text('10')
          ],
        ),
      ),
    );
  }
}
