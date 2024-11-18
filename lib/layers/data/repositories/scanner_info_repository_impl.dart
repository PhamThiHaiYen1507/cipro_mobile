import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/scanner_info_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/repositories/scanner_info_repository.dart';
import 'package:base_project/layers/domain/translators/scanner_info_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/scanner_info_model.dart';

@Singleton(as: ScannerInfoRepository)
class ScannerInfoRepositoryImpl implements ScannerInfoRepository {
  final ApiClient _client;

  ScannerInfoRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<List<ScannerInfoModel>?>> getScanners() async {
    try {
      final res = await _client.getScanners();

      return Right(res
          .getItems(ScannerInfoResponse.fromJson)
          ?.map((e) => e.toScannerInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
