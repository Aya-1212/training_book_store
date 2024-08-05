import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/features/order/data/model/order_history/single_order_model.dart';

class OrderInfoWidget extends StatelessWidget {
  const OrderInfoWidget({
    super.key,
    required this.singleOrderModel,
  });

  final SingleOrderModel singleOrderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
                color: AppColors.grey,
                blurRadius: 10,
                offset: Offset(5, 5)),
          ],
          border:
              Border.all(color: AppColors.purple, width: 1),
          borderRadius:
              const BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Text(
            "Order Information",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getBodyStyle(
                color: AppColors.purple,
                fontWeight: FontWeight.w600),
          ),
          const Gap(6),
          Text.rich(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(children: [
              TextSpan(
                text: 'Order Code : ',
                style: getBodyStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: '${singleOrderModel.data?.orderCode}',
                style: getBodyStyle(
                    color: AppColors.purple,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              )
            ]),
          ),
          const Gap(6),
          Text.rich(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(children: [
              TextSpan(
                text: 'Order Date : ',
                style: getBodyStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: '${singleOrderModel.data?.orderDate}',
                style: getBodyStyle(
                    color: AppColors.purple,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              )
            ]),
          ),
          const Gap(6),
          Text.rich(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            TextSpan(children: [
              TextSpan(
                text: 'Status : ',
                style: getBodyStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: '${singleOrderModel.data?.status}',
                style: getBodyStyle(
                    color: AppColors.purple,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              )
            ]),
          ),
          const Gap(6),
        ],
      ),
    );
  }
}
