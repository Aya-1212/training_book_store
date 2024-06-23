import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/functions/routing.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_cubit.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_states.dart';
import 'package:training_book_store/features/home/presentation/views/single_product_view.dart';

class ShowProductsByCategoryView extends StatelessWidget {
  const ShowProductsByCategoryView(
      {super.key, required this.categoryid, required this.categoryName});

  final int categoryid;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit()..showProductsByCategory(url: '$categoryid'),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.purple,
                    size: 32,
                  )),
              centerTitle: true,
              title: Text(
                categoryName,
                style: getTitleStyle(color: AppColors.purple),
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            )),
        body: BlocBuilder<ProductCubit, ProductStates>(
          builder: (context, state) {
            var cubit = ProductCubit().object(context);

            if (state is ShowProductByCategoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ShowProductByCategoryErrorState) {
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
                              'There is no product in this category',
                              style: getTitleStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
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
                                  id: cubit.productByCategory?.data
                                          ?.products?[index].id ??
                                      0,
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            height: 150,
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    child: Image.network(
                                      cubit.productByCategory?.data
                                              ?.products?[index].image ??
                                          '',
                                      height: 140,
                                      width: 130,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: AppColors.grey,
                                          height: 140,
                                          width: 130,
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
                                          "${cubit.productByCategory?.data?.products?[index].discount}%",
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
                                        cubit.productByCategory?.data
                                                ?.products?[index].name ??
                                            '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: getBodyStyle(
                                            fontWeight: FontWeight.w600),
                                        // cubit.bodyProduct!.data![index].name!,
                                      ),
                                      Text(
                                        'Best Seller : ${cubit.productByCategory?.data?.products?[index].bestSeller}',
                                        style: getBodyStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                          '${cubit.productByCategory?.data?.products?[index].price} EGP',
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: AppColors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        '${cubit.productByCategory?.data?.products?[index].priceAfterDiscount} EGP',
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
                      itemCount:
                          cubit.productByCategory!.data!.products!.length,
                      scrollDirection: Axis.vertical,
                    ),
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
