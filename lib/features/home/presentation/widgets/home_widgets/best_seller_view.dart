import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/features/home/data/model/product_model/product_model.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_cubit.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_states.dart';
import 'package:training_book_store/features/home/presentation/views/single_product_view.dart';

class BestSeller extends StatefulWidget {
  const BestSeller({
    super.key,
    required this.bestseller,
    //  required this.state,
  });

  final ProductModel bestseller;

  @override
  State<BestSeller> createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().showBestSeller();
  }

  // final ProductStates state ;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductStates>(builder: (context, state) {
      if (state is BestSellerErrorState) {
        return Center(
          child: Container(
            height: 150,
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
              border: Border.all(color: AppColors.purple, width: 2.5),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
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
        );
      } else if (state is BestSellerLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ShowProductsList(widget: widget.bestseller);
    });
  }
}

class ShowProductsList extends StatelessWidget {
  const ShowProductsList({
    super.key,
    required this.widget,
  });

  final ProductModel widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const Gap(20);
        },
        separatorBuilder: (context, index) {
          return InkWell(
            onTap: () {
              push(
                  context,
                  SingleProductView(
                      id: widget.data!.products![index].id ?? 0));
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              height: 260,
              width: 180,
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
                  Stack(children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        widget.data!.products![index].image ?? '',
                        height: 160,
                        width: 150,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 160,
                            width: 150,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.black, width: 1)),
                            child: const Icon(
                              Icons.error_outline,
                              color: AppColors.white,
                              size: 50,
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
                            '${widget.data!.products![index].discount}%',
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ]),
                  const Gap(8),
                  Text(
                    widget.data!.products![index].name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getSmallStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    // cubit.bodyProduct!.data![index].name!,
                  ),
                  Text(
                    'Best Seller : ${widget.data!.products![index].bestSeller}',
                    style: getSmallStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('${widget.data?.products?[index].price} EGP',
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)
                      //  cubit.bodyProduct!.data![index].price!,
                      ),
                  Text(
                    '${widget.data!.products![index].priceAfterDiscount} EGP',
                    style: getSmallStyle(
                        color: AppColors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                    //  cubit.bodyProduct!.data![index].price!,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: widget.data?.products?.length ?? 6,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
