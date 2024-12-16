import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';
import 'package:base_project/layers/domain/entities/ticket_model.dart';

import '../entities/vulnerability_model.dart';

abstract class TicketRepository {
  Future<ApiResponseData<List<TicketModel>?>> getTickets(String projectName);

  Future<ApiResponseData<List<ActivityHistoryInfoModel>?>> getTicketHistory(
      String ticketId);

  Future<ApiResponseData<bool>> createTicket({
    String? assigneeId,
    String? description,
    String? priority,
    String? projectName,
    List<VulnerabilityModel> targetedVulnerability = const [],
    String? title,
  });

  Future<ApiResponseData<TicketModel?>> getTicket(String ticketId);
}
