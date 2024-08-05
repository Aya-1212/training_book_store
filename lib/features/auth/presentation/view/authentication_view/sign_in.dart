import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/core/widgets/navigation_bar_view.dart';
import 'package:training_book_store/features/auth/presentation/view_model/sigin_manager/signin_cubit.dart';
import 'package:training_book_store/features/auth/presentation/view_model/sigin_manager/signin_states.dart';
import 'package:training_book_store/features/auth/presentation/view/forget_password/forget_password.dart';
import 'package:training_book_store/features/auth/presentation/view/authentication_view/register.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();

  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        body: BlocConsumer<SignInCubit, SignInStates>(
          listener: (context, state) {
            if (state is SignInErrorState) {
              showCustomDialog(context, message: state.error);
            } else if (state is SignInSucessState) {
              pushAndRemoveUntil(context, const NavigationBarView());
              showCustomDialog(context,
                  message: "Login Successfully", backgroundColor: AppColors.purple);
            }
          },
          builder: (context, state) {
            var cubit = SignInCubit().object(context);
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                    //  crossAxisAlignment: CrossAxisAlignment.,
                      children: [
                        Text(
                          'Login to your account',
                          style: getTitleStyle(fontSize: 26),
                        ),
                        Text(
                          'please enter your email and password',
                          style:
                              getBodyStyle(fontSize: 14, color: AppColors.grey),
                        ),
                        const Gap(35),
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
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon((isVisible)
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
                          obscureText: isVisible,
                          textInputAction: TextInputAction.done,
                        ),
                        const Gap(30),
                        InkWell(
                          onTap: () {
                            push(context, ForgetPasswordView());
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forget Password?',
                              style: getBodyStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.purple),
                            ),
                          ),
                        ),
                        const Gap(50),
                        CustomElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },
                          width: 300,
                          child: (state is SignInLoadingState)
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : Text(
                                  'Sign in',
                                  style: getBodyStyle(color: AppColors.white),
                                ),
                        ),
                       // const Spacer(),
                        Gap(MediaQuery.of(context).size.height * 0.32),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: getBodyStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.grey),
                              ),
                              TextButton(
                                  onPressed: () {
                                    pushWithReplacement(
                                        context, const RegisterView());
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: getBodyStyle(
                                        //  fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.purple),
                                  ))
                            ],
                          ),
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
