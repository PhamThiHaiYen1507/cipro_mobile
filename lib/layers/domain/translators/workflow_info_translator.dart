import 'package:base_project/layers/data/response/workflow_info_response.dart';
import 'package:base_project/layers/domain/entities/workflow_info_model.dart';

extension WorkflowInfoTranslator on WorkflowInfoResponse {
  WorkflowInfoModel toWorkflowInfoModel() => WorkflowInfoModel(
        name: name ?? '',
        path: path ?? '',
        content: content ?? '',
      );
}
