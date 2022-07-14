import 'package:intl/intl.dart';

getDate({String? dates}) {
  String date = DateFormat("E dd MMM").format(DateTime.parse(dates!));
  return date;
}

getTime({String? times}) {
  String time = DateFormat.jm().format(DateTime.parse(times!));
  return time;
}
