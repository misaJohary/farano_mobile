import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/strok_text.dart';
import '../../../../core/widgets/trapezed_painter.dart';
import '../../manager/game_bloc.dart';

class LaunchNewGamePage extends StatelessWidget {
  const LaunchNewGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                          child: BlocBuilder<GameBloc, GameState>(
                              builder: (context, state) {
                            switch (state.gameStatus) {
                              case GameStatus.loading:
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                );

                              case GameStatus.failed:
                                return const Center(
                                    child: Text('Une erreur s\'est produite'));
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
                                          Clipboard.setData(const ClipboardData(
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
                                        child: const StrokeText(text: 'Copier'),
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
    );
  }
}