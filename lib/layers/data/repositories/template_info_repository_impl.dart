import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/template_info_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/template_info_model.dart';
import 'package:base_project/layers/domain/repositories/template_info_repository.dart';
import 'package:base_project/layers/domain/translators/template_info_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TemplateInfoRepository)
class TemplateInfoRepositoryImpl implements TemplateInfoRepository {
  final ApiClient _client;

  TemplateInfoRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<List<TemplateInfoModel>?>> getTemplateList() async {
    try {
      final res = await _client.getTemplates();

      return Right(res
          .getItems(TemplateInfoResponse.fromJson)
          ?.map((e) => e.toTemplateInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
