import 'package:base_project/layers/data/response/activity_history_info_response.dart';
import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';
import 'package:base_project/utils/utils.dart';

extension ActivityHistoryInfoTranslator on ActivityHistoryInfoResponse {
  ActivityHistoryInfoModel toActivityHistoryInfoModel() =>
      ActivityHistoryInfoModel(
        id: id ?? Utils.generateId,
        account: account,
        action: account,
        description: description,
        objectId: objectId,
        timestamp: timestamp,
      );
}
