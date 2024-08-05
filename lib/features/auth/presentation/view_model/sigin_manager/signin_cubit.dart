import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_book_store/core/services/app_local_storage.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/auth_end_points.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/features/auth/presentation/view_model/sigin_manager/signin_states.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitState());

  SignInCubit object(context) => BlocProvider.of(context);

  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  final emailForgetPassword = TextEditingController();
  final pinController = TextEditingController();

  login() {
    emit(SignInLoadingState());
    DioHelper.postData(
        url: AuthEndPoints.signin,
        data: {'email': email.text, 'password': password.text}).then((value) {
      //cache token , name , image , email
      Token.cacheBearerToken(token: value.data["data"]["token"]);
      AppLocalStorage.cacheData("image", value.data["data"]["user"]["image"]);
      AppLocalStorage.cacheData("name", value.data["data"]["user"]["name"]);
      AppLocalStorage.cacheData("email", value.data["data"]["user"]["email"]);
      emit(SignInSucessState());
    }).catchError((onError) {
      emit(SignInErrorState(error: 'something went wrong'));
    });
  }

  forgetPassword() {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(url: AuthEndPoints.forgetPassword, data: {
      'email': emailForgetPassword.text,
    }).then((value) {
      emit(ForgetPasswordSucessState());
    }).catchError((onError) {
      emit(ForgetPasswordErrorState(error: 'something went wrong'));
    });
  }

  verifyCodeMethod() {
    emit(VerifyCodeLoadingState());
    DioHelper.postData(url: AuthEndPoints.verifyCode, data: {
      'verify_code': pinController.text,
    }).then((value) {
      emit(VerifyCodeSucessState());
    }).catchError((onError) {
      emit(VerifyCodeErrorState(error: 'The code is not correct'));
    });
  }

  resetPassword({required String verifyCode}) {
    emit(ResetPasswordLoadingState());
    DioHelper.postData(url: AuthEndPoints.resetPassword, data: {
      'verify_code': verifyCode,
      'new_password': password.text,
      'new_password_confirmation': passwordConfirm.text,
    }).then((value) {
      emit(ResetPasswordSucessState());
    }).catchError((onError) {
      emit(ResetPasswordErrorState(error: 'something went wrong'));
    });
  }

  // resendVerifyCode() {
  //   emit(ResendVerifyCodeLoadingState());
  //   DioHelper.getData(
  //           url: AuthEndPoints.resendVerifyCode,
  //           query: {},
  //           token: AppLocalStorage.getData('token'))
  //       .then((value) {
  //     emit(ResendVerifyCodeSucessState());
  //   }).catchError((onError) {
  //     emit(ResendVerifyCodeErrorState(error: 'something went wrong'));
  //   });
  // }
}
