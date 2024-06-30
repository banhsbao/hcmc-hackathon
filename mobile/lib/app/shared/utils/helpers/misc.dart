import 'package:get/get.dart';

import '../ui_utils.dart';

bool isNullOrEmpty(dynamic input) {
  return input is String
      ? input.trim().isEmpty
      : GetUtils.isNullOrBlank(input) ?? true;
}

String isTitleEmpty(String? input, {String? errorMessage}) {
  return isNullOrEmpty(input) ? errorMessage ?? localeLang.none : input!;
}

bool isNullOrZero(dynamic input) {
  return input == null ||
      (input is String && (input.trim() == '0' || input.isEmpty)) ||
      input == 0;
}

double handleChangeInputNumberDouble(String? input, String type) {
  return handleChangeInputNumber(input, type, 0.1);
}

double handleChangeInputNumberInt(String? input, String type) {
  return handleChangeInputNumber(input, type, 1);
}

double handleChangeInputNumber(String? input, String type, double increment) {
  try {
    if (input == null || input.isEmpty) {
      return type == 'INCREASE' ? increment : 0;
    }

    final inputValue = double.tryParse(input);
    if (inputValue == null) {
      return 0;
    }

    switch (type) {
      case 'INCREASE':
        return inputValue + increment;
      case 'DECREASE':
        return inputValue == 0 ? 0 : inputValue - increment;
      default:
        return 0;
    }
  } catch (e) {
    return 0;
  }
}

extension IterableExtensions<E> on Iterable<E> {
  Iterable<List<E>> chunked(int chunkSize) sync* {
    if (length <= 0) {
      yield [];
      return;
    }
    var skip = 0;
    while (skip < length) {
      final chunk = this.skip(skip).take(chunkSize);
      yield chunk.toList(growable: false);
      skip += chunkSize;
      if (chunk.length < chunkSize) return;
    }
  }
}
