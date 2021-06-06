import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_report/manager/report_manager.dart';
import 'package:pasco_shipping/module_report/request/report_request.dart';

@injectable
class ReportService {
  final ReportManager _manager;
  ReportService(this._manager);

  Future<dynamic> createReport(int id, String reason) {
    return _manager.createReport(ReportRequest(id, reason));
  }
}
