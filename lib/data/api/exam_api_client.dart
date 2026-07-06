import 'package:dio/dio.dart';
import 'package:exam_mobile_app/core/network/api_constant.dart';
import 'package:retrofit/retrofit.dart';
part 'exam_api_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ExamApiClient {
  factory ExamApiClient(Dio dio) = _ExamApiClient;
}
