// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/order_end_points.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/widgets/custorm_dialogs.dart';
import 'package:training_book_store/features/cart/presentation/view_model/cart_states.dart';
import 'package:training_book_store/features/cart/data/model/add_to_cart_model.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  CartCubit object(context) => BlocProvider.of<CartCubit>(context);
  String? error;
  AddCartModel? itemId;
  AddCartModel? cartDetails;
  var quantity = TextEditingController();
  List<int>? productAddedToCart;

//methods

//show cart

  showCart() {
    emit(ShowCartLoadingState());
    // print("loading before any thing");
    DioHelper.getData(
            url: OrderEndPoints.showCart,
            query: {},
            token: Token.getBearerToken())
        .then((value) {
      //print("loading after success");
      cartDetails = AddCartModel.fromJson(value.data);
      // print("==============================================");
      // print("successful");
      // print("==============================================");
      // print(value);
      emit(ShowCartSuccessState());
    }).catchError((onError) {
      //  print("loading after onError");
      //   print("==============================================");
      //   print(onError);
      //   // print(onError.jsify());
      //   print("==============================================");

      emit(ShowCartErrorState());
    });
  }

  //add to cart

  addToCart({
    required int productId,
    required BuildContext context,
    //show dialog?? singleProduct مش عاوزه ال Dialog يظهر في الصفحة دي
    required bool showDialog,
  }) {
    emit(AddToCartLoadingState());
    DioHelper.postData(
            url: OrderEndPoints.addToCart,
            data: {
              "product_id": "$productId",
            },
            token: Token.getBearerToken())
        .then((value) {
      // print(productAddedToCart);
      itemId = AddCartModel.fromJson(value.data);
    //  productAddedToCart!.add(productId);
      showDialog
          ? showCustomDialog(context,
              message: 'Item added to cart', backgroundColor: AppColors.purple)
          : null;
  //    print(productAddedToCart);

      emit(AddToCartSuccessState());
    }).catchError((onError) {
      emit(AddToCartErrorState());
    });
  }

  //update cart

  updateCart({required String cartItemId}) {
    emit(UpdateCartLoadingState());
    DioHelper.postData(
            url: OrderEndPoints.updateCart,
            data: {
              "cart_item_id": cartItemId,
              "quantity": quantity.text,
            },
            token: Token.getBearerToken())
        .then((value) {
      showCart();
      emit(UpdateCartSuccessState());
    }).catchError((onError) {
      emit(UpdateCartErrorState());
    });
  }

  //delete card item

  deleteCartItem({
    required int cartItemId,
    required int index,
  }) {
    emit(DeleteCartItemLoadingState());
    DioHelper.postData(
            url: OrderEndPoints.deleteCartItem,
            data: {
              "cart_item_id": "$cartItemId",
            },
            token: Token.getBearerToken())
        .then((value) {
      // if (productAddedToCart!.isNotEmpty) {
      //   productAddedToCart!.removeAt(index);
      // }
      cartDetails?.data?.cartItems?.removeAt(index);
     // productAddedToCart!.removeAt(index);
    //  showCart();
      emit(DeleteCartItemSuccessState());
    }).catchError((onError) {
      emit(DeleteCartItemErrorState());
    });
  }

//end
}
