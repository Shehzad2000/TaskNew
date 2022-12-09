
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'system_report_event.dart';
part 'system_report_state.dart';

class SystemReportBloc extends Bloc<SystemReportEvent, SystemReportState> {
  SystemReportBloc() : super(SystemReportInitial()) {
    on<SystemReportEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
