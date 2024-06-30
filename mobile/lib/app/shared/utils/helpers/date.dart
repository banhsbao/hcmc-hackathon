import 'package:intl/intl.dart';

String getDifferentTime(String timeDiff) {
  final dateTime = DateTime.parse(timeDiff);
  final now = DateTime.now();
  final difference = dateTime.isAfter(now)
      ? dateTime.difference(now)
      : now.difference(dateTime);

  final seconds = difference.inSeconds;
  final minutes = difference.inMinutes;
  final hours = difference.inHours;
  final days = difference.inDays;
  final weeks = days ~/ 7;

  if (seconds < 60) {
    return '$seconds seconds ago';
  } else if (minutes < 60) {
    return '$minutes minutes ago';
  } else if (hours < 24) {
    return '$hours hours ago';
  } else if (days < 7) {
    return '$days days ago';
  } else {
    return '$weeks weeks ago';
  }
}

String convertDateTime(String input) {
  final parsedDate = DateTime.parse(input);
  final formattedDate =
      DateFormat('HH:mm dd/MM/yyyy').format(parsedDate.toLocal());
  return formattedDate;
}
