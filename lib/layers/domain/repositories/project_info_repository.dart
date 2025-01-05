import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/project_activity_info_model.dart';
import 'package:base_project/layers/domain/entities/project_from_thirdparty_model.dart';
import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/entities/workflow_info_model.dart';

abstract class ProjectInfoRepository {
  Future<ApiResponseData<List<ProjectInfoModel>?>> getProjects();

  Future<ApiResponseData<List<ProjectMemberInfoModel>?>> getProjectMembers(
      String projectName);

  Future<ApiResponseData<ProjectInfoModel?>> getProjectWithName(
      String projectName);

  Future<ApiResponseData<List<ProjectActivityInfoModel>?>> getProjectActivities(
      String projectName, String? username);

  Future<ApiResponseData<ProjectMemberInfoModel?>> getProjectMemberFromId(
      {String? memberId, String? accountId});

  Future<ApiResponseData<List<WorkflowInfoModel>?>> getProjectWorkflows(
      String projectName);

  Future<ApiResponseData<List<ProjectFromThirdPartyModel>?>>
      getProjectFromThirdParties();

  Future<ApiResponseData<bool>> importProject({
    String? name,
    String? owner,
    String? status,
    String? url,
  });

  Future<ApiResponseData<bool>> addMemberToProject({
    required String projectName,
    required String accountId,
  });

  Future<ApiResponseData<List<ProjectMemberInfoModel>>> getAllUser();

  Future<ApiResponseData<bool>> changeActionStatus({
    required String projectName,
    required String workflowId,
    required bool status,
  });
}
