// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/features/auth/presentation/view_model/sigin_manager/signin_cubit.dart';
import 'package:training_book_store/features/auth/presentation/view_model/sigin_manager/signin_states.dart';
import 'package:training_book_store/features/auth/presentation/view/authentication_view/sign_in.dart';

// ignore: must_be_immutable
class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.verify_code});

  final String verify_code;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  bool isVisible1 = true;
  bool isVisible2 = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignInCubit(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: BlocConsumer<SignInCubit, SignInStates>(
            listener: (context, state) {
              if (state is ResetPasswordErrorState) {
                showCustomDialog(context, message: state.error);
              } else if (state is ResetPasswordSucessState) {
                pushWithReplacement(context, const SignInView());
                showCustomDialog(context,
                  message: "Changed Password Successfully", backgroundColor: AppColors.purple);
              }
            },
            builder: (context, state) {
              var cubit = SignInCubit().object(context);
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Change Your Password',
                            style: getTitleStyle(fontSize: 21),
                          ),
                          const Gap(35),
                          TextFormField(
                            style: getBodyStyle(),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible1 = !isVisible1;
                                  });
                                },
                                icon: (isVisible1)
                                    ? const Icon(
                                        Icons.remove_red_eye_outlined,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_rounded,
                                        color: AppColors.purple,
                                      ),
                              ),
                              hintText: 'Password',
                              hintStyle: getBodyStyle(color: AppColors.grey),
                            ),
                            controller: cubit.password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field is required';
                              }
                              return null;
                            },
                            obscureText: isVisible1,
                            textInputAction: TextInputAction.next,
                          ),
                          const Gap(30),
                          TextFormField(
                            style: getBodyStyle(),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible2 = !isVisible2;
                                  });
                                },
                                icon: isVisible2
                                    ? const Icon(
                                        Icons.remove_red_eye_outlined,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_rounded,
                                        color: AppColors.purple,
                                      ),
                              ),
                              hintText: 'Password Confirmation',
                              hintStyle: getBodyStyle(color: AppColors.grey),
                            ),
                            controller: cubit.passwordConfirm,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field is required';
                              }
                              return null;
                            },
                            obscureText: isVisible2,
                            textInputAction: TextInputAction.done,
                          ),
                          const Gap(25),
                          CustomElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.resetPassword(verifyCode: widget.verify_code);
                              }
                            },
                            width: 250,
                            child: (state is ResetPasswordLoadingState)
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : Text(
                                    'Change Passworrd',
                                    style: getBodyStyle(color: AppColors.white),
                                  ),
                          ),
                        ]),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
