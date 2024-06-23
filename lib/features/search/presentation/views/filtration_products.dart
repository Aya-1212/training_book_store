import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/features/home/data/model/product_model/product_model.dart';
import 'package:training_book_store/features/home/presentation/views/single_product_view.dart';

class FiltrationProductsView extends StatelessWidget {
  const FiltrationProductsView({
    super.key, 
    required this.filterProducts,
    
  });

  final ProductModel filterProducts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // 
    child: ListView.separated(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            push(
                context,
                SingleProductView(
                  id: filterProducts.data?.products?[index].id ?? 0,
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            height: 150.h,
            width: double.infinity,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                    child: Image.network(
                      filterProducts.data!.products![index].image! ,
                      height: 140.h,
                      width: 130.w,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.grey,
                          height: 140.h,
                          width: 130.w,
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
                          // border: Border.all(
                          //     color: AppColors.black, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "${filterProducts.data?.products![index].discount}%",
                          //'',
                          //   '${widget.bestseller.data!.products![index].discount}%',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        filterProducts.data!.products![index].name!,
                       
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      style: getBodyStyle(
                          fontWeight: FontWeight.w600
                        ), 
                      ),
                      Text(
                        'Best Seller : ${filterProducts.data!.products![index].bestSeller}',
                       style:getBodyStyle(
                        fontSize: 17,
                          fontWeight: FontWeight.w600
                        ), 
                        
                      ),
                      Text(
                          '${filterProducts.data!.products![index].price} EGP',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)
                          ),
                      Text(
                        '${filterProducts.data!.products![index].priceAfterDiscount} EGP',
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
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Gap(20);
      },
      itemCount: filterProducts.data?.products!.length ?? 0,
      scrollDirection: Axis.vertical,
    ),
            );
  }
}