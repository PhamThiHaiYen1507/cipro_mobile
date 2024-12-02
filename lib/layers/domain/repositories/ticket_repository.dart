import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/ticket_model.dart';

abstract class TicketRepository {
  Future<ApiResponseData<List<TicketModel>?>> getTickets(String projectName);
}
