import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'deeplink_controller.g.dart';

@singleton
class DeeplinkController = _DeeplinkControllerBase with _$DeeplinkController;

abstract class _DeeplinkControllerBase with Store {
  @observable
  Uri? deeplink;

  _DeeplinkControllerBase() {
    final appLinks = AppLinks();

    appLinks.uriLinkStream.listen(
      (event) {
        deeplink = event;
      },
    );
  }
}
