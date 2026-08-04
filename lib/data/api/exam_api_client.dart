import 'package:dio/dio.dart';
import 'package:exam_mobile_app/core/network/api_constant.dart';
import 'package:exam_mobile_app/data/models/exam_question_response.dart';
import 'package:exam_mobile_app/data/models/user_response.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'exam_api_client.g.dart';

@singleton
@RestApi(baseUrl: baseUrl)
abstract class ExamApiClient {
  @factoryMethod
  factory ExamApiClient(Dio dio) = _ExamApiClient;

  @POST("/api/v1/auth/signin")
  Future<UserResponse> login(@Body() Map<String, dynamic> body);

  @POST("/api/v1/auth/signup")
  Future<UserResponse> signUp(@Body() SignUpRequest request);

  @GET("/api/v1/questions")
  Future<ExamQuestionsResponse> getExamQuestions(@Query("exam") String examId);
}
