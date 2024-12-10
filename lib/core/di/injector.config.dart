// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:base_project/app/builder/app_loading_builder_controller.dart'
    as _i483;
import 'package:base_project/core/di/app_module.dart' as _i847;
import 'package:base_project/core/di/network_module.dart' as _i165;
import 'package:base_project/core/global/account_manager_controller.dart'
    as _i144;
import 'package:base_project/core/global/deeplink_controller.dart' as _i193;
import 'package:base_project/core/network/api_cookie_intercepter.dart' as _i860;
import 'package:base_project/core/network/github_authentication_intercepter.dart'
    as _i184;
import 'package:base_project/layers/data/repositories/account_info_repository_impl.dart'
    as _i793;
import 'package:base_project/layers/data/repositories/activity_history_repository_impl.dart'
    as _i684;
import 'package:base_project/layers/data/repositories/artifact_repository_impl.dart'
    as _i167;
import 'package:base_project/layers/data/repositories/authentication_repository_impl.dart'
    as _i1051;
import 'package:base_project/layers/data/repositories/phase_repository_impl.dart'
    as _i218;
import 'package:base_project/layers/data/repositories/project_info_repository_impl.dart'
    as _i279;
import 'package:base_project/layers/data/repositories/scanner_info_repository_impl.dart'
    as _i836;
import 'package:base_project/layers/data/repositories/ticket_repository_impl.dart'
    as _i911;
import 'package:base_project/layers/data/repositories/vulnerability_repository_impl.dart'
    as _i1054;
import 'package:base_project/layers/data/source/api_client.dart' as _i792;
import 'package:base_project/layers/data/source/github_api_client.dart'
    as _i780;
import 'package:base_project/layers/data/source/github_client.dart' as _i50;
import 'package:base_project/layers/domain/repositories/account_info_repository.dart'
    as _i500;
import 'package:base_project/layers/domain/repositories/activity_history_repository.dart'
    as _i630;
import 'package:base_project/layers/domain/repositories/artifact_repository.dart'
    as _i214;
import 'package:base_project/layers/domain/repositories/authentication_repository.dart'
    as _i717;
import 'package:base_project/layers/domain/repositories/phase_repository.dart'
    as _i680;
import 'package:base_project/layers/domain/repositories/project_info_repository.dart'
    as _i194;
import 'package:base_project/layers/domain/repositories/scanner_info_repository.dart'
    as _i146;
import 'package:base_project/layers/domain/repositories/ticket_repository.dart'
    as _i241;
import 'package:base_project/layers/domain/repositories/vulnerability_repository.dart'
    as _i32;
import 'package:base_project/layers/presentation/account_register/account_register_controller.dart'
    as _i352;
import 'package:base_project/layers/presentation/dashboard/dashboard_controller.dart'
    as _i877;
import 'package:base_project/layers/presentation/login/login_controller.dart'
    as _i737;
import 'package:base_project/layers/presentation/widgets/account_list_builder/account_list_builder_controller.dart'
    as _i258;
import 'package:base_project/layers/presentation/widgets/phase_template_builder/phase_template_builder_controller.dart'
    as _i261;
import 'package:base_project/layers/presentation/widgets/scanner_list_builder/scanner_list_builder_controller.dart'
    as _i813;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    final appModule = _$AppModule();
    gh.singleton<_i483.AppLoadingBuilderController>(
        () => _i483.AppLoadingBuilderController());
    gh.singleton<_i193.DeeplinkController>(() => _i193.DeeplinkController());
    gh.singleton<_i361.Interceptor>(
      () => _i860.ApiCookieIntercepter(),
      instanceName: 'api_cookie_intercepter',
    );
    gh.singleton<_i361.Dio>(() => networkModule
        .getDio(gh<_i361.Interceptor>(instanceName: 'api_cookie_intercepter')));
    gh.singleton<_i361.Dio>(
      () => networkModule.getDioGithub(),
      instanceName: 'github_dio',
    );
    gh.singleton<_i361.Interceptor>(
      () => _i184.GithubAuthenticationIntercepter(),
      instanceName: 'github_authentication',
    );
    gh.singleton<_i792.ApiClient>(
        () => networkModule.getApiClient(gh<_i361.Dio>()));
    gh.singleton<_i500.AccountInfoRepository>(
        () => _i793.AccountInfoRepositoryImpl(gh<_i792.ApiClient>()));
    gh.singleton<_i680.PhaseRepository>(
        () => _i218.PhaseRepositoryImpl(gh<_i792.ApiClient>()));
    gh.singleton<_i214.ArtifactRepository>(
        () => _i167.ArtifactRepositoryImpl(gh<_i792.ApiClient>()));
    gh.singleton<_i144.AccountManagerController>(() =>
        _i144.AccountManagerController(gh<_i500.AccountInfoRepository>()));
    gh.factory<_i258.AccountListBuilderController>(() =>
        _i258.AccountListBuilderController(gh<_i500.AccountInfoRepository>()));
    gh.singleton<_i630.ActivityHistoryRepository>(
        () => _i684.ActivityHistoryRepositoryImpl(gh<_i792.ApiClient>()));
    gh.singleton<_i241.TicketRepository>(
        () => _i911.TicketRepositoryImpl(gh<_i792.ApiClient>()));
    gh.singleton<_i146.ScannerInfoRepository>(
        () => _i836.ScannerInfoRepositoryImpl(gh<_i792.ApiClient>()));
    gh.singleton<_i194.ProjectInfoRepository>(
        () => _i279.ProjectInfoRepositoryImpl(gh<_i792.ApiClient>()));
    gh.singleton<_i32.VulnerabilityRepository>(
        () => _i1054.VulnerabilityRepositoryImpl(gh<_i792.ApiClient>()));
    gh.singleton<_i361.Dio>(
      () => networkModule.getDioGithubApi(
          gh<_i361.Interceptor>(instanceName: 'github_authentication')),
      instanceName: 'github_api_dio',
    );
    gh.singleton<_i50.GithubClient>(() => networkModule
        .getGithubClient(gh<_i361.Dio>(instanceName: 'github_dio')));
    await gh.factoryAsync<List<dynamic>>(
      () => appModule.createGlobalControllers(
        gh<_i193.DeeplinkController>(),
        gh<_i144.AccountManagerController>(),
      ),
      preResolve: true,
    );
    gh.factory<_i813.ScannerListBuilderController>(() =>
        _i813.ScannerListBuilderController(gh<_i146.ScannerInfoRepository>()));
    gh.factory<_i261.PhaseTemplateBuilderController>(() =>
        _i261.PhaseTemplateBuilderController(gh<_i680.PhaseRepository>()));
    gh.singleton<_i780.GithubApiClient>(() => networkModule
        .getGithubApiClient(gh<_i361.Dio>(instanceName: 'github_api_dio')));
    gh.singleton<_i717.AuthenticationRepository>(
        () => _i1051.AuthenticationRepositoryImpl(
              gh<_i792.ApiClient>(),
              gh<_i50.GithubClient>(),
              gh<_i780.GithubApiClient>(),
            ));
    gh.factory<_i877.DashboardController>(() => _i877.DashboardController(
          gh<_i144.AccountManagerController>(),
          gh<_i717.AuthenticationRepository>(),
        ));
    gh.factory<_i352.AccountRegisterController>(() =>
        _i352.AccountRegisterController(gh<_i717.AuthenticationRepository>()));
    gh.factory<_i737.LoginController>(() => _i737.LoginController(
          gh<_i717.AuthenticationRepository>(),
          gh<_i193.DeeplinkController>(),
          gh<_i144.AccountManagerController>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i165.NetworkModule {}

class _$AppModule extends _i847.AppModule {}
