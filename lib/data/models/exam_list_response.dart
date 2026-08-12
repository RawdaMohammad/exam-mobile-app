import 'package:exam_mobile_app/data/models/exam_question_response.dart';

class ExamListResponse {
  final String message;
  final MetadataResponse metadata;
  final List<ExamListItemResponse> exams;

  const ExamListResponse({
    required this.message,
    required this.metadata,
    required this.exams,
  });

  factory ExamListResponse.fromJson(Map<String, dynamic> json) {
    return ExamListResponse(
      message: json['message'] ?? '',
      metadata: MetadataResponse.fromJson(json['metadata'] ?? {}),
      exams: (json['exams'] as List? ?? [])
          .map((e) => ExamListItemResponse.fromJson(e))
          .toList(),
    );
  }
}
class MetadataResponse {
  final int currentPage;
  final int numberOfPages;
  final int limit;

  const MetadataResponse({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
  });

  factory MetadataResponse.fromJson(Map<String, dynamic> json) {
    return MetadataResponse(
      currentPage: json['currentPage'] ?? 0,
      numberOfPages: json['numberOfPages'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}
class ExamListItemResponse extends ExamResponse {
  final bool active;
  final DateTime createdAt;

  const ExamListItemResponse({
    required super.id,
    required super.title,
    required super.duration,
    required super.subject,
    required super.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });

  factory ExamListItemResponse.fromJson(Map<String, dynamic> json) {
    return ExamListItemResponse(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      duration: json['duration'] ?? 0,
      subject: json['subject'] ?? '',
      numberOfQuestions: json['numberOfQuestions'] ?? 0,
      active: json['active'] ?? false,
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}