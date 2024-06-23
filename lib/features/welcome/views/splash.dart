import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/widgets/navigation_bar_view.dart';
import 'package:training_book_store/features/welcome/views/welcome.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        pushWithReplacement(
            context,
            Token.getBearerToken() == null || Token.getBearerToken() == ''
                ? const WelcomeView()
                : const NavigationBarView());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child:const RiveAnimation.asset(
                    'assets/loading_book.riv',
                    fit: BoxFit.cover,
                  ))),
        ],
      ),
    );
  }
}
