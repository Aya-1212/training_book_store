import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_book_store/core/constants/assets_icons.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/features/auth/presentation/view/authentication_view/sign_in.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/gradient-old-device-studio.jpg",
           // AssetsImages.splash,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover
          ),
          Positioned(
            top: 100,
            right: 25,
            left: 25,
            child: Column(
              children: [
                SvgPicture.asset(
                  AssetsIcons.book,
                  height: 70,
                  colorFilter:
                      const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
              
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            right: 25,
            left: 25,
            child: GestureDetector(
              onTap: () {
                pushWithReplacement(context, const SignInView());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(4, 4)),
                    ],
                    border: Border.all(color: AppColors.black, width: 1),
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Get Started',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SvgPicture.asset(
                      AssetsIcons.arrow,
                      height: 60,
                      width: 90,
                      colorFilter: const ColorFilter.mode(
                          AppColors.black, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
