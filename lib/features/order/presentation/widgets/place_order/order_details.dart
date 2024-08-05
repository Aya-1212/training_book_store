import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/features/order/data/model/order_models/order_model.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.cartItems,
   required this.itemPrices,
  });
  final List<CartItems> cartItems;
  final List<num> itemPrices ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
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
                border: Border.all(color: AppColors.black, width: 1),
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cartItems[index].itemProductName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getBodyStyle(
                      color: AppColors.purple, fontWeight: FontWeight.w600),
                ),
                const Gap(6),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Item Quantity : ',
                      style: getBodyStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: ' ${cartItems[index].itemQuantity}',
                      style: getBodyStyle(
                        color: AppColors.purple,
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                const Gap(6),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'price :',
                      style: getBodyStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: ' ${itemPrices[index]} EGP',
                      style: getBodyStyle(
                        color: AppColors.purple,
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                const Gap(6),
               const Divider(color: AppColors.purple,),
                 Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Total : ',
                      style: getBodyStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: ' ${cartItems[index].itemTotal} EGP',
                      style: getBodyStyle(
                        color: AppColors.purple,
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ]),
                ),

              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Gap(15);
        },
        itemCount: cartItems.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
