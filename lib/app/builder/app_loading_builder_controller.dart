import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'app_loading_builder_controller.g.dart';

class LoadingOverlay {
  static void show() {
    MobxManager.get<AppLoadingBuilderController>().setLoading(true);
  }

  static void close() {
    MobxManager.get<AppLoadingBuilderController>().setLoading(false);
  }
}

@singleton
class AppLoadingBuilderController = _AppLoadingBuilderControllerBase
    with _$AppLoadingBuilderController;

abstract class _AppLoadingBuilderControllerBase with Store {
  @observable
  bool isLoading = false;

  @action
  void setLoading(bool value) => isLoading = value;
}
