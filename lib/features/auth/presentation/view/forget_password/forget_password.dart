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
import 'package:training_book_store/features/auth/presentation/view/forget_password/verify_code.dart';

// ignore: must_be_immutable
class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(35),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ),
        ),
        body: BlocConsumer<SignInCubit, SignInStates>(
          listener: (context, state) {
            if (state is ForgetPasswordErrorState) {
              showCustomDialog(context, message: state.error);
            } else if (state is ForgetPasswordSucessState) {
              push(context, const VerifyCodeView());
               showCustomDialog(context,
                  message: "Email Verified", backgroundColor: AppColors.purple);
            }
          },
          builder: (context, state) {
            var cubit = SignInCubit().object(context);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your email',
                        //textAlign: TextAlign.start,
                        style: getTitleStyle(fontSize: 20),
                      ),
                      const Gap(15),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        controller: cubit.emailForgetPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                      ),
                      const Gap(50),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomElevatedButton(
                          width: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.forgetPassword();
                            }
                          },
                          child: (state is ForgetPasswordLoadingState)
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : Text(
                                  'Send',
                                  style: getBodyStyle(color: AppColors.white),
                                ),
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}

Future<dynamic> showModelBottomSheet(context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: AppColors.black),
      );
    },
  );
}
