// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/wishlist_end_points.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/features/wishlist/data/model/wishlist_model.dart';
import 'package:training_book_store/features/wishlist/presentation/view_model/wishlist_states.dart';

class WishListCubit extends Cubit<WishlistStates> {
  WishListCubit() : super(WishlistInitialState());

  WishListCubit object(context) => BlocProvider.of(context);
  WishlistModel? getWishlist;

  getWishList() {
    emit(GetWishListLoadingState());
    DioHelper.getData(
            url: WishlistEndPoints.getWishlist,
            query: {},
            token: Token.getBearerToken())
        .then((value) {
      getWishlist = WishlistModel.fromJson(value.data);
     
      emit(GetWishListSuccessState());
    }).catchError((onError) {
      emit(GetWishListErrorState());
    });
  }

  addToWishList({
    required int productId,
  }) {
    emit(AddToWishListLoadingState());
    DioHelper.postData(
            url: WishlistEndPoints.addToWishlist,
            data: {
              "product_id": "$productId",
            },
            token: Token.getBearerToken())
        .then((value) {
      getWishList();
      emit(AddToWishListSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(AddToWishListErrorState());
    });
  }

  removeFromWishList({required int productId, required int index}) {
    emit(RemoveFromWishListLoadingState());
    DioHelper.postData(
            url: WishlistEndPoints.removeFromWishlist,
            data: {
              "product_id": "$productId",
            },
            token: Token.getBearerToken())
        .then((value) {
      getWishlist?.data?.itemData?.removeAt(index);
             getWishList();
      emit(RemoveFromWishListSuccessState());
    }).catchError((onError) {
      emit(RemoveFromWishListErrorState());
    });
  }
}
