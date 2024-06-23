import 'package:flutter/material.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';

showCustomDialog(context, {required String message, Color? backgroundColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      content: Text(
        message,
        style: getBodyStyle(color: AppColors.white),
      ),
      backgroundColor: backgroundColor ?? Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // width: 40,
    ),
  );
}

// showSucessDialog(context, {required String sucessMessage}) {
//   return ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         sucessMessage,
//         style: getBodyStyle(color: AppColors.white),
//       ),
//       backgroundColor: AppColors.lightPink,
//     ),
//   );
// }

// showLoadingDialog(context) {
//   return showDialog(
//     barrierColor: AppColors.black.withOpacity(0.7),
//     barrierDismissible: false,
//     context: context,
//     builder: (context) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // SvgPicture.asset('assets/on2.svg', height: 100, width: 100,fit: BoxFit.cover), //Image.memory(bytes)
//         Lottie.asset('assets/loading.json',
//               height: 150, width: 150, fit: BoxFit.cover),
//         ],
//       );
//     },
//   );
// }
