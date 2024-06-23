import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:training_book_store/features/profile/presentation/view_model/profile_states.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  var formKey = GlobalKey<FormState>();

  bool isVisible1 = true;
  bool isVisible3 = true;
  bool isVisible2 = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: AppColors.purple,
                size: 35,
              )),
        ),
        body: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is ChangePasswordSuccessState) {
              showCustomDialog(context,
                  message: "Change Password Successfully",
                  backgroundColor: AppColors.purple);
              pop(context);
            } else if (state is ChangePasswordErrorState) {
              showCustomDialog(
                context,
                message: "Change Password Failed",
              );
            }
          },
          builder: (context, state) {
            var cubit = ProfileCubit().object(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Change Password',
                        style: getTitleStyle(fontSize: 26),
                      ),
                      const Gap(35),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible1 = !isVisible1;
                                });
                              },
                              icon: (isVisible1)
                                  ? const Icon(Icons.remove_red_eye_outlined)
                                  : const Icon(
                                      Icons.visibility_off_rounded,
                                      color: AppColors.purple,
                                    )),
                          hintText: 'current password',
                          hintStyle: getBodyStyle(color: AppColors.grey),
                        ),
                        controller: cubit.passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        obscureText: isVisible1,
                      ),
                      ////////////////////////////////////////////////////////////////////////////////////
                      const Gap(30),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible2 = !isVisible2;
                                });
                              },
                              icon: (isVisible2)
                                  ? const Icon(Icons.remove_red_eye_outlined)
                                  : const Icon(
                                      Icons.visibility_off_rounded,
                                      color: AppColors.purple,
                                    )),
                          hintText: 'new password',
                          hintStyle: getBodyStyle(color: AppColors.grey),
                        ),
                        controller: cubit.newPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        obscureText: isVisible2,
                      ),

                      //////////////////////////////////////////////////////////////////////////////////////////
                      const Gap(30),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible3 = !isVisible3;
                                });
                              },
                              icon: (isVisible3)
                                  ? const Icon(Icons.remove_red_eye_outlined)
                                  : const Icon(
                                      Icons.visibility_off_rounded,
                                      color: AppColors.purple,
                                    )),
                          hintText: 'Password Confirmation',
                          hintStyle: getBodyStyle(color: AppColors.grey),
                        ),
                        controller: cubit.passwordConfirmController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        obscureText: isVisible3,
                      ),
                      const Gap(70),
                      CustomElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.changePassword();
                          }
                        },
                        width: 300,
                        child: (state is ChangePasswordLoadingState)
                            ? const CircularProgressIndicator(
                                color: AppColors.white,
                              )
                            : Text(
                                'Change Password',
                                style: getBodyStyle(color: AppColors.white),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
