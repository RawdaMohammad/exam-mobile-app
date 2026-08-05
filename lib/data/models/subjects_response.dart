class SubjectsResponse {
  final String? message;
  final MetaData? metaData;
  final List<SubjectResponse>? subjects;

  const SubjectsResponse({this.message, this.metaData, this.subjects});

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) {
    return SubjectsResponse(
      message: json['message'],
      metaData: json['metadata'] != null
          ? MetaData.fromJson(json['metadata'])
          : null,
      subjects: json['subjects'] != null ?
          (json['subjects'] as List<dynamic>?)
              ?.map((e) => SubjectResponse.fromJson(e as Map<String, dynamic>))
              .toList() : [],
    );
  }
}

class SubjectResponse {
  final String id;
  final String name;
  final String icon;

  const SubjectResponse({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) =>
      SubjectResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      );
}

class MetaData {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;

  const MetaData({this.currentPage, this.numberOfPages, this.limit});

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    currentPage: json['currentPage'] as int?,
    numberOfPages: json['numberOfPages'] as int?,
    limit: json['limit'] as int?,
  );
}