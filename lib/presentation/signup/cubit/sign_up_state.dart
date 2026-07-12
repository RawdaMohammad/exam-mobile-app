import 'package:exam_mobile_app/domain/entities/user_entity.dart';

abstract class SignUpState {
  UserEntity user;

  SignUpState(this.user);

}