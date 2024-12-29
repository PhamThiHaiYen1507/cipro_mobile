import 'package:base_project/layers/data/response/ticket_response.dart';
import 'package:base_project/layers/domain/translators/project_member_info_translator.dart';
import 'package:base_project/layers/domain/translators/vulnerability_translator.dart';
import 'package:base_project/utils/utils.dart';

import '../entities/ticket_model.dart';

extension TicketTranslator on TicketResponse {
  TicketModel toTicketModel() => TicketModel(
        id: id ?? Utils.generateId,
        title: title,
        description: description,
        status: status,
        priority: priority,
        createdAt: createdAt ?? DateTime.now(),
        targetedVulnerability: targetedVulnerability
                ?.map((e) => e.toVulnerabilityModel())
                .toList() ??
            [],
        assignee: assignee?.toProjectMemberInfoModel(),
        assigner: assigner?.toProjectMemberInfoModel(),
        projectName: projectName,
        updatedAt: updatedAt,
        createBy: createBy,
      );
}
