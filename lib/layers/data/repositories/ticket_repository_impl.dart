import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/ticket_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';
import 'package:base_project/layers/domain/entities/ticket_model.dart';
import 'package:base_project/layers/domain/repositories/ticket_repository.dart';
import 'package:base_project/layers/domain/translators/activity_history_info_translator.dart';
import 'package:base_project/layers/domain/translators/ticket_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/vulnerability_model.dart';
import '../response/activity_history_info_response.dart';

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

  @override
  Future<ApiResponseData<bool>> createTicket(
      {String? assigneeId,
      String? description,
      String? priority,
      String? projectName,
      List<VulnerabilityModel> targetedVulnerability = const [],
      String? title}) async {
    try {
      await _client.createTicket({
        "data": {
          "title": title,
          "description": description,
          "priority": priority,
          "assignee": assigneeId,
          "targetedVulnerability":
              targetedVulnerability.map((e) => e.toJson()).toList(),
          "projectName": projectName
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<TicketModel?>> getTicket(String ticketId) async {
    try {
      final res = await _client.getTicket(ticketId);

      return Right(res.getBody(TicketResponse.fromJson)?.toTicketModel());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<ActivityHistoryInfoModel>?>> getTicketHistory(
      String ticketId) async {
    try {
      final res = await _client.getTicketHistory(ticketId);

      return Right(res
          .getItems(ActivityHistoryInfoResponse.fromJson)
          ?.map((e) => e.toActivityHistoryInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> updateTicket({
    required String ticketId,
    String? status,
    String? assigneeId,
  }) async {
    try {
      await _client.updateTicketStatus(ticketId, {
        'data': {if (status != null) 'status': status},
        'assigneeId': assigneeId,
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
