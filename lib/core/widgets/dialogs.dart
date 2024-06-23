import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';

showLoadingDialog(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
            //  const Gap(25),
              const CircularProgressIndicator(),
              const Gap(25),
              Text(
                "Loading...",
                style: getTitleStyle(fontSize: 20 ),
              ),
             // const Gap(25),
            ],
          ),
        ),
      );
    },
    barrierColor: AppColors.purple.withOpacity(0.3),
    barrierDismissible: false,
  );
}
