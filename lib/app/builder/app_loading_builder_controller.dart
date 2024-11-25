import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'app_loading_builder_controller.g.dart';

@singleton
class AppLoadingBuilderController = _AppLoadingBuilderControllerBase
    with _$AppLoadingBuilderController;

abstract class _AppLoadingBuilderControllerBase with Store {
  @observable
  bool isLoading = false;

  @action
  void setLoading(bool value) => isLoading = value;
}
