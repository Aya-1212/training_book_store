// ignore_for_file: avoid_print

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
import 'package:training_book_store/features/order/presentation/view_model/order_cubit.dart';
import 'package:training_book_store/features/order/presentation/view_model/order_states.dart';
import 'package:training_book_store/features/order/presentation/views/place_order/order_details.dart';

// ignore: must_be_immutable
class PlaceOrderView extends StatefulWidget {
  const PlaceOrderView({super.key, required this.itemPricesAfterDiscount});
  final List<num> itemPricesAfterDiscount;

  @override
  State<PlaceOrderView> createState() => _PlaceOrderViewState();
}

class _PlaceOrderViewState extends State<PlaceOrderView> {
  var formKey = GlobalKey<FormState>();

  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  String selectedGovernorate = governorateList[0].governorateName;
  int id = governorateList[0].governorateId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..checkOut(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.purple,
                    size: 32,
                  )),
              centerTitle: true,
              title: Text(
                'Place Order',
                style: getTitleStyle(),
              )),
        ),
        //////////////////////////////////////////////body
        body: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, state) {
            if (state is PlaceOrderErrorState) {
              showCustomDialog(context, message: "Something went wrong");
            } else if (state is PlaceOrderSuccessState) {
              showCustomDialog(context,
                  message: "Order Placed Successfully",
                  backgroundColor: AppColors.purple);
              pushWithReplacement(context, const NavigationBarView(page: 0,));
              

            }
          },
          builder: (context, state) {
            if (state is CheckOutErrorState) {
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
                    const Gap(30),
                    CustomElevatedButton(
                      width: 150,
                      child: Text(
                        'Try Again',
                        style: getTitleStyle(color: AppColors.white),
                      ),
                      onPressed: () {
                        OrderCubit().object(context).checkOut();
                      },
                    ),
                  ],
                ),
              );
            }
            //  print(id);
            var cubit = OrderCubit().object(context);
            var cartItems = cubit.orderModel?.data?.cartItems;
            var totalPrice = cubit.orderModel?.data?.total;
            var userInfo = cubit.orderModel?.data?.user;
            ////////////////////////
            return cubit.orderModel != null
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Order",
                              style: getTitleStyle(),
                            ),
                            const Gap(15),
                            ////////////////////////////////////////////////////////////order
                            OrderDetails(
                              itemPrices: widget.itemPricesAfterDiscount,
                              cartItems: cartItems!,
                            ),
                            const Gap(15),
                            /////////////////////////////////////////total
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.grey,
                                        blurRadius: 10,
                                        offset: Offset(5, 5)),
                                  ],
                                  color: AppColors.white,
                                  border: Border.all(
                                      color: AppColors.purple, width: 2)),
                              width: double.infinity,
                              child: Center(
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: 'The Total Price : ',
                                      style: getBodyStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: '$totalPrice EGP',
                                      style: getBodyStyle(
                                          color: AppColors.purple,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            const Gap(30),
                            //////////////////////////////////////////////information
                            Text(
                              "Your Name",
                              style: getTitleStyle(),
                            ),
                            const Gap(5),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: AppColors.purple,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.grey,
                                        blurRadius: 10,
                                        offset: Offset(5, 5)),
                                  ]),
                              child: Text(
                                userInfo!.userName!,
                                style: getTitleStyle(
                                    fontSize: 20, color: AppColors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            /////////////////////////// email
                            const Gap(25),
                            Text(
                              "Your Email",
                              style: getTitleStyle(),
                            ),
                            const Gap(5),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: AppColors.purple,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.grey,
                                        blurRadius: 10,
                                        offset: Offset(5, 5)),
                                  ]),
                              child: Text(
                                userInfo.userEmail!,
                                style: getTitleStyle(
                                    fontSize: 20, color: AppColors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            /////////////////////////////////governorate
                            const Gap(25),
                            Text(
                              "Governorate",
                              style: getTitleStyle(),
                            ),
                            const Gap(5),

                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.grey,
                                        blurRadius: 10,
                                        offset: Offset(5, 5)),
                                  ],
                                  color: AppColors.white,
                                  border: Border.all(
                                      color: AppColors.purple, width: 2)),
                              child: DropdownButton(
                                menuMaxHeight: 200,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedGovernorate = value ??
                                        governorateList[0].governorateName;
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                iconEnabledColor: AppColors.purple,
                                isExpanded: true,
                                value: selectedGovernorate,
                                items: governorateList.map((e) {
                                  return DropdownMenuItem(
                                    onTap: () {
                                      setState(() {
                                        id = e.governorateId;
                                      });
                                    },
                                    value: e.governorateName,
                                    child: Text(
                                      e.governorateName,
                                      style:
                                          getBodyStyle(color: AppColors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            ///
                            ////////////////////////////////address
                            const Gap(25),
                            Text(
                              "Your Address",
                              style: getTitleStyle(),
                            ),
                            const Gap(5),
                            TextFormField(
                              controller: addressController,
                              style: getBodyStyle(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),

                            ////////////////////////////////phone number
                            const Gap(25),
                            Text(
                              "Your phone Number",
                              style: getTitleStyle(),
                            ),
                            const Gap(5),
                            TextFormField(
                              controller: phoneController,
                              style: getBodyStyle(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (value.length != 11) {
                                  return 'enter a valid phone number';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                            ),
                            ////////////////////////////////////////////////////////

                            const Gap(30),
                            Center(
                              child: CustomElevatedButton(
                                width: 200,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.placeOrder(context,
                                        email: userInfo.userEmail!,
                                        name: userInfo.userName!,
                                        governorateId: id,
                                        phone: phoneController.text,
                                        address: addressController.text);
                                  }
                                },
                                child: state is PlaceOrderLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        "Place Order",
                                        style: getTitleStyle(
                                            color: AppColors.white),
                                      ),
                              ),
                            ),
                            const Gap(25),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
