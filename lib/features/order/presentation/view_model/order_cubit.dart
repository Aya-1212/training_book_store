// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_book_store/core/services/dio_helper/dio_helper.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/order_end_points.dart';
import 'package:training_book_store/core/services/token.dart';
import 'package:training_book_store/features/order/data/model/order_history/orders_history_model.dart';
import 'package:training_book_store/features/order/data/model/order_history/single_order_model.dart';
import 'package:training_book_store/features/order/data/model/order_models/order_model.dart';
import 'package:training_book_store/features/order/presentation/view_model/order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialState());

  OrderCubit object(context) => BlocProvider.of(context);

  OrderModel? orderModel;
  OrdersHistoryModel? ordersHistoryModel;
  SingleOrderModel? singleOrderModel;

  //checkout

  checkOut() {
    emit(CheckOutLoadingState());
    DioHelper.getData(
            url: OrderEndPoints.checkOut,
            query: {},
            token: Token.getBearerToken())
        .then((value) {
      orderModel = OrderModel.fromJson(value.data);
      emit(CheckOutSuccessState());
    }).catchError((onError) {
      emit(CheckOutErrorState());
    });
  }

  //place order
  placeOrder(
    context, {
    required String name,
    required String email,
    required int governorateId,
    required String phone,
    required String address,
  }) {
    emit(PlaceOrderLoadingState());
    DioHelper.postData(
            url: OrderEndPoints.placeOrder,
            data: {
              "name": name,
              "governorate_id": "$governorateId",
              "phone": phone,
              "address": address,
              "email": email,
            },
            token: Token.getBearerToken())
        .then((value) {
        //  CartCubit().object(context).showCart();
//  print("==============================================");
//       print(value.toString());
//       print("==============================================");          
      emit(PlaceOrderSuccessState());
    }).catchError((onError) {
      print("==============================================");
      print(onError);

      print(onError.jsify());
      print("==============================================");
      emit(PlaceOrderErrorState());
    });
  }

// show history

  showOrdersHistory() {
    emit(GetOrderHistoryLoadingState());
    DioHelper.getData(
            url: OrderEndPoints.orderHistory,
            query: {},
            token: Token.getBearerToken())
        .then((value) {
      ordersHistoryModel = OrdersHistoryModel.fromJson(value.data);
      emit(GetOrderHistorySuccessState());
    }).catchError((onError) {
      emit(GetOrderHistoryErrorState());
    });
  }

//show single order

  showSingleOrder({required String orderId}) {
    emit(GetOrderDetailsLoadingState());
    DioHelper.getData(
            url: "${OrderEndPoints.orderHistory}/$orderId",
            query: {},
            token: Token.getBearerToken())
        .then((value) {
      singleOrderModel = SingleOrderModel.fromJson(value.data);
      emit(GetOrderDetailsSuccessState());
    }).catchError((onError) {
      emit(GetOrderDetailsErrorState());
    });
  }
}
