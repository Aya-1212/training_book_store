// ignore_for_file: must_be_immutable

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
import 'package:training_book_store/features/auth/presentation/view/forget_password/reset_password.dart';

class VerifyCodeView extends StatelessWidget {
  VerifyCodeView({super.key});

  var formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  String? verify_code;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            if (state is VerifyCodeErrorState) {
              showCustomDialog(context, message: state.error);
            } else if (state is VerifyCodeSucessState) {
              pushAndRemoveUntil(
                  context,
                  ResetPasswordView(
                    verify_code: verify_code!,
                  ));
            }
          },
          builder: (context, state) {
            var cubit = SignInCubit().object(context);
            verify_code = cubit.verifyCode.text;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please Enter the code',
                        style: getTitleStyle(),
                      ),
                      const Gap(15),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        decoration: InputDecoration(
                            hintText: '* * * * * *',
                            hintStyle: getBodyStyle(color: AppColors.grey),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10)),
                        controller: cubit.verifyCode,
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
                              cubit.verifyCodeMethod();
                            }
                          },
                          child: (state is VerifyCodeLoadingState)
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : Text(
                                  'Verify',
                                  style: getBodyStyle(
                                      fontSize: 22, color: AppColors.white),
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
