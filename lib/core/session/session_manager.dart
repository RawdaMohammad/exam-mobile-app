import 'package:injectable/injectable.dart';

@singleton
class SessionManager {
  String? token;

  void clear() {
    token = null;
  }
}