import 'package:base_project/layers/data/response/workflow_info_response.dart';
import 'package:base_project/layers/domain/entities/workflow_info_model.dart';

import '../../../utils/utils.dart';

extension WorkflowInfoTranslator on WorkflowInfoResponse {
  WorkflowInfoModel toWorkflowInfoModel() => WorkflowInfoModel(
        name: name ?? '',
        path: path ?? '',
        content: content ?? '',
        totalRuns: totalRuns ?? 0,
        runs: runs
                ?.map(
                  (e) => WorkflowRunInfoModel(
                    id: e.id ?? Utils.generateId,
                    name: e.name ?? '',
                    createdAt: e.createdAt ?? DateTime.now(),
                    updatedAt: e.updatedAt,
                    status: e.status,
                    conclusion: e.conclusion,
                    event: e.event,
                    nodeId: e.nodeId,
                    path: e.path,
                    workflowId: e.workflowId,
                  ),
                )
                .toList() ??
            [],
        badgeUrl: badgeUrl,
        createdAt: createdAt,
        updatedAt: updatedAt,
        htmlUrl: htmlUrl,
        id: id,
        nodeId: nodeId,
        state: state,
        url: url,
      );
}
