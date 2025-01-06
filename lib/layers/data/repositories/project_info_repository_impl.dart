import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/project_activity_info_response.dart';
import 'package:base_project/layers/data/response/project_info_response.dart';
import 'package:base_project/layers/data/response/project_member_info_response.dart';
import 'package:base_project/layers/data/response/workflow_info_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/project_activity_info_model.dart';
import 'package:base_project/layers/domain/entities/project_from_thirdparty_model.dart';
import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/entities/workflow_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:base_project/layers/domain/translators/project_activity_info_translator.dart';
import 'package:base_project/layers/domain/translators/project_from_thirdparty_translator.dart';
import 'package:base_project/layers/domain/translators/project_info_translator.dart';
import 'package:base_project/layers/domain/translators/project_member_info_translator.dart';
import 'package:base_project/layers/domain/translators/workflow_info_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ProjectInfoRepository)
class ProjectInfoRepositoryImpl implements ProjectInfoRepository {
  final ApiClient _client;

  ProjectInfoRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<List<ProjectInfoModel>?>> getProjects() async {
    try {
      final res = await _client.getProjects();

      return Right(res
          .getItems(ProjectInfoResponse.fromJson)
          ?.map((e) => e.toProjectInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<ProjectInfoModel?>> getProjectWithName(
      String projectName) async {
    try {
      final res =
          await _client.getProjectWithName(Uri.encodeComponent(projectName));

      return Right(
          res.getBody(ProjectInfoResponse.fromJson)?.toProjectInfoModel());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<ProjectMemberInfoModel>?>> getProjectMembers(
      String projectName) async {
    try {
      final res =
          await _client.getProjectMembers(Uri.encodeComponent(projectName));

      return Right(res
          .getItems(ProjectMemberInfoResponse.fromJson)
          ?.map((e) => e.toProjectMemberInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<ProjectActivityInfoModel>?>> getProjectActivities(
      String projectName, String? username) async {
    try {
      final res = await _client.getProjectActivity(
        Uri.encodeComponent(projectName),
        username,
      );

      return Right(res
          .getItems(ProjectActivityInfoResponse.fromJson)
          ?.map((e) => e.toProjectActivityInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<ProjectMemberInfoModel?>> getProjectMemberFromId(
      {String? memberId, String? accountId}) async {
    try {
      final res = await _client.getProjectMemberFromId(memberId, accountId);

      return Right(res
          .getBody(ProjectMemberInfoResponse.fromJson)
          ?.toProjectMemberInfoModel());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<WorkflowInfoModel>?>> getProjectWorkflows(
      String projectName) async {
    try {
      final res = await _client.getProjectWorkflowWithName(projectName);

      return Right(res
          .getItems(WorkflowInfoResponse.fromJson)
          ?.map((e) => e.toWorkflowInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<ProjectFromThirdPartyModel>?>>
      getProjectFromThirdParties() async {
    try {
      final res = await _client.getGithubRepos();

      return Right(res
          .getItems(ProjectFromThirdPartyModel.fromJson)
          ?.map((e) => e.toProjectFromThirdPartyModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> importProject(
      {String? name, String? owner, String? status, String? url}) async {
    try {
      await _client.importProject({
        'data': {
          'type': 'import',
          'data': {'name': name, 'owner': owner, 'status': status, 'url': url}
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> addMemberToProject(
      {required String projectName, required String accountId}) async {
    try {
      await _client.addMemberToProject(Uri.encodeComponent(projectName), {
        'data': {'accountId': accountId}
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<ProjectMemberInfoModel>>> getAllUser() async {
    try {
      final res = await _client.getAllUser();

      return Right(res
              .getItems(ProjectMemberInfoResponse.fromJson)
              ?.map((e) => e.toProjectMemberInfoModel())
              .toList() ??
          []);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> changeActionStatus(
      {required String projectName,
      required String workflowId,
      required bool status}) async {
    try {
      await _client.changeActionStatus({
        'projectName': projectName,
        'workflowId': workflowId,
        'status': status,
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
