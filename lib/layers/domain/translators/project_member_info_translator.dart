import 'package:base_project/layers/data/response/project_member_info_response.dart';
import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/translators/task_info_translator.dart';
import 'package:base_project/utils/utils.dart';

import 'account_info_translator.dart';

extension ProjectMemberInfoTranslator on ProjectMemberInfoResponse {
  ProjectMemberInfoModel toProjectMemberInfoModel() => ProjectMemberInfoModel(
        activityHistory: activityHistory ?? [],
        memberId: sId ?? Utils.generateId,
        projectIn: projectIn ?? [],
        taskAssigned:
            taskAssigned?.map((e) => e.toTaskInfoModel()).toList() ?? [],
        ticketAssigned: ticketAssigned ?? [],
        account: account?.toAccountInfoModel(),
        name: name,
      );
}
