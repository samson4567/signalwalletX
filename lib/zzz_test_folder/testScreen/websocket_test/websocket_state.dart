// import 'package:equatable/equatable.dart';

// abstract class WebSocketState extends Equatable {
//   const WebSocketState();

//   @override
//   List<Object> get props => [];
// }

// class WebSocketInitialState extends WebSocketState {}

// class WebSocketConnectingState extends WebSocketState {}

// class WebSocketConnectedState extends WebSocketState {}

// class WebSocketDisconnectedState extends WebSocketState {}

// class SubscribeToCryptoLoadingState extends WebSocketState {}

// class SubscribeToCryptoSuccessState extends WebSocketState {
//   final String topic;
//   final String data;

//   const SubscribeToCryptoSuccessState({
//     required this.topic,
//     required this.data,
//   });
// }

// class SubscribeToCryptoErrorState extends WebSocketState {}

// class WebSocketErrorState extends WebSocketState {
//   final String error;
//   const WebSocketErrorState(this.error);

//   @override
//   List<Object> get props => [error];
// }

// class WebSocketDataState extends WebSocketState {
//   final dynamic data;
//   const WebSocketDataState(this.data);

//   @override
//   List<Object> get props => [data];
// }
