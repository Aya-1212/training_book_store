import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/core/widgets/navigation_bar_view.dart';
import 'package:training_book_store/features/order/presentation/view_model/order_cubit.dart';
import 'package:training_book_store/features/order/presentation/view_model/order_states.dart';
import 'package:training_book_store/features/order/presentation/widgets/all_orders/all_orders_history_list.dart';

class OrdersHistoryView extends StatelessWidget {
  const OrdersHistoryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..showOrdersHistory(),
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
                    size: 30,
                  )),
              centerTitle: true,
              title: Text(
                'History',
                style: getTitleStyle(),
              ),
            )),
        body: BlocBuilder<OrderCubit, OrderStates>(
          builder: (context, state) {
            var cubit = OrderCubit().object(context);
            var ordersHistoryModel = cubit.ordersHistoryModel;

            if (state is GetOrderHistoryErrorState) {
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
                        cubit.showOrdersHistory();
                      },
                    ),
                  ],
                ),
              );
            } else if (state is GetOrderHistoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return ordersHistoryModel!.data!.orders!.isNotEmpty == true
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Total Orders : ',
                                style: getBodyStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: '${ordersHistoryModel.data?.meta?.total}',
                                style: getBodyStyle(
                                    color: AppColors.purple,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                          ),
                          const Gap(25),
                          AllOrdersHistoryList(
                              ordersHistoryModel: ordersHistoryModel),
                        ],
                      ),
                    ),
                  )
                : Padding(
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
                                  'your order history is empty',
                                  style: getTitleStyle(),
                                ),
                                const Gap(10),
                                Text(
                                  'Search For your favourite products',
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
                            pushWithReplacement(
                              context,
                              const NavigationBarView(
                                page: 1,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
