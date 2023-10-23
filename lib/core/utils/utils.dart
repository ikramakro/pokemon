import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

errorSnackBar(String message) {
  return Get.snackbar('Error', message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(Icons.error));
}

successSnackBar(String message) {
  return Get.snackbar('Success', message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(Icons.done));
}

Widget getSvgImage({
  required String imageName,
  double? height,
  double? width,
  Color? imageColor,
  BoxFit fit = BoxFit.contain,
}) {
  return imageColor != null
      ? SvgPicture.network(
          imageName,
          height: height ?? 20,
          width: width ?? 20,
          colorFilter: ColorFilter.mode(imageColor, BlendMode.srcIn),
          fit: fit,
        )
      : SvgPicture.network(
          imageName,
          height: height ?? 20,
          width: width ?? 20,
          fit: fit,
        );
}
