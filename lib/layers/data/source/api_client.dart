import 'package:base_project/layers/data/response/base_response.dart';
import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../request/login_request.dart';
import '../request/register_account_request.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/auth/login')
  Future<dynamic> login(
    @Body() LoginRequest request,
  );

  @POST('/account/reg')
  Future<dynamic> registerAccount(
    @Body() RegisterAccountRequest request,
  );

  @GET('/account/')
  Future<BaseResponse> getAccountInfo();

  @PATCH('/account/{account_id}')
  Future<BaseResponse> editAccount(@Path('account_id') String accountId,
      @Body() Map<String, AccountInfoModel> reuqest);

  @DELETE('/account/{account_id}')
  Future<BaseResponse> deleteAccount(@Path('account_id') String accountId);

  @GET('/user/project')
  Future<BaseResponse> getProjects();

  @GET('/account/list')
  Future<BaseResponse> getAccounts();

  @GET('/scanner')
  Future<BaseResponse> getScanners();

  @GET('/phase/template')
  Future<BaseResponse> getTemplates();

  @GET('/history?total=5')
  Future<BaseResponse> getHistories();

  @GET('/auth/logout')
  Future<BaseResponse> logout();

  @GET('/project/{projectName}')
  Future<BaseResponse> getProjectWithName(
    @Path('projectName') String projectName,
  );

  @GET('/project/{projectName}/member')
  Future<BaseResponse> getProjectMembers(
      @Path('projectName') String projectName);

  @GET('/activity/{projectName}')
  Future<BaseResponse> getProjectActivity(
    @Path('projectName') String projectName,
    @Query('username') String? username,
  );

  @GET('/user')
  Future<BaseResponse> getProjectMemberFromId(
    @Query('memberId') String? memberId,
    @Query('accountId') String? accountId,
  );

  @GET('/workflow')
  Future<BaseResponse> getProjectWorkflowWithName(
    @Query('projectName') String projectName,
  );

  @GET('/phase/{phaseId}')
  Future<BaseResponse> getPhase(@Path('phaseId') String phaseId);

  @GET('/ticket')
  Future<BaseResponse> getTickets(@Query('projectName') String projectName);

  @GET('/vuln/progress')
  Future<BaseResponse> getVulnProgress(
      @Query('projectName') String projectName);

  @GET('/artifact')
  Future<BaseResponse> getArtifacts(@Query('projectName') String projectName);

  @POST('/auth/mobile/github')
  Future<dynamic> loginWithGithub(@Body() Map<String, dynamic> body);

  @POST('/notification/token')
  Future<dynamic> setNotificationToken(@Body() Map<String, dynamic> body);

  @GET('/thirdParty/github/repo')
  Future<BaseResponse> getGithubRepos();

  @POST('/webhook/project')
  Future<BaseResponse> testProject(@Body() Map<String, dynamic> body);

  @POST('/project')
  Future<BaseResponse> importProject(@Body() Map<String, dynamic> body);

  @POST('/task')
  Future<BaseResponse> createNewTask(@Body() Map<String, dynamic> body);

  @PATCH('/phase/{phaseId}/task/add/{taskId}')
  Future<BaseResponse> addTaskToPhase(
    @Path('phaseId') String phaseId,
    @Path('taskId') String taskId,
  );

  @GET('/task')
  Future<BaseResponse> getTasks({
    @Query('projectName') String? projectName,
    @Query('filter') String? filter,
  });

  @PATCH('/phase/{phaseId}/artifact/add')
  Future<BaseResponse> createArtifact({
    @Path('phaseId') required String phaseId,
    @Body() required Map<String, dynamic> body,
  });

  @PATCH('/phase/{phaseId}/artifact/delete/{artifactId}')
  Future<BaseResponse> deleteArtifact(
    @Path('phaseId') String phaseId,
    @Path('artifactId') String artifactId,
  );

  @PATCH('/phase/{phaseId}/task/delete/{taskId}')
  Future<BaseResponse> deleteTask(
    @Path('phaseId') String phaseId,
    @Path('taskId') String taskId,
  );

  @PATCH('/artifact/{artifactId}')
  Future<BaseResponse> updateArtifact({
    @Path('artifactId') required String artifactId,
    @Body() required Map<String, dynamic> body,
  });

  @POST('/threat')
  Future<BaseResponse> createThreat(@Body() Map<String, dynamic> body);

  @GET('/threat')
  Future<BaseResponse> getThreats();

  @POST('/ticket')
  Future<BaseResponse> createTicket(@Body() Map<String, dynamic> body);

  @GET('/ticket/{ticketId}')
  Future<BaseResponse> getTicket(@Path('ticketId') String ticketId);

  @GET('/history/{ticketId}')
  Future<BaseResponse> getTicketHistory(@Path('ticketId') String ticketId);

  @PATCH('/ticket/{ticketId}')
  Future<BaseResponse> updateTicketStatus(
      @Path('ticketId') String ticketId, @Body() Map<String, dynamic> body);

  @DELETE('/phase/template/{templateId}')
  Future<BaseResponse> deleteTemplate(@Path('templateId') String templateId);

  @POST('/phase/template')
  Future<BaseResponse> createPhaseTemplate(@Body() Map<String, dynamic> body);

  @PATCH('/phase/template/{templateId}')
  Future<BaseResponse> updatePhaseTemplate(
      @Path('templateId') String templateId, @Body() Map<String, dynamic> body);

  @PATCH('/project/{projectName}/member')
  Future<BaseResponse> addMemberToProject(
    @Path('projectName') String projectName,
    @Body() Map<String, dynamic> body,
  );

  @GET('/user/getAll')
  Future<BaseResponse> getAllUser();

  @GET('/notification')
  Future<BaseResponse> getNotifications();
}
