import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/ticket_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/ticket_model.dart';
import 'package:base_project/layers/domain/repositories/ticket_repository.dart';
import 'package:base_project/layers/domain/translators/ticket_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TicketRepository)
class TicketRepositoryImpl extends TicketRepository {
  final ApiClient _client;

  TicketRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<List<TicketModel>?>> getTickets(
      String projectName) async {
    try {
      final res = await _client.getTickets(projectName);

      return Right(res
          .getItems(TicketResponse.fromJson)
          ?.map((e) => e.toTicketModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
