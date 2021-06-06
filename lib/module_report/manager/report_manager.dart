import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_report/repository/report_repository.dart';
import 'package:pasco_shipping/module_report/request/report_request.dart';

@injectable
class ReportManager{
  final ReportRepository _repository;
  ReportManager(this._repository);

  Future<dynamic> createReport(ReportRequest request) => _repository.createReport(request);
}