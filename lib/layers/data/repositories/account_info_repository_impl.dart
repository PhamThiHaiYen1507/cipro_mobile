import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/account_info_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/domain/repositories/account_info_repository.dart';
import 'package:base_project/layers/domain/translators/account_info_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AccountInfoRepository)
class AccountInfoRepositoryImpl implements AccountInfoRepository {
  final ApiClient _client;

  AccountInfoRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<AccountInfoModel?>> getAccountInfo() async {
    try {
      final res = await _client.getAccountInfo();

      return Right(
          res.getBody(AccountInfoResponse.fromJson)?.toAccountInfoModel());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<AccountInfoModel>?>> getAccountList() async {
    try {
      final res = await _client.getAccounts();

      return Right(res
          .getItems(AccountInfoResponse.fromJson)
          ?.map((e) => e.toAccountInfoModel())
          .toList());
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
