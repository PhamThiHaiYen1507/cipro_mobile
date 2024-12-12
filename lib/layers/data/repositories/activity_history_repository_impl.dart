import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/activity_history_info_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';
import 'package:base_project/layers/domain/repositories/activity_history_repository.dart';
import 'package:base_project/layers/domain/translators/activity_history_info_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ActivityHistoryRepository)
class ActivityHistoryRepositoryImpl implements ActivityHistoryRepository {
  final ApiClient _client;

  ActivityHistoryRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<List<ActivityHistoryInfoModel>?>>
      getActivityHistory() async {
    try {
      final res = await _client.getHistories();

      return Right(res
          .getItems(ActivityHistoryInfoResponse.fromJson)
          ?.map((e) => e.toActivityHistoryInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
