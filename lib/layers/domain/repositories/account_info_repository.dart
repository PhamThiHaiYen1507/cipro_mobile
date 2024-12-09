import 'package:base_project/core/type_def/api_response_data.dart';

import '../entities/account_info_model.dart';

abstract class AccountInfoRepository {
  Future<ApiResponseData<AccountInfoModel?>> getAccountInfo();

  Future<ApiResponseData<List<AccountInfoModel>?>> getAccountList();

  Future<ApiResponseData<bool>> editAccount(
      {required String accountId, required AccountInfoModel reuqest});

  Future<ApiResponseData<bool>> deleteAccount(String accountId);
}
