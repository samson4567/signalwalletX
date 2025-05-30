// import 'package:equatable/equatable.dart';

// abstract class WebSocketEvent extends Equatable {
//   const WebSocketEvent();

//   @override
//   List<Object> get props => [];
// }

// class WebSocketConnectEvent extends WebSocketEvent {
//   final String url;
//   const WebSocketConnectEvent(this.url);

//   @override
//   List<Object> get props => [url];
// }

// class WebSocketSendMessageEvent extends WebSocketEvent {
//   final dynamic message; // Can be String, Map, etc.
//   const WebSocketSendMessageEvent(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class WebSocketDisconnectEvent extends WebSocketEvent {}

// class WebSocketDataReceivedEvent extends WebSocketEvent {
//   final dynamic data;
//   const WebSocketDataReceivedEvent(this.data);

//   @override
//   List<Object> get props => [data];
// }

// class WebSocketErrorEvent extends WebSocketEvent {
//   final String error;
//   const WebSocketErrorEvent(this.error);

//   @override
//   List<Object> get props => [error];
// }

// class SubscribeToCryptoEvent extends WebSocketEvent {
//   final String? symbol;
//   final String? interval;

//   const SubscribeToCryptoEvent({this.symbol, this.interval});

//   // @override
//   // List<Object> get props => [symbol ?? "", interval ?? ""];
// }
