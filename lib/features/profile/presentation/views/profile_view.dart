// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/services/app_local_storage.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:training_book_store/features/profile/presentation/view_model/profile_states.dart';
import 'package:training_book_store/features/profile/presentation/views/update_profile_screen.dart';
import 'package:training_book_store/features/welcome/views/splash.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is DeleteProfileSuccessState) {
              Token.cacheBearerToken(token: '');
              AppLocalStorage.cacheData("name", "");
              AppLocalStorage.cacheData("email", "");
              AppLocalStorage.cacheData("image", "");
              pushAndRemoveUntil(context, const SplashView());
            } else if (state is DeleteProfileErrorState) {
              showCustomDialog(
                context,
                message: "Something went wrong, try again later",
              );
            }
          },
          builder: (context, state) {
              print(Token.getBearerToken());

            var cubit = ProfileCubit().object(context);
            if (state is GetProfileLoadingState ||
                state is DeleteProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetProfileErrorState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.grey,
                              blurRadius: 10,
                              offset: Offset(5, 5)),
                        ],
                        border: Border.all(color: AppColors.purple, width: 2.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            size: 50,
                            color: AppColors.purple,
                          ),
                          const Gap(25),
                          Text(
                            'an Error Occurred',
                            style: getTitleStyle(),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    CustomElevatedButton(
                      onPressed: () {
                        cubit.getProfile();
                      },
                      width: 300,
                      child: Text(
                        "ReFresh",
                        style: getTitleStyle(color: AppColors.white),
                      ),
                    )
                  ],
                ),
              );
            }
            return cubit.showProfile != null
                ? SafeArea(
                    child: ListView(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: double.infinity,
                              color: AppColors.purple,
                            ),
                            Positioned(
                                top: 18,
                                left: 10,
                                child: IconButton(
                                    onPressed: () {
                                      showDialogDeleteProfile(context,
                                          cubit: cubit);
                                    },
                                    icon: const Icon(
                                      Icons.delete_rounded,
                                      size: 32,
                                      color: AppColors.white,
                                    ))),
                            Positioned(
                                top: 20,
                                right: 10,
                                child: IconButton(
                                    onPressed: () {
                                      Token.cacheBearerToken(token: '');
                                      pushWithReplacement(
                                          context, const SplashView());
                                    },
                                    icon: const Icon(
                                      Icons.logout_sharp,
                                      size: 32,
                                      color: AppColors.white,
                                    ))),
                            Positioned(
                              bottom: -60,
                              right: 5,
                              left: 5,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: AppColors.white,
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundImage: NetworkImage(
                                    cubit.showProfile!.data!.image!,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Gap(MediaQuery.of(context).size.height * 0.08),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account information',
                                style: getTitleStyle(color: AppColors.purple),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        push(context,
                                            const UpdateProfileScreen());
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: AppColors.purple,
                                      ))),
                              //////////////////name
                              Text(
                                'Name',
                                style: getBodyStyle(fontSize: 20),
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_2_sharp,
                                    color: AppColors.purple,
                                    size: 35,
                                  ),
                                  const Gap(15),
                                  Text(
                                    cubit.showProfile!.data!.name!,
                                    style: getBodyStyle(),
                                  ),
                                ],
                              ),
                              /////////////////////email
                              const Gap(20),
                              Text(
                                'Email',
                                style: getBodyStyle(fontSize: 20),
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.email,
                                    color: AppColors.purple,
                                    size: 35,
                                  ),
                                  const Gap(15),
                                  Text(
                                    cubit.showProfile!.data!.email!,
                                    style: getBodyStyle(),
                                  ),
                                ],
                              ),
                              ///////////////////address
                              const Gap(20),
                              Text(
                                'Address',
                                style: getBodyStyle(fontSize: 20),
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: AppColors.purple,
                                    size: 35,
                                  ),
                                  const Gap(15),
                                  Text(
                                    cubit.showProfile?.data?.address ??
                                        'add address',
                                    style: getBodyStyle(),
                                  ),
                                ],
                              ),
                              ////////////////////city
                              const Gap(20),
                              Text(
                                'City',
                                style: getBodyStyle(fontSize: 20),
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_city_rounded,
                                    color: AppColors.purple,
                                    size: 35,
                                  ),
                                  const Gap(15),
                                  Text(
                                    cubit.showProfile?.data?.city ?? 'add city',
                                    style: getBodyStyle(),
                                  ),
                                ],
                              ),
                              const Gap(20),
                              Text(
                                'Phone',
                                style: getBodyStyle(fontSize: 20),
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: AppColors.purple,
                                    size: 35,
                                  ),
                                  const Gap(15),
                                  Text(
                                    cubit.showProfile?.data?.phone ??
                                        'add phone',
                                    style: getBodyStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border:
                                Border.all(color: AppColors.purple, width: 2)),
                        height: 100,
                        width: 250,
                        child: Text(
                          'There is no profile',
                          style: getBodyStyle(),
                        )));
          },
        ),
      ),
    );
  }

  showDialogDeleteProfile(BuildContext context, {required ProfileCubit cubit}) {
    var passwordController = TextEditingController();
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey1,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      'Enter The Password to Delete Your Account !!',
                      style:
                          getTitleStyle(color: AppColors.purple, fontSize: 20),
                    ),
                    const Gap(25),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: getBodyStyle(color: AppColors.purple),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'you must enter this field';
                        }
                        return null;
                      },
                    ),
                    const Gap(25),
                    CustomElevatedButton(
                      width: 120,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: AppColors.purple,
                      onPressed: () {
                        if (formKey1.currentState!.validate()) {
                          cubit.deleteProfile(
                              password: passwordController.text);

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Delete',
                        style: getTitleStyle(color: AppColors.white),
                      ),
                    )
                  ]),
                )));
      },
    );
  }
}
