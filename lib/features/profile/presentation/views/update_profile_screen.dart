// ignore_for_file: avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/core/widgets/navigation_bar_view.dart';
import 'package:training_book_store/features/order/data/governorate_list.dart';
import 'package:training_book_store/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:training_book_store/features/profile/presentation/view_model/profile_states.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  var formKey = GlobalKey<FormState>();
  String city = governorateList[0].governorateName;

  Future uploadOnlyImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    //fileImage = resu
    fileImage = File(result!.files.single.path!);
   // result.files.
    setState(() {});
  }

  File? fileImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
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
                    Icons.arrow_back_sharp,
                    color: AppColors.purple,
                    size: 30,
                  )),
            )),
        body: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is UpdateProfileSuccessState) {
              showCustomDialog(
                context,
                message: "profile updated successfully",
                backgroundColor: AppColors.purple,
              );
              pushWithReplacement(
                  context,
                  const NavigationBarView(
                    page: 0,
                  ));
            } else if (state is UpdateProfileErrorState) {
              showCustomDialog(context, message: "an error occurred");
            }
          },
          builder: (context, state) {
            if (state is GetProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var cubit = ProfileCubit().object(context);
            return cubit.showProfile != null
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 61,
                                  backgroundColor: AppColors.purple,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: fileImage != null
                                        ? FileImage(fileImage!) as ImageProvider
                                        : NetworkImage(
                                            cubit.showProfile!.data!.image!,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -10,
                                  right: -10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        border: Border.all(
                                            color: AppColors.purple, width: 1),
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      onPressed: () {
                                        uploadOnlyImage();
                                        // setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_rounded,
                                        color: AppColors.purple,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(25),
                          TextFormField(
                            style: getBodyStyle(fontSize: 20),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_2,
                                color: AppColors.purple,
                                size: 30,
                              ),
                              hintText: "Enter your name",
                              hintStyle: getBodyStyle(color: AppColors.grey),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: cubit.nameController,
                          ),
                          const Gap(25),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_city_rounded,
                                color: AppColors.purple,
                                size: 35,
                              ),
                              const Gap(15),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                          color: AppColors.purple, width: 1)),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    menuMaxHeight: 500,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.purple,
                                      size: 30,
                                    ),
                                    value: city,
                                    padding: const EdgeInsets.all(8),
                                    items: governorateList
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.governorateName,
                                            child: Text(
                                              e.governorateName,
                                              style: getBodyStyle(
                                                  color: AppColors.black),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        city = value ??
                                            governorateList[0].governorateName;
                                      });
                                      print(city);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(25),
                          TextFormField(
                            style: getBodyStyle(fontSize: 20),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: AppColors.purple,
                                size: 30,
                              ),
                              hintText: "Enter your address",
                              hintStyle: getBodyStyle(color: AppColors.grey),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: cubit.addressController,
                          ),
                          const Gap(25),
                          TextFormField(
                            style: getBodyStyle(fontSize: 20),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: AppColors.purple,
                                size: 30,
                              ),
                              hintText: "Enter your phone number",
                              hintStyle: getBodyStyle(color: AppColors.grey),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (value.length != 11) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            controller: cubit.phoneController,
                          ),
                          const Gap(35),
                          CustomElevatedButton(
                           // height: 60,
                          width: 200,
                            padding: const EdgeInsets.all(10),
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  fileImage != null) {
                                cubit.updateProfileInfo(
                                  city: city,
                                  fileImage: fileImage!,
                                );
                              } else if (formKey.currentState!.validate() &&
                                  fileImage == null) {
                                showCustomDialog(context,
                                    message: "please upload your image");
                              }
                            },
                            child: state is UpdateProfileLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'update profile',
                                    style:
                                        getBodyStyle(color: AppColors.white),
                                  ),
                          )
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border:
                              Border.all(color: AppColors.purple, width: 2)),
                      height: 150,
                      width: 300,
                      child: Center(
                        child: Text(
                          'SomeThing went wrong',
                          style: getBodyStyle(),
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
