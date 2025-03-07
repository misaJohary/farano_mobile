import 'package:farano/core/widgets/text_in_box.dart';
import 'package:farano/game/presentation/manager/game_bloc.dart';
import 'package:farano/game/presentation/pages/new_game/launch_new_game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/strok_text.dart';
import 'join_game_page.dart';

class ChooseHostPage extends StatelessWidget {
  const ChooseHostPage({super.key});

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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.sizeOf(context).width * .7,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Center(
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) =>
                          TextInBox(letter: letters[index]),
                      separatorBuilder: (_, __) => const SizedBox(
                            width: 5,
                          ),
                      itemCount: letters.length),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 190,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    context.read<GameBloc>().add(const GameCreated());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LaunchNewGamePage()),
                    );
                  },
                  child: const StrokeText(text: 'Lancer une partie'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 190,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JoinGamePage()),
                    );
                  },
                  child: const StrokeText(text: 'Joindre une partie'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

final List<String> letters = ['A', 'B', 'C'];
