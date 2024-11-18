import 'package:base_project/layers/data/response/scanner_info_response.dart';
import 'package:base_project/layers/domain/entities/scanner_info_model.dart';

extension ScannerInfoTranslator on ScannerInfoResponse {
  ScannerInfoModel toScannerInfoModel() => ScannerInfoModel();
}
