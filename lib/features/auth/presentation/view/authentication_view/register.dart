import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/core/widgets/navigation_bar_view.dart';
import 'package:training_book_store/features/auth/presentation/view_model/register_manager/register_cubit.dart';
import 'package:training_book_store/features/auth/presentation/view_model/register_manager/register_states.dart';
import 'package:training_book_store/features/auth/presentation/view/authentication_view/sign_in.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();

  bool isVisible1 = true;
  bool isVisible2 = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterErrorState) {
              showCustomDialog(context, message: state.error);
            } else if (state is RegisterSucessState) {
              pushAndRemoveUntil(context, const NavigationBarView());
              showCustomDialog(context,
                  message: "Register Successfully", backgroundColor: AppColors.purple);
            }
          },
          builder: (context, state) {
            var cubit = RegisterCubit().object(context);
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Create Your Account',
                          style: getTitleStyle(fontSize: 26),
                        ),
                        Text(
                          'Please enter this fields to Register',
                          style:
                              getBodyStyle(fontSize: 14, color: AppColors.grey),
                        ),
                        const Gap(35),
                        TextFormField(
                          style: getBodyStyle(fontSize: 20),
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: getBodyStyle(color: AppColors.grey),
                          ),
                          controller: cubit.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const Gap(30),
                        TextFormField(
                          style: getBodyStyle(fontSize: 20),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: getBodyStyle(color: AppColors.grey),
                          ),
                          controller: cubit.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const Gap(30),
                        TextFormField(
                          style: getBodyStyle(fontSize: 20),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible1 = !isVisible1;
                                  });
                                },
                                icon: Icon((isVisible1)
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_rounded,color: AppColors.purple,)),
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
                          style: getBodyStyle(fontSize: 20),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible2 = !isVisible2;
                                  });
                                },
                                icon: Icon((isVisible2)
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_rounded,color: AppColors.purple,)),
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
                        const Gap(70),
                        CustomElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.register();
                            }
                          },
                          width: 300,
                          child: (state is RegisterLoadingState)
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : Text(
                                  'Sign up',
                                  style: getBodyStyle(color: AppColors.white),
                                ),
                        ),
                        //   Spacer(),
                        Gap(MediaQuery.of(context).size.height * 0.15),
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account',
                              style: getBodyStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  pushWithReplacement(
                                      context, const SignInView());
                                },
                                child: Text('Sign In',
                                    style: getBodyStyle(
                                      //  fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.purple,
                                    )))
                          ],
                        ),
                      ],
                    ),
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
