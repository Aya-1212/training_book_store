import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/features/order/data/model/order_history/orders_history_model.dart';
import 'package:training_book_store/features/order/presentation/views/single_order_view.dart';

class AllOrdersHistoryList extends StatelessWidget {
  const AllOrdersHistoryList({
    super.key,
    required this.ordersHistoryModel,
  });

  final OrdersHistoryModel ordersHistoryModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            push(
              context,
              SingleOrderView(
                ordertId: ordersHistoryModel.data!.orders![index].id!,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: AppColors.grey,
                      blurRadius: 10,
                      offset: Offset(5, 5)),
                ],
                border: Border.all(color: AppColors.purple, width: 2),
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Order Code : ',
                      style: getBodyStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          ' ${ordersHistoryModel.data!.orders![index].orderCode}',
                      style: getBodyStyle(
                          color: AppColors.purple,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                const Gap(8),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Order Date : ',
                      style: getBodyStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          ' ${ordersHistoryModel.data!.orders![index].orderDate}',
                      style: getBodyStyle(
                          color: AppColors.purple,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                const Gap(8),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Order Status : ',
                      style: getBodyStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          ' ${ordersHistoryModel.data!.orders![index].status}',
                      style: getBodyStyle(
                          color: AppColors.purple,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                const Gap(8),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Order Total : ',
                      style: getBodyStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: ' ${ordersHistoryModel.data!.orders![index].total}',
                      style: getBodyStyle(
                          color: AppColors.purple,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                const Gap(8),
                Text(
                  "Click to see more details",
                  style: getBodyStyle(color: AppColors.purple),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Gap(20);
      },
      itemCount: ordersHistoryModel.data!.orders!.length,
      scrollDirection: Axis.vertical,
    );
  }
}
