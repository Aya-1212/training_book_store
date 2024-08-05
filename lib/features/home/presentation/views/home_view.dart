// ignore_for_file: file_names, use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/services/app_local_storage.dart';
import 'package:training_book_store/core/services/notification_services.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/navigation_bar_view.dart';
import 'package:training_book_store/features/home/data/category_list.dart';
import 'package:training_book_store/features/home/data/model/slider/slider_model.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_cubit.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_states.dart';
import 'package:training_book_store/features/home/presentation/views/show_product_by_category.dart';
import 'package:training_book_store/features/home/presentation/widgets/home_widgets/best_seller_view.dart';
import 'package:training_book_store/features/home/presentation/widgets/home_widgets/new_arrivals.dart';
import 'package:training_book_store/features/profile/presentation/views/drawer_settings/change_password_view.dart';
import 'package:training_book_store/features/profile/presentation/views/drawer_settings/send_message_screen.dart';
import 'package:training_book_store/features/profile/presentation/views/profile_view.dart';
import 'package:training_book_store/features/profile/presentation/views/update_profile_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? name;
  String? email;

  @override
  void initState() {
    name = AppLocalStorage.getData("name");
    email = AppLocalStorage.getData("email");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()
        ..getSlider()
        ..showAllCategory()
        ..showBestSeller()
        ..showNewsArrivals(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: AppColors.purple,
                    size: 40,
                  ),
                  onPressed: () async {
                    // NotificationServices notificationServices =
                    //     NotificationServices();
                    // await notificationServices.showInstantNotification(
                    //     id: 2,
                    //     title: "opendrawer",
                    //     body: "what do you want ? ");
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  "Hello, $name",
                  style: getBodyStyle(
                      color: AppColors.purple, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Welcome Back!",
                  style: getTitleStyle(fontSize: 18),
                ),
              ],
            ),
            actions: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(AppLocalStorage.getData("image"))
                    as ImageProvider,
              ),
            ],
          ),
        ),
////////////////////////////////////////////////////////////////////////////////////////////////
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.purple,
                ),
                accountName: Text(
                  name ?? "user",
                  style: getTitleStyle(color: AppColors.white, fontSize: 18),
                ),
                accountEmail: Text(
                  email ?? "email",
                  style: getTitleStyle(color: AppColors.white, fontSize: 18),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 28,
                  backgroundImage:
                      NetworkImage(AppLocalStorage.getData("image"))
                          as ImageProvider,
                ),
              ),
/////////////////////////////////////////////////////////
              ListTile(
                leading: const Icon(
                  Icons.edit,
                  size: 30,
                ),
                title: Text(
                  ' Update Your Profile ',
                  style: getBodyStyle(),
                ),
                onTap: () {
                  push(
                    context,
                    const UpdateProfileScreen(),
                  );
                },
              ),
//////////////////////////////////////////////////////////
              ListTile(
                leading: const Icon(
                  Icons.key,
                  size: 30,
                ),
                title: Text(
                  'Change Password',
                  style: getBodyStyle(),
                ),
                onTap: () {
                  push(context, const ChangePasswordView());
                },
              ),

//////////////////////////////////////////////////////////////////////
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  size: 30,
                ),
                title: Text(
                  'Settings',
                  style: getBodyStyle(),
                ),
                onTap: () {
                  pop(context);
                },
              ),
///////////////////////////////////////////////////////
              ListTile(
                leading: const Icon(
                  Icons.message_outlined,
                  size: 30,
                ),
                title: Text(
                  ' Contact Us ',
                  style: getBodyStyle(),
                ),
                onTap: () {
                  push(context, SendMessageScreen());
                },
              ),
            ],
          ),
        ),
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        body: BlocBuilder<ProductCubit, ProductStates>(
          builder: (context, state) {
            var cubit = ProductCubit().object(context);
            return cubit.newArrival != null && cubit.bestSellerProduct != null
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: [
                          const Divider(
                            color: AppColors.purple,
                          ),
                          const Gap(10),
                          Text(
                            'Best Seller',
                            style: getTitleStyle(),
                          ),
                          const Gap(20),
                          /////////////////////////////////
                          BestSeller(
                            bestseller: cubit.bestSellerProduct!,
                          ),
                          ////////////////////////////////////////////////////
                          const Gap(30),
                          ////////////////////slider
                          Text(
                            'News',
                            style: getTitleStyle(),
                          ),
                          const Gap(15),
                          state is SliderLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : state is SliderErrorState
                                  ? Center(
                                      child: Container(
                                        height: 150,
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
                                          border: Border.all(
                                              color: AppColors.purple,
                                              width: 2.5),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.error_outline,
                                              size: 50,
                                              color: AppColors.purple,
                                            ),
                                            const Gap(25),
                                            Text(
                                              'Something went wrong',
                                              style: getTitleStyle(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : CarouselSlider(
                                      items: [
                                        ItemCarouselSlider(
                                          slider: cubit.sliderImage!,
                                          index: 0,
                                        ),
                                        ItemCarouselSlider(
                                          slider: cubit.sliderImage!,
                                          index: 1,
                                        ),
                                        ItemCarouselSlider(
                                          slider: cubit.sliderImage!,
                                          index: 2,
                                        ),
                                      ],
                                      options: CarouselOptions(
                                        height: 150,
                                        aspectRatio: 16 / 9,
                                        viewportFraction: 0.5,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: true,
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.3,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                          ////////////////////category
                          const Gap(20),
                          Text(
                            'Categories',
                            style: getTitleStyle(),
                          ),
                          const Gap(15),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    push(
                                        context,
                                        ShowProductsByCategoryView(
                                          categoryName: cubit.allCategory?.data
                                                  ?.categories?[index].name ??
                                              '',
                                          categoryid: cubit.allCategory?.data
                                                  ?.categories?[index].id ??
                                              0,
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.black, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    height: 100,
                                    width: 150,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(25)),
                                            child: Image.network(
                                              categoryImages[index],
                                              height: 100,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const Gap(5),
                                          Text(
                                            cubit.allCategory?.data
                                                    ?.categories?[index].name ??
                                                '',
                                            style: getBodyStyle(
                                                fontWeight: FontWeight.w600),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Gap(10),
                                        ]),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Gap(20);
                              },
                              itemCount:
                                  cubit.allCategory?.data?.categories!.length ??
                                      3,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),

                          ///////////////////////////////////////////////////////////////
                          const Gap(25),
                          Text(
                            'New Arrivals',
                            style: getTitleStyle(),
                          ),
                          const Gap(20),
                          NewArrivalView(
                            newArrival: cubit.newArrival!,
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ItemCarouselSlider extends StatelessWidget {
  const ItemCarouselSlider({
    super.key,
    required this.slider,
    required this.index,
  });

  final SliderModel slider;
  final int index;
  @override
  Widget build(
    BuildContext context,
  ) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Image.network(
        slider.data!.sliders![index].image!,
        height: 100,
        width: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 100,
            width: 200,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.black, width: 1)),
            child: const Icon(
              Icons.error_outline,
              color: AppColors.white,
              size: 50,
            ),
          );
        },
      ),
    );
  }
}
