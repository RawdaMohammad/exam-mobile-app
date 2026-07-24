import 'package:injectable/injectable.dart';

@injectable
class VerificationState {
  final String? resetCode;
  final bool isLoading;
  const VerificationState({this.resetCode, this.isLoading = false});

  VerificationState copyWith({String? resetCode, bool? isSuccess, bool? isLoading}) {
    return VerificationState(
      resetCode: resetCode ?? this.resetCode,
      isLoading: isLoading ?? this.isLoading
    );
  }
}