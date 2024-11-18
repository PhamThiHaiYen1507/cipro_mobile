import 'package:base_project/core/type_def/api_response_data.dart';

import '../entities/scanner_info_model.dart';

abstract class ScannerInfoRepository {
  Future<ApiResponseData<List<ScannerInfoModel>?>> getScanners();
}
