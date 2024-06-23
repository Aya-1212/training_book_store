import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/core/widgets/navigation_bar_view.dart';
import 'package:training_book_store/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:training_book_store/features/cart/presentation/view_model/cart_states.dart';
import 'package:training_book_store/features/order/presentation/views/order_history/all_orders/orders_history.dart';
import 'package:training_book_store/features/order/presentation/views/place_order/place_order_view.dart';

// ignore: must_be_immutable
class CartView extends StatelessWidget {
  CartView({super.key});

  var formKey = GlobalKey<FormState>();
  List<num> itemPrices = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..showCart(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'My Cart',
              style: getTitleStyle(),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    push(context, const OrdersHistoryView());
                  },
                  icon: const Icon(
                    Icons.save_outlined,
                    color: AppColors.purple,
                    size: 33,
                  ))
            ],
          ),
        ),
///////////////////////////////////////////////////////////////////////////////////////////////////
        body: BlocConsumer<CartCubit, CartStates>(
          listener: (context, state) {
            if (state is UpdateCartErrorState) {
              showCustomDialog(
                context,
                message: "Something went wrong",
              );
            } else if (state is UpdateCartSuccessState) {
              showCustomDialog(context,
                  message: "Cart updated successfully",
                  backgroundColor: AppColors.purple);
            } else if (state is DeleteCartItemSuccessState) {
              showCustomDialog(context,
                  message: "Cart item deleted successfully",
                  backgroundColor: AppColors.purple);
            } else if (state is DeleteCartItemErrorState) {
              showCustomDialog(
                context,
                message: "Something went wrong",
              );
            }
          },
          builder: (context, state) {
            var cubit = CartCubit().object(context);
            var cartDetails = cubit.cartDetails;
            if (state is ShowCartLoadingState ||
                state is UpdateCartLoadingState ||
                state is DeleteCartItemLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ShowCartErrorState) {
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
                        cubit.showCart();
                      },
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child:
               cartDetails?.data?.cartItems?.isNotEmpty == true
               //1.full
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              push(
                                  context,
                                  PlaceOrderView(
                                    itemPricesAfterDiscount: itemPrices,
                                  ));
                            },
                            child: Text(
                              "CheckOut",
                              style: getTitleStyle(),
                            )),
                        const Gap(15),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              itemPrices.add(cartDetails.data!.cartItems![index]
                                  .itemProductPriceAfterDiscount!);
                              return Container(
                                padding: const EdgeInsets.all(10),
                                height: 210,
                                width: double.infinity,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        child: Image.network(
                                          cartDetails.data?.cartItems?[index]
                                                  .itemProductImage ??
                                              '',
                                          height: 180,
                                          width: 150,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: AppColors.grey,
                                              height: 180,
                                              width: 150,
                                              child: const Icon(
                                                Icons.error_outline,
                                                color: AppColors.white,
                                                size: 35,
                                              ),
                                            );
                                          },
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
                                              '${cartDetails.data?.cartItems?[index].itemProductDiscount}%',
                                              style: const TextStyle(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                    const Gap(8),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartDetails.data?.cartItems?[index]
                                                    .itemProductName ??
                                                '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: getBodyStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'Item Quantity: ${cartDetails.data?.cartItems?[index].itemQuantity}',
                                            style: getBodyStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Gap(6),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  updateItemQuantity(context,
                                                      cubit: cubit,
                                                      itemId: cartDetails
                                                              .data
                                                              ?.cartItems?[
                                                                  index]
                                                              .itemId ??
                                                          0,
                                                      quantity:
                                                          "${cartDetails.data?.cartItems?[index].itemQuantity}");
                                                },
                                                child: Text(
                                                  'Update',
                                                  style: getBodyStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.purple),
                                                ),
                                              ),
                                              const Gap(40),
                                              GestureDetector(
                                                onTap: () {
                                                  cubit.deleteCartItem(
                                                      index: index,
                                                      cartItemId:
                                                          "${cartDetails.data?.cartItems?[index].itemId}");
                                                },
                                                child: Text(
                                                  'Remove',
                                                  style: getBodyStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Gap(6),
                                          Text(
                                            'Total :${cartDetails.data?.cartItems?[index].itemTotal!.toStringAsFixed(2)} EGP',
                                            style: getBodyStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                              '${cartDetails.data?.cartItems?[index].itemProductPrice} EGP',
                                              style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: AppColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                            '${cartDetails.data?.cartItems?[index].itemProductPriceAfterDiscount} EGP',
                                            style: getSmallStyle(
                                                color: AppColors.purple,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Gap(20);
                            },
                            itemCount: cartDetails!.data!.cartItems!.length,
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ],
                    )
                    //2.empty cart
                  : Column(
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
                            border:
                                Border.all(color: AppColors.purple, width: 2.5),
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
                                'Your Cart is Empty',
                                style: getTitleStyle(),
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        CustomElevatedButton(
                          onPressed: () {
                            pushWithReplacement(
                                context,
                                const NavigationBarView(
                                  page: 1,
                                ));
                          },
                          width: 300,
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Search For Books ",
                                  style: getTitleStyle(color: AppColors.white)),
                              const WidgetSpan(
                                  child: Icon(
                                Icons.search_rounded,
                                color: AppColors.white,
                                size: 30,
                              ))
                            ]),
                          ),
                        ),
                        /////////////
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
//

  updateItemQuantity(context,
      {required int itemId,
      required CartCubit cubit,
      required String quantity}) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        cubit.quantity.text = quantity;
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 225,
            width: 400,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: formKey,
              child: Column(children: [
                Text(
                  "Item Quantity ",
                  style: getTitleStyle(),
                ),
                TextFormField(
                  controller: cubit.quantity,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter quantity";
                    }
                    return null;
                  },
                ),
                const Gap(15),
                CustomElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.updateCart(cartItemId: '$itemId');
                      pop(context);
                    }
                  },
                  width: 150,
                  child: Text(
                    "update",
                    style: getTitleStyle(color: AppColors.white),
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
