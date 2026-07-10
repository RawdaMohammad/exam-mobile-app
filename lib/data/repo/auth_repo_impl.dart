import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/core/network/safe_call.dart';
import 'package:exam_mobile_app/data/datasource/contract/auth_datasource.dart';
import 'package:exam_mobile_app/data/mapper/auth_mapper.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:exam_mobile_app/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDatasource datasource;
  final AuthMapper mapper;

  AuthRepoImpl(this.datasource, this.mapper);

  @override
  Future<ApiResults<UserEntity>> login(UserEntity login) {
    return safeCall(() async {
      final response = await datasource.login(login.email, login.password);

      return Success(mapper.toEntity(response));
    });
  }
}
