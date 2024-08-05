// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/product_end_points.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/core/widgets/dialogs.dart';
import 'package:training_book_store/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:training_book_store/features/cart/presentation/view_model/cart_states.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_cubit.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_states.dart';
import 'package:training_book_store/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:training_book_store/features/wishlist/presentation/view_model/wishlist_states.dart';

// ignore: must_be_immutable
class SingleProductView extends StatefulWidget {
  final int id;
  const SingleProductView({super.key, required this.id});

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  int index = 0;

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()
            ..showProduct(url: '${ProductEndPoints.showProduct}/${widget.id}'),
        ),
        BlocProvider(
          create: (context) => WishListCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: Scaffold(
        //////////////////////////////////////
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
        ///////////////////////////////////////////////////
        body: BlocBuilder<ProductCubit, ProductStates>(
          builder: (context, state) {
            var cubitProduct = ProductCubit().object(context);
            if (state is ShowProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ShowProductErrorState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 200,
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
                          border:
                              Border.all(color: AppColors.purple, width: 2.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 50,
                              color: AppColors.purple,
                            ),
                            const Gap(25),
                            Text(
                              'Something went wrong please try again',
                              style: getTitleStyle(),
                              textAlign: TextAlign.center,
                            ),
                            CustomElevatedButton(
                              width: 180,
                              height: 60,
                              child: Text(
                                'Try Again',
                                style: getTitleStyle(
                                  color: AppColors.white,
                                ),
                              ),
                              onPressed: () {
                                cubitProduct.showProduct(
                                    url:
                                        '${ProductEndPoints.showProduct}/${widget.id}');
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return cubitProduct.singleProduct != null
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: AppColors.grey,
                                            blurRadius: 20,
                                            offset: Offset(5, 5)),
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                      shape: BoxShape.rectangle,
                                    ),
                                    height: 250,
                                    width: 200,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      cubitProduct.singleProduct!.image!,
                                      height: 250,
                                      width: 200,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          height: 250,
                                          width: 225,
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColors.black,
                                                  width: 1)),
                                          child: const Icon(
                                            Icons.error_outline,
                                            color: AppColors.white,
                                            size: 50,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      height: 25,
                                      width: 46,
                                      decoration: BoxDecoration(
                                          color: AppColors.red,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          '${cubitProduct.singleProduct?.discount}%',
                                          style: getBodyStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          const Gap(25),
                          Text(
                            cubitProduct.singleProduct!.name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: getTitleStyle(fontSize: 20),
                          ),
                          const Gap(6),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Category : ',
                                style: getBodyStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: cubitProduct.singleProduct!.category,
                                style: getBodyStyle(
                                    color: AppColors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                          ),
                          const Gap(6),

                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Best Seller : ',
                                style: getBodyStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: cubitProduct.singleProduct!.bestSeller!
                                    .toString(),
                                style: getBodyStyle(
                                    color: AppColors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                          ),
                          const Gap(6),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Price before : ',
                                style: getBodyStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            TextSpan(
                                text:
                                    '${cubitProduct.singleProduct?.price} EGP',
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600))
                          ])),
                          const Gap(6),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Price : ',
                                style: getBodyStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    "${cubitProduct.singleProduct?.priceAfterDiscount} EGP",
                                style: getBodyStyle(
                                    color: AppColors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                          ),
                          const Gap(6),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Description : ',
                                style: getBodyStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                //[,",",]
                                text: cubitProduct.singleProduct!.description!
                                    .replaceAll("<p>", "")
                                    .replaceAll(";", "")
                                    .replaceAll("</p>", ""),
                                style: getBodyStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )
                            ]),
                          ),
                          const Gap(15),
                        ],
                      ),
                    ),
                  )
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                : Center(
                    child: Container(
                      height: 200,
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
                        border: Border.all(color: AppColors.purple, width: 2.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 50,
                            color: AppColors.purple,
                          ),
                          const Gap(25),
                          Text(
                            'Empty',
                            style: getTitleStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
        bottomNavigationBar: BlocConsumer<WishListCubit, WishlistStates>(
          listener: (context, state) {
            if (state is AddToWishListSuccessState) {
              showCustomDialog(context,
                  message: "added to wishlist suceesfully",
                  backgroundColor: AppColors.purple);
            } else if (state is AddToWishListErrorState) {
              showCustomDialog(
                context,
                message: "an error occured",
              );
            }
          },
          builder: (context, state) {
            var wishlistCubit = WishListCubit().object(context);
            return Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: CustomElevatedButton(
                onPressed: () {
                  wishlistCubit.addToWishList(productId: widget.id);
                },
                child: state is AddToWishListLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "add to wishlist",
                            style: getBodyStyle(),
                          ),
                          const Gap(15),
                          const Icon(
                            Icons.favorite,
                            color: AppColors.black,
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
