import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

showSnackbar(String title, String message) {
  Get.closeAllSnackbars();
  Get.snackbar(title, message);
}
