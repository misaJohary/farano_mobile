// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/services/game_service.dart' as _i853;
import 'game/data/repositories/game_repository_imp.dart' as _i443;
import 'game/data/repositories/match_repository_impl.dart' as _i670;
import 'game/domain/repositories/game_repository.dart' as _i888;
import 'game/domain/repositories/match_repository.dart' as _i881;
import 'game/presentation/manager/game/game_bloc.dart' as _i744;
import 'game/presentation/manager/match/match_bloc.dart' as _i472;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i853.GameService>(() => _i853.GameService());
    gh.lazySingleton<_i888.GameRepository>(
        () => _i443.GameRepositoryImpl(gh<_i853.GameService>()));
    gh.lazySingleton<_i881.MatchRepository>(
        () => _i670.MatchRepositoryImpl(gh<_i853.GameService>()));
    gh.factory<_i744.GameBloc>(
        () => _i744.GameBloc(gh<_i888.GameRepository>()));
    gh.factory<_i472.MatchBloc>(
        () => _i472.MatchBloc(gh<_i881.MatchRepository>()));
    return this;
  }
}
