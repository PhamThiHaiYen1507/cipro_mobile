import 'package:base_project/layers/domain/entities/scanner_info_model.dart';
import 'package:base_project/layers/domain/repositories/scanner_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'scanner_list_builder_controller.g.dart';

@injectable
class ScannerListBuilderController = _ScannerListBuilderControllerBase
    with _$ScannerListBuilderController;

abstract class _ScannerListBuilderControllerBase with Store {
  final ScannerInfoRepository _scannerInfoRepository;

  @observable
  List<ScannerInfoModel> scanners = [];

  _ScannerListBuilderControllerBase(this._scannerInfoRepository) {
    _fetchScannerList();
  }

  @action
  Future<void> _fetchScannerList() async {
    final res = await _scannerInfoRepository.getScanners();

    res.map((right) {
      if (right != null) scanners = right;
    });
  }
}
