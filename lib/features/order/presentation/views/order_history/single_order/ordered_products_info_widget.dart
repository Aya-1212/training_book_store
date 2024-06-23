import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/features/order/data/model/order_history/single_order_model.dart';

class OrderedProductsInfoWidget extends StatelessWidget {
  const OrderedProductsInfoWidget({
    super.key,
    required this.singleOrderModel,
  });

  final SingleOrderModel singleOrderModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            width: 250,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  singleOrderModel
                          .data
                          ?.orderProducts?[index]
                          .productName ??
                      '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getBodyStyle(
                      color: AppColors.purple,
                      fontWeight: FontWeight.w600),
                ),
                const Gap(6),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Item Quantity : ',
                      style: getBodyStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          ' ${singleOrderModel.data?.orderProducts?[index].orderProductQuantity}',
                      style: getBodyStyle(
                          color: AppColors.purple,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                const Gap(6),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'price :',
                      style: getBodyStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          ' ${singleOrderModel.data?.orderProducts?[index].productPriceAfterDiscount} EGP',
                      style: getBodyStyle(
                          color: AppColors.purple,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                const Gap(6),
                const Divider(
                  color: AppColors.purple,
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Product Total : ',
                      style: getBodyStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          ' ${singleOrderModel.data?.orderProducts?[index].productTotal} EGP',
                      style: getBodyStyle(
                          color: AppColors.purple,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                // Text(
                //   '${cartItems[index].itemTotal} EGP',
                //   style:
                //       getBodyStyle(fontSize: 17, fontWeight: FontWeight.w600),
                // ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Gap(15);
        },
        itemCount:
            singleOrderModel.data?.orderProducts?.length ??
                0,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

