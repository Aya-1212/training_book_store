import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_book_store/core/services/app_local_storage.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/auth_end_points.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/features/auth/presentation/view_model/register_manager/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  RegisterCubit object(context) => BlocProvider.of(context);

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  register() {
    emit(RegisterLoadingState());
    DioHelper.postData(url: AuthEndPoints.register, data: {
      'name': name.text,
      'email': email.text,
      'password': password.text,
      'password_confirmation': passwordConfirm.text,
    }).then((value) {
      //cache token , name , image , email
      Token.cacheBearerToken(token: value.data["data"]["token"]);
      AppLocalStorage.cacheData("image", value.data["data"]["user"]["image"]);
      AppLocalStorage.cacheData("name", value.data["data"]["user"]["name"]);
      AppLocalStorage.cacheData("email", value.data["data"]["user"]["email"]);
      //state
      emit(RegisterSucessState());
    }).catchError((onError) {
      emit(RegisterErrorState(error: 'something went wrong'));
    });
  }
}
