import 'package:intl/intl.dart';

String formatTime(String time){
  final DateTime dateTime = DateFormat("h:mm").parse(time);

  return DateFormat('hh:mm a').format(dateTime);
}

String getMonthTime(String date) {

  if(date.isEmpty) return date;

  var dateFormat =
  DateFormat("MMM d, yyyy hh:mm a"); // you can change the format here
  var utcDate =
  dateFormat.format(DateTime.parse(date)); // pass the UTC time here
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  return dateFormat.format(DateTime.parse(localDate));
}

String speakDate(DateTime dateTime){
  final DateFormat formatter = DateFormat('EEE, MMM d');
  final String formatted = formatter.format(dateTime);

  return formatted;
}