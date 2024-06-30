import 'package:intl/intl.dart';

import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

String getDifferentTime(int timeDiff) {
  final seconds = timeDiff ~/ 1000;
  final minutes = seconds ~/ 60;
  final hours = minutes ~/ 60;
  final days = hours ~/ 24;
  final weeks = days ~/ 7;

  if (seconds < 60) {
    return '$seconds ${localeLang.secondsAgo}';
  } else if (minutes < 60) {
    return '$minutes ${localeLang.minutesAgo}';
  } else if (hours < 24) {
    return '$hours ${localeLang.hoursAgo}';
  } else if (days < 7) {
    return '$days ${localeLang.daysAgo}';
  } else {
    return '$weeks ${localeLang.weeksAgo}';
  }
}

String convertDateTime(String input) {
  final parsedDate = DateTime.parse(input);
  final formattedDate =
      DateFormat('HH:mm dd/MM/yyyy').format(parsedDate.toLocal());
  return formattedDate;
}
