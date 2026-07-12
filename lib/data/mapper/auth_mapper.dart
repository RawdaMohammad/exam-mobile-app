import 'package:exam_mobile_app/data/models/user_response.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthMapper {
  UserEntity toEntity(UserResponse response) {
    return UserEntity(
      id: response.user?.id ?? "",
      username: response.user?.username ?? "",
      firstName: response.user?.firstName ?? "",
      lastName: response.user?.lastName ?? "",
      email: response.user?.email ?? "",
      password: response.user?.password ?? "",
      rePassword: response.user?.rePassword ?? "",
      phone: response.user?.phone ?? "",
      isVerified: response.user?.isVerified ?? false,
    );
  }
}



