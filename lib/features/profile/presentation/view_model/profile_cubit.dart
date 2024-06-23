// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_book_store/core/services/app_local_storage.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/profile_endpoints.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/features/profile/data/model/profile_model/profile_model.dart';
import 'package:training_book_store/features/profile/presentation/view_model/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitState());

  ProfileCubit object(context) => BlocProvider.of(context);

  ProfileModel? showProfile;
  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();

//get profile
  getProfile() {
    emit(GetProfileLoadingState());
    DioHelper.getData(
            url: ProfileEndPoints.showProduct,
            query: {},
            token: Token.getBearerToken())
        .then((value) {
      showProfile = ProfileModel.fromJson(value.data);
      emit(GetProfileSuccessState());
    }).catchError((onError) {
      emit(GetProfileErrorState());
    });
  }

  //update profile
  updateProfileInfo({required String city, required File fileImage}) async {
    emit(UpdateProfileLoadingState());
    DioHelper.postData(
            url: ProfileEndPoints.updateProfile,
            data: {
              "name": nameController.text,
              "address": addressController.text,
              "city": city,
              "phone": phoneController.text,
              "image": await MultipartFile.fromFile(fileImage.path),
             
            },
            token: Token.getBearerToken())
        .then((value) {
      AppLocalStorage.cacheData("image", value.data["data"]["image"]);
      AppLocalStorage.cacheData("name", value.data["data"]["name"]);

      getProfile();
      emit(UpdateProfileSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateProfileErrorState());
    });
  }

//delete profile

  deleteProfile({required String password}) {
    emit(DeleteProfileLoadingState());
    DioHelper.postData(url: ProfileEndPoints.deleteAccount, data: {
      "current_password": password,
    }).then((value) {
      emit(DeleteProfileSuccessState());
    }).catchError((onError) {
      emit(DeleteProfileErrorState());
    });
  }

//change password

  changePassword() {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
      url: ProfileEndPoints.changePassword,
      data: {
        "current_password": passwordController.text,
        "new_password": newPasswordController.text,
        "new_password_confirmation": passwordConfirmController.text
      },
      token: Token.getBearerToken(),
    ).then((value) {
      emit(ChangePasswordSuccessState());
    }).catchError((onError) {
      emit(ChangePasswordErrorState());
    });
  }

  //contact us

  contactUs(
      {required String name,
      required String email,
      required String subject,
      required String message}) {
    emit(ContactUsLoadingState());
    DioHelper.postData(
      url: ProfileEndPoints.contactUs,
      data: {
        "name": name,
        "email": email,
        "subject": subject,
        "message": message
      },
    ).then((value) {
      emit(ContactUsSuccessState());
    }).catchError((onError) {
      emit(ContactUsErrorState());
    });
  }

// Future uploadOnlyImage() async {
//     emit(UploadLoadingState());
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//     );
//     fileImage = File(result?.files.single.path ?? "");
//     emit(UploadSuccessState());
//   }
}
