import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BaseController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isOverlayLoading = false.obs;
  RxString loadingText = 'Loading...'.obs;

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;
  void showOverlayLoading() => isOverlayLoading.value = true;
  void hideOverlayLoading() => isOverlayLoading.value = false;

  Future<T> fetchDataLoading<T>(
    Future<T> Function() fetchData, {
    int delay = 1000,
  }) =>
      _fetchData(fetchData, showLoading, hideLoading, delay);

  Future<T> fetchDataOverlayLoading<T>(
    Future<T> Function() fetchData, {
    int delay = 1000,
  }) =>
      _fetchData(fetchData, showOverlayLoading, hideOverlayLoading, delay);

  Future<T> _fetchData<T>(
    Future<T> Function() fetchData,
    VoidCallback showLoading,
    VoidCallback hideLoading,
    int delay,
  ) async {
    try {
      showLoading();
      final res = await fetchData();
      await Future.delayed(Duration(milliseconds: delay));
      return res;
    } finally {
      hideLoading();
    }
  }
}
