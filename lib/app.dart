import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/theme.dart';
import 'game/presentation/manager/game/game_bloc.dart';
import 'game/presentation/manager/match/match_bloc.dart';
import 'game/presentation/pages/new_game/choose_host_page.dart';
import 'injectable.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MatchBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GameBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Farano',
        theme: theme,
        home: const ChooseHostPage(),
      ),
    );
  }
}