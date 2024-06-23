
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_book_store/core/services/app_local_storage.dart';
import 'package:training_book_store/core/services/dio_helper/bloc_observer.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/notification_services.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/features/welcome/views/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices().init();
  AppLocalStorage.init();
  DioHelper.init();
  Bloc.observer= MyBlocObserver();
  Token.init();
  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      const SplashView(),
      theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          inputDecorationTheme: const InputDecorationTheme(
            border: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.grey, style: BorderStyle.solid),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.grey, style: BorderStyle.solid),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.grey, style: BorderStyle.solid),
            ),
          )),
    ),
    );
  }
}
