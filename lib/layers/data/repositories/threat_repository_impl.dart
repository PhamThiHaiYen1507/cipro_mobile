import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/threat_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/threat_model.dart';
import 'package:base_project/layers/domain/repositories/threat_repository.dart';
import 'package:base_project/layers/domain/translators/threat_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ThreatRepository)
class ThreatRepositoryImpl implements ThreatRepository {
  final ApiClient _client;

  ThreatRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<bool>> createNewThreat(
      {required String name,
      required String description,
      required String type,
      required double total,
      required int damage,
      required int reproducibility,
      required int exploitability,
      required int affectedUsers,
      required int discoverability}) async {
    try {
      await _client.createThreat({
        "data": {
          "name": name,
          "description": description,
          "type": type,
          "score": {
            "total": total,
            "details": {
              "damage": damage,
              "reproducibility": reproducibility,
              "exploitability": exploitability,
              "affectedUsers": affectedUsers,
              "discoverability": discoverability
            }
          }
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<ThreatModel>>> getThreats() async {
    try {
      final res = await _client.getThreats();

      return Right(res
              .getItems(ThreatResponse.fromJson)
              ?.map((e) => e.toThreatModel())
              .toList() ??
          []);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
