import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/features/order/presentation/view_model/order_cubit.dart';
import 'package:training_book_store/features/order/presentation/view_model/order_states.dart';
import 'package:training_book_store/features/order/presentation/widgets/single_order/order_info_widget.dart';
import 'package:training_book_store/features/order/presentation/widgets/single_order/ordered_products_info_widget.dart';
import 'package:training_book_store/features/order/presentation/widgets/single_order/receiver_info_widget.dart';

class SingleOrderView extends StatelessWidget {
  const SingleOrderView({super.key, required this.ordertId});
  final int ordertId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..showSingleOrder(orderId: "$ordertId"),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: AppColors.purple,
                    size: 33,
                  )),
            )),
        body: BlocBuilder<OrderCubit, OrderStates>(
          builder: (context, state) {
            var cubit = OrderCubit().object(context);
            var singleOrderModel = cubit.singleOrderModel;

            if (state is GetOrderDetailsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetOrderDetailsErrorState) {
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
                        cubit.showSingleOrder(orderId: "$ordertId");
                      },
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Products you Orderded",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getBodyStyle(
                          color: AppColors.purple, fontWeight: FontWeight.w600),
                    ),
                    const Gap(15),
                    OrderedProductsInfoWidget(
                      singleOrderModel: singleOrderModel!,
                    ),
                    const Gap(25),
                    OrderInfoWidget(
                      singleOrderModel: singleOrderModel,
                    ),
                    const Gap(20),
                    RecevierInfoWidget(
                      singleOrderModel: singleOrderModel,
                    ),
                  ],
                ),
              ),
              //singleOrderModel != null    ?
              // : Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Center(
              //         child: Container(
              //           height: 200,
              //           width: double.infinity,
              //           margin: const EdgeInsets.all(10),
              //           padding: const EdgeInsets.all(5),
              //           decoration: BoxDecoration(
              //             color: AppColors.white,
              //             boxShadow: const [
              //               BoxShadow(
              //                   color: AppColors.grey,
              //                   blurRadius: 10,
              //                   offset: Offset(5, 5)),
              //             ],
              //             border: Border.all(
              //                 color: AppColors.purple, width: 2.5),
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(5)),
              //           ),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               const Icon(
              //                 Icons.error_outline,
              //                 size: 50,
              //                 color: AppColors.purple,
              //               ),
              //               const Gap(25),
              //               Text(
              //                 'Something went wrong',
              //                 style: getTitleStyle(),
              //               ),
              //               Text(
              //                 'Try Again later',
              //                 style: getTitleStyle(),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
            );
          },
        ),
      ),
    );
  }
}
