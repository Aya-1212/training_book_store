// ignore_for_file: must_be_immutable

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

class SendMessageScreen extends StatelessWidget {
  SendMessageScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var subjectController = TextEditingController();
  var messageController = TextEditingController();

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
            if (state is ContactUsSuccessState) {
              showCustomDialog(context,
                  message: "The Message has been sent successfully",
                  backgroundColor: AppColors.purple);
              pop(context);
            } else if (state is ContactUsErrorState) {
              showCustomDialog(
                context,
                message: "Something went wrong",
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
                        ' Send a Message to us ',
                        style: getTitleStyle(fontSize: 26),
                      ),
                      const Gap(35),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_2_sharp,
                            color: AppColors.purple,
                              size: 30,
                          ),
                          hintText: 'Name',
                          hintStyle: getBodyStyle(color: AppColors.grey),
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                      ),
                      ////////////////////////////////////////////////////////////////////////////////////
                      const Gap(30),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email_sharp,
                            color: AppColors.purple,
                              size: 30,
                          ),
                          hintText: 'Email',
                          hintStyle: getBodyStyle(color: AppColors.grey),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                      ),

                      //////////////////////////////////////////////////////////////////////////////////////////
                      const Gap(30),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.subject_sharp,
                            color: AppColors.purple,
                            size: 30,
                          ),
                          hintText: 'Subject',
                          hintStyle: getBodyStyle(color: AppColors.grey),
                        ),
                        controller: subjectController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                      ),
                      /////////////////////////////////////////////////////////////////
                      const Gap(30),
                      TextFormField(
                        style: getBodyStyle(fontSize: 20),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.messenger_outline_rounded,
                            color: AppColors.purple,
                            size: 30,
                          ),
                          hintText: 'Message',
                          hintStyle: getBodyStyle(color: AppColors.grey),
                        ),
                        controller: messageController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                      ),
                      ////////////////////////////////////////////////////////////////////////////////////
                      const Gap(70),
                      CustomElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.contactUs(
                                name: nameController.text,
                                email: emailController.text,
                                subject: subjectController.text,
                                message: messageController.text);
                          }
                        },
                        width: 300,
                        child: (state is ChangePasswordLoadingState)
                            ? const CircularProgressIndicator(
                                color: AppColors.white,
                              )
                            : Text(
                                'Send Message',
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
