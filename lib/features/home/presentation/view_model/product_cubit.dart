import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/product_end_points.dart';
import 'package:training_book_store/features/home/data/model/category/category_model.dart';
import 'package:training_book_store/features/home/data/model/product_model/product_model.dart';
import 'package:training_book_store/features/home/data/model/slider/slider_model.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_states.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitState());

  ProductCubit object(context) => BlocProvider.of(context);

  SliderModel? sliderImage;
  CategoryModel? allCategory;
  ProductModel? bestSellerProduct;
  Products? singleProduct;
  ProductModel? newArrival;
  ProductModel? productByCategory;
  

  getSlider() {
    emit(SliderLoadingState());
    DioHelper.getData(url: ProductEndPoints.slider, query: {}).then((value) {
     sliderImage=SliderModel.fromJson(value.data);
      emit(SliderSuccessState());
    }).catchError((onError) {
      emit(SliderErrorState());
    });
 }

  showAllCategory() {
    emit(CategoryLoadingState());
    DioHelper.getData(url: ProductEndPoints.allCategory, query: {})
        .then((value) {
      allCategory = CategoryModel.fromJson(value.data);
    }).catchError((onError) {});
  }

  showBestSeller() {
    emit(BestSellerLoadingState());
    DioHelper.getData(url: ProductEndPoints.bestSeller, query: {})
        .then((value) {  
      bestSellerProduct = ProductModel.fromJson(value.data);
      emit(BestSellerSuccessState());
    }).catchError((onError) {
      emit(BestSellerErrorState());
    });
  }

  showProduct({required String url}) {
    emit(ShowProductLoadingState());
    DioHelper.getData(url:  url, query: {}).then((value) {
     singleProduct=Products.fromJson(value.data['data']);
      emit(ShowProductSuccessState());
    }).catchError((onError){
      emit(ShowProductErrorState());
    });
  }

  showProductsByCategory({required String url}) {
    emit(ShowProductByCategoryLoadingState());
    DioHelper.getData(url:  '${ProductEndPoints.showCategory}/$url', query: {}).then((value) {
     productByCategory=ProductModel.fromJson(value.data);
      emit(ShowProductByCategorySuccessState());
    }).catchError((onError){
      emit(ShowProductByCategoryErrorState());
    });
  }

  showNewsArrivals() {
    emit(NewArrivalLoadingState());
    DioHelper.getData(url: ProductEndPoints.newArrivals, query: {}).then((value) {
     newArrival=ProductModel.fromJson(value.data);
      emit(NewArrivalSuccessState());
    }).catchError((onError){
      emit(NewArrivalErrorState());
    });
  }

}
