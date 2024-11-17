// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:base_project/core/di/network_module.dart' as _i165;
import 'package:base_project/layers/data/repositories/authentication_repository_impl.dart'
    as _i1051;
import 'package:base_project/layers/data/source/api_client.dart' as _i792;
import 'package:base_project/layers/domain/repositories/authentication_repository.dart'
    as _i717;
import 'package:base_project/layers/presentation/login/login_controller.dart'
    as _i737;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    final networkModule = _$NetworkModule();
    gh.singleton<_i361.Dio>(() => networkModule.getDio());
    gh.singleton<_i792.ApiClient>(
        () => networkModule.getApiClient(gh<_i361.Dio>()));
    gh.singleton<_i717.AuthenticationRepository>(
        () => _i1051.AuthenticationRepositoryImpl(gh<_i792.ApiClient>()));
    gh.factory<_i737.LoginController>(
        () => _i737.LoginController(gh<_i717.AuthenticationRepository>()));
    return this;
  }
}

class _$NetworkModule extends _i165.NetworkModule {}
