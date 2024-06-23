class OrderStates {}

class OrderInitialState extends OrderStates {}

//checkout

class CheckOutLoadingState extends OrderStates {}

class CheckOutSuccessState extends OrderStates {}

class CheckOutErrorState extends OrderStates {}

//place order

class PlaceOrderLoadingState extends OrderStates {}

class PlaceOrderSuccessState extends OrderStates {}

class PlaceOrderErrorState extends OrderStates {}

//order history

class GetOrderHistoryLoadingState extends OrderStates {} 

class GetOrderHistorySuccessState extends OrderStates {}

class GetOrderHistoryErrorState extends OrderStates {}

//get order details

class GetOrderDetailsLoadingState extends OrderStates {}

class GetOrderDetailsSuccessState extends OrderStates {}

class GetOrderDetailsErrorState extends OrderStates {}

//
