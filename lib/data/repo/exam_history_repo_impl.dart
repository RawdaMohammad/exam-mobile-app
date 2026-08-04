import 'package:exam_mobile_app/data/datasource/contract/exam_history_local_datasource.dart';
import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_history_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamHistoryRepo)
class ExamHistoryRepoImpl
    implements ExamHistoryRepo {
  final ExamHistoryLocalDatasource _localDataSource;

  ExamHistoryRepoImpl(
    this._localDataSource,
  );

  @override
  Future<void> saveExamHistory(
    ExamHistoryEntity history,
  ) async {
    await _localDataSource.saveExamHistory(history);
  }

  @override
  Future<List<ExamHistoryEntity>> getExamHistory() async {
    return await _localDataSource.getExamHistory();
  }

  @override
  Future<void> clearExamHistory() async {
    await _localDataSource.clearExamHistory();
  }
}