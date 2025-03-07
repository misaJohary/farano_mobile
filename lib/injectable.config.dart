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
import 'game/data/repositories/game_repository_impl.dart' as _i940;
import 'game/domain/repositories/game_repository.dart' as _i888;
import 'game/presentation/manager/game_bloc.dart' as _i545;

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
        () => _i940.GameRepositoryImpl(gh<_i853.GameService>()));
    gh.factory<_i545.GameBloc>(
        () => _i545.GameBloc(gh<_i888.GameRepository>()));
    return this;
  }
}
