import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/core/widgets/custom_elevated.dart';
import 'package:training_book_store/features/search/presentation/view_model/search_cubit.dart';
import 'package:training_book_store/features/search/presentation/view_model/search_states.dart';
import 'package:training_book_store/features/search/presentation/views/filtration_products.dart';
import 'package:training_book_store/features/search/presentation/views/search_all_products.dart';
import 'package:training_book_store/features/search/presentation/views/search_for_product.dart';

// ignore: must_be_immutable
class SearchView extends StatelessWidget {
  SearchView({super.key});

  var search = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getAllProducts(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<SearchCubit, SearchStates>(builder: (context, state) {
          var cubit = SearchCubit().object(context);
          if (state is SearchForProductLoadingState ||
              state is SearchFiltrationLoadingState ||
              state is SearchGetAllProductsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchForProductErrorState ||
              state is SearchFiltrationErrorState ||
              state is SearchGetAllProductsErrorState) {
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
                        border: Border.all(color: AppColors.purple, width: 2.5),
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
                          CustomElevatedButton(
                            width: 180,
                            height: 60,
                            child: Text(
                              'Try Again',
                              style: getTitleStyle(
                                color: AppColors.white,
                              ),
                            ),
                            onPressed: () {
                              cubit.getAllProducts();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: search,
                          style: getBodyStyle(),
                          decoration: InputDecoration(
                            hintText: 'Search Here...',
                            hintStyle:
                                getBodyStyle(fontWeight: FontWeight.w400),
                          ),
                          onFieldSubmitted: (value) {
                            //  print(value);
                            cubit.searchForProduct(search: value);
                          },
                        ),
                      ),
                      const Gap(15),
                      SizedBox(
                          height: 60,
                          width: 60,
                          child: FloatingActionButton(
                              backgroundColor: AppColors.purple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                cubit.searchForProduct(search: search.text);
                              },
                              child: const Icon(
                                Icons.search_outlined,
                                color: AppColors.white,
                              ))),
                      const Gap(10),
                      IconButton(
                          onPressed: () {
                            showFiltrationList(context, cubit: cubit);
                          },
                          icon: const Icon(
                            Icons.filter_list_outlined,
                            size: 35,
                            color: AppColors.purple,
                          )),
                    ],
                  ),
                  const Gap(20),
                  (state is SearchForProductSuccessState)
                      ? SearchForSpecificproducts(
                          searchProducts: cubit.searchProducts!,
                        )
                      : (state is SearchFiltrationSuccessState &&
                              cubit.filterProduct!.data!.products!.isNotEmpty)
                          ? FiltrationProductsView(
                              filterProducts: cubit.filterProduct!,
                            )
                          : (state is SearchFiltrationSuccessState &&
                                  cubit.filterProduct!.data!.products!.isEmpty)
                              ? Center(
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.error_outline,
                                          size: 50,
                                          color: AppColors.purple,
                                        ),
                                        const Gap(25),
                                        Text(
                                          'There is no result',
                                          style: getTitleStyle(),
                                        ),
                                        const Gap(10),
                                        Text(
                                          'Search again',
                                          style: getTitleStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SearchAllproducts(
                                  allProducts: cubit.allProducts!),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//filtration

  showFiltrationList(context, {required SearchCubit cubit}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        cubit.bestSeller.text = '';
        cubit.maxPages.text = '';
        cubit.categoryId.text = '';
        cubit.filterSearch.text = '';
        cubit.limits.text = '';
        cubit.minPages.text = '';
        return Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Text(
                                  'Filtration By',
                                  style: getTitleStyle(
                                      color: AppColors.purple, fontSize: 20),
                                ),
                              ),
                              const Gap(25),
                              //////////////////////////////////////////////////////////////////////////////
                              Row(children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Min Pages',
                                        style: getTitleStyle(
                                            color: AppColors.purple,
                                            fontSize: 18),
                                      ),
                                      TextFormField(
                                        controller: cubit.minPages,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter min pages';
                                          }
                                          return null;
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                /////////////////
                                const Gap(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Max Pages',
                                        style: getTitleStyle(
                                            color: AppColors.purple,
                                            fontSize: 18),
                                      ),
                                      TextFormField(
                                        controller: cubit.maxPages,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter max pages';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                              ///////////////////////////////////////////////////////////////////////////////////////////
                              const Gap(30),
                              Text(
                                'Search for...',
                                style: getTitleStyle(
                                    color: AppColors.purple, fontSize: 18),
                              ),
                              TextFormField(
                                controller: cubit.filterSearch,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'this field is required';
                                  }
                                  return null;
                                },
                              ),
                              const Gap(30),
                              ////////////////////////////////////////////////////////
                              Text(
                                'Best Seller',
                                style: getTitleStyle(
                                    color: AppColors.purple, fontSize: 18),
                              ),
                              TextFormField(
                                controller: cubit.bestSeller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'this field is required';
                                  }
                                  return null;
                                },
                              ),
                              const Gap(30),
                              ///////////////////////////////////////////////////

                              Row(children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Category Id',
                                        style: getTitleStyle(
                                            color: AppColors.purple,
                                            fontSize: 18),
                                      ),
                                      TextFormField(
                                        controller: cubit.categoryId,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter id';
                                          }
                                          return null;
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const Gap(20),
                                //////////////////////////////////////
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Limits',
                                        style: getTitleStyle(
                                            color: AppColors.purple,
                                            fontSize: 18),
                                      ),
                                      TextFormField(
                                        controller: cubit.limits,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter limits';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                              const Gap(30),
                              Center(
                                child: CustomElevatedButton(
                                  width: 120,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: AppColors.purple,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.filtrationProducts();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    'Filter',
                                    style:
                                        getTitleStyle(color: AppColors.white),
                                  ),
                                ),
                              )
                            ]),
                      ))),
            ));
      },
    );
  }
//end
}
