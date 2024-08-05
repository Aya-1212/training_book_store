import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/core/widgets/dialogs.dart';
import 'package:training_book_store/core/widgets/navigation_bar_view.dart';
import 'package:training_book_store/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:training_book_store/features/cart/presentation/view_model/cart_states.dart';
import 'package:training_book_store/features/home/presentation/views/single_product_view.dart';
import 'package:training_book_store/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:training_book_store/features/wishlist/presentation/view_model/wishlist_states.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WishListCubit()..getWishList()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: Scaffold(
        //////////////////////////////////////////////////////////////
        body: BlocConsumer<WishListCubit, WishlistStates>(
          listener: (context, state) {
            if (state is RemoveFromWishListSuccessState) {
              pop(context);
              showCustomDialog(context,
                  message: 'Item removed from wishlist',
                  backgroundColor: AppColors.purple);
            } else if (state is RemoveFromWishListLoadingState) {
              showLoadingDialog(context);
            } else if (state is RemoveFromWishListErrorState) {
              pop(context);
              showCustomDialog(context, message: "Something went wrong");
            }
          },
          builder: (context, state) {
            var cubit = WishListCubit().object(context);
            if (state is GetWishListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
////////////////////////////////////////////////////////////////////////
            if (state is GetWishListErrorState) {
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
                              'Something went wrong',
                              style: getTitleStyle(),
                            ),
                            const Gap(10),
                            Text(
                              'Please try again later',
                              style: getTitleStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
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
                        cubit.getWishList();
                      },
                    ),
                  ],
                ),
              );
            }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            return SafeArea(
                child: cubit.getWishlist?.data?.itemData?.isEmpty == false
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.55,
                        ),
                        itemCount: cubit.getWishlist!.data!.itemData!.length,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              push(
                                  context,
                                  SingleProductView(
                                    id: cubit.getWishlist!.data!
                                        .itemData![index].id!,
                                  ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.grey,
                                        blurRadius: 10,
                                        offset: Offset(5, 5)),
                                  ],
                                  border: Border.all(
                                      color: AppColors.black, width: 1),
                                  color: AppColors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Column(
                                children: [
                                  //////////////////////////////////////////////////image
                                  Stack(children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      child: Image.network(
                                        cubit.getWishlist?.data
                                                ?.itemData?[index].image ??
                                            '',
                                        height: 160,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 5,
                                      child: Container(
                                        height: 25,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: AppColors.red,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            '${cubit.getWishlist?.data?.itemData?[index].discount}%',
                                            style: const TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                  //////////////////////////////////////////////////text
                                  const Gap(8),
                                  Text(
                                    cubit.getWishlist?.data?.itemData?[index]
                                            .name ??
                                        '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: getBodyStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Best Seller : ${cubit.getWishlist?.data?.itemData?[index].bestSeller}',
                                    style: getBodyStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '${cubit.getWishlist?.data?.itemData?[index].price} EGP',
                                    style: getBodyStyle(
                                        color: AppColors.purple,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Divider(
                                    color: AppColors.raisinBlack,
                                  ),

                                  const Gap(2),
                                  BlocListener<CartCubit, CartStates>(
                                      listener: (context, state) {
                                        if (state is AddToCartSuccessState) {
                                          pop(context);
                                        } else if (state
                                            is AddToCartErrorState) {
                                          pop(context);
                                          showCustomDialog(
                                            context,
                                            message: 'Item not added to cart',
                                          );
                                        } else if (state
                                            is AddToCartLoadingState) {
                                          showLoadingDialog(context);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          state is AddToCartLoadingState
                                              ? const CircularProgressIndicator()
                                              : InkWell(
                                                  onTap: () {
                                                    CartCubit()
                                                        .object(context)
                                                        .addToCart(
                                                          context: context,
                                                          productId: cubit
                                                              .getWishlist!
                                                              .data!
                                                              .itemData![index]
                                                              .id!,
                                                          showDialog: true,
                                                        );
                                                  },
                                                  child: const Icon(
                                                    Icons
                                                        .add_shopping_cart_rounded,
                                                    color: AppColors.purple,
                                                    size: 30,
                                                  ),
                                                ),
                                          //////////////////////////////////////////////////////////
                                          InkWell(
                                            onTap: () {
                                              cubit.removeFromWishList(
                                                  productId: cubit
                                                      .getWishlist!
                                                      .data!
                                                      .itemData![index]
                                                      .id!,
                                                  index: index);
                                            },
                                            child: Text(
                                              'Remove',
                                              style: getBodyStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.red),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
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
                                border: Border.all(
                                    color: AppColors.purple, width: 2.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.sentiment_dissatisfied,
                                    size: 50,
                                    color: AppColors.purple,
                                  ),
                                  const Gap(25),
                                  Text(
                                    'Your wishlist is Empty',
                                    style: getTitleStyle(),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                            CustomElevatedButton(
                              onPressed: () {
                                push(
                                    context,
                                    const NavigationBarView(
                                      page: 1,
                                    ),);
                              },
                              width: 300,
                              child: Text(
                                "Search For Books",
                                style: getTitleStyle(color: AppColors.white),
                              ),
                            )
                          ],
                        ),
                      ));
          },
        ),
      ),
    );
  }
}
