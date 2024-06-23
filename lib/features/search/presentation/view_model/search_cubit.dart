import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/product_end_points.dart';
import 'package:training_book_store/features/home/data/model/product_model/product_model.dart';
import 'package:training_book_store/features/search/presentation/view_model/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  SearchCubit object(context) => BlocProvider.of(context);

  ProductModel? allProducts;
  ProductModel? searchProducts;
  ProductModel? filterProduct;
  var minPages = TextEditingController();
  var maxPages = TextEditingController();
  var filterSearch = TextEditingController();
  var bestSeller = TextEditingController();
  var limits = TextEditingController();
  var categoryId = TextEditingController();

  getAllProducts() {
    emit(SearchGetAllProductsLoadingState());
    DioHelper.getData(url: ProductEndPoints.allProducts, query: {})
        .then((value) {
      allProducts = ProductModel.fromJson(value.data);
      emit(SearchGetAllProductsSuccessState());
    }).catchError((onError) {
      emit(SearchGetAllProductsErrorState());
    });
  }

  searchForProduct({required String search}) {
    emit(SearchForProductLoadingState());
    DioHelper.getData(url: ProductEndPoints.searchproduct, query: {
      "name": search,
    }).then((value) {
      searchProducts = ProductModel.fromJson(value.data);
      emit(SearchForProductSuccessState());
    }).catchError((onError) {
      emit(SearchForProductErrorState());
    });
  }

  filtrationProducts() {
    emit(SearchFiltrationLoadingState());
  DioHelper.getData(url: ProductEndPoints.filterProducts, query: {
      "min": minPages.text,
      "max": maxPages.text,
      "search": filterSearch.text,
      "is_bestseller": bestSeller.text,
      "limits": limits.text,
      "category_id": categoryId.text
    } ).then((value) {
  filterProduct=ProductModel.fromJson(value.data);
      emit(SearchFiltrationSuccessState());
    }).catchError((onError) {
      emit(SearchFiltrationErrorState());
    });
  }
}
