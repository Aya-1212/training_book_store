// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/features/auth/presentation/view_model/sigin_manager/signin_cubit.dart';
import 'package:training_book_store/features/auth/presentation/view_model/sigin_manager/signin_states.dart';
import 'package:training_book_store/features/auth/presentation/view/forget_password/reset_password.dart';

class VerifyCodeView extends StatefulWidget {
  const VerifyCodeView({super.key});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  var formKey = GlobalKey<FormState>();

  int otpLenght = 6;

  // ignore: non_constant_identifier_names
  String? verify_code;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
              showCustomDialog(context,
                  message: "OTP Verified", backgroundColor: AppColors.purple);
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
                        'Please Enter the code',
                        style: getTitleStyle(fontSize: 20),
                      ),
                      const Gap(15),
                      Pinput(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        animationCurve: Curves.bounceIn,
                        // pin number animation
                        animationDuration: const Duration(milliseconds: 500),
                        controller: cubit.pinController,
                        textInputAction: TextInputAction.done,
                        length: otpLenght,
                        showCursor: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          } else if (value.length != otpLenght) {
                            return 'invalid code';
                          }
                          return null;
                        },
                        //ON SUBMIT H3ML VALIDATIOM
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        onChanged: (value) {
                          if (cubit.pinController.text.length == otpLenght) {
                            setState(() {
                              verify_code = cubit.pinController.text;
                            });
                          }
                        },
                        defaultPinTheme: PinTheme(
                          height: width * 0.2,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            color: AppColors.purple.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          height: width * 0.2,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            color: AppColors.purple.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const Gap(15),
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
                                      fontSize: 20, color: AppColors.white),
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
