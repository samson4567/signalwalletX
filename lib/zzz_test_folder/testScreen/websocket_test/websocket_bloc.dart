import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_event.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:http/http.dart' as http;

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  WebSocketChannel? _channel;
  // IO.Socket? _socket; // If using Socket.IO

  WebSocketBloc() : super(WebSocketInitialState()) {
    on<WebSocketConnectEvent>(_onConnect);
    on<WebSocketSendMessageEvent>(_onSendMessage);
    on<WebSocketDisconnectEvent>(_onDisconnect);
    on<WebSocketDataReceivedEvent>(_onWebSocketDataReceivedEvent);
    on<WebSocketErrorEvent>(_onWebSocketErrorEvent);
    on<SubscribeToCryptoEvent>(_onSubscribeToCryptoEvent);

    // SubscribeToCryptoEvent
  }

  Future<void> _onConnect(
      WebSocketConnectEvent event, Emitter<WebSocketState> emit) async {
    emit(WebSocketConnectingState());
    try {
      _channel = WebSocketChannel.connect(Uri.parse(event.url));

      print("sdbajsdConnected_sdbajsdConnected");
      _channel?.stream.listen(
        (data) {
          print("sdbajsdkjbadasdbhaj-############### ${data.runtimeType}");
          add(WebSocketDataReceivedEvent(data));

          try {
            final decodedData = json.decode(data);
            print("ajsabjsjbsdnksknd${decodedData}");
            print("ajsabjsjbsdnksknd=topic${decodedData["topic"]}");

            if ((decodedData['topic'] as String).startsWith("kline.")) {
              print("ajsabjsjbsdnksknd=emitted");
              emit(SubscribeToCryptoSuccessState(
                  topic: (decodedData['topic'] as String), data: data));
            }
          } catch (e) {}
        },
        onError: (error) {
          print("sdbajsdkjbadasdbhaj-error-$error.");
          if (error is WebSocketException) {
            print("WebSocketException");
            add(WebSocketErrorEvent(error.message));
            print("sdbajsdkjbadasdbhaj-errormessage-${error.message}");
            //
          } else if (error is WebSocketChannelException) {
            print("WebSocketChannelException");
            add(WebSocketErrorEvent(error.message.toString()));

            print("sdbajsdkjbadasdbhaj-errormessage-${error.message}");
            Map m = {1: error.inner};
            print("sdbajsdkjbadasdbhaj-errorinner-${(m[1]).message}");
            //
          } else {
            add(WebSocketErrorEvent(error.toString()));
            print("sdbajsdkjbadasdbhaj-errormessage-last-${error}");
          }
        },
        onDone: () {
          print("sdbajsdkjbadasdbhaj-done");
          // add(WebSocketDisconnectEvent());
        },
      );

      emit(WebSocketConnectedState());
    } catch (e) {
      // ss WebSocketChannelException
      if (e is WebSocketException) {
        emit(WebSocketErrorState(e.message));
        //
      } else if (e is WebSocketChannelException) {
        emit(WebSocketErrorState(e.message.toString()));
        //
      } else {
        emit(WebSocketErrorState(e.toString()));
      }
    }
  }

  void _onSendMessage(
      WebSocketSendMessageEvent event, Emitter<WebSocketState> emit) {
    // if (_channel != null && state is WebSocketConnectedState) {
    //   _channel!.sink.add(event.message);
    //   // If using Socket.IO:
    //   // _socket?.emit('message', event.message); // Adjust event name
    // } else {
    //   emit(const WebSocketErrorState('Not connected to WebSocket'));
    // }
  }

  void _onDisconnect(
      WebSocketDisconnectEvent event, Emitter<WebSocketState> emit) {
    _channel?.sink.close();
    // If using Socket.IO:
    // _socket?.disconnect();
    emit(WebSocketDisconnectedState());
  }

  void _onWebSocketErrorEvent(
      WebSocketErrorEvent event, Emitter<WebSocketState> emit) {
    _channel?.sink.close();
    // If using Socket.IO:
    // _socket?.disconnect();
    emit(WebSocketErrorState(event.error));
  }

  void _onSubscribeToCryptoEvent(
      SubscribeToCryptoEvent event, Emitter<WebSocketState> emit) {
    _channel!.sink.add(json.encode({
      "req_id": "test", // optional
      "op": "subscribe",
      "args": [
        // "orderbook.1.BTCUSDT"
        "kline.${event.interval ?? "5"}.${event.symbol?.toUpperCase() ?? "BTC"}USDT"
      ]
    }));
    // If using Socket.IO:
    // _socket?.disconnect();
  }

// _onSubscribeToCryptoEvent
  @override
  Future<void> close() {
    _channel?.sink.close();
    // If using Socket.IO:
    // _socket?.dispose();
    return super.close();
  }

  @override
  void onEvent(WebSocketEvent event) {
    super.onEvent(event);
    print('WebSocket Event: $event');
  }

  @override
  void onTransition(Transition<WebSocketEvent, WebSocketState> transition) {
    super.onTransition(transition);
    print('WebSocket Transition: $transition');
  }

  // @override
  // void on<E extends WebSocketEvent>(EventHandler<E, WebSocketState> handler,
  //     {EventTransformer<E>? transformer}) {
  //   if (handler is WebSocketDataReceivedEvent) {
  //     print("sndjadskakdjakjdadjaslkd-WebSocketDataReceivedEvent");
  //     emit(WebSocketDataState((handler as WebSocketDataReceivedEvent).data));
  //   }
  //   super.on(handler, transformer: transformer);
  // }

  Future<void> _onWebSocketDataReceivedEvent(
      WebSocketDataReceivedEvent event, Emitter<WebSocketState> emit) async {
    emit(WebSocketDataState(event.data));
    // result.fold(
    //   (error) {},
    //   (rate) {
    //     emit(WebSocketDataState( rate));
    //   },
    // );
  }

  // _onWebSocketDataReceivedEvent

  void dipslayName() {
    // _onWebSocketDataReceivedEvent();
  }

  String? returnNothing() {
    String variable = "this is a variable";
    "sdjsdkjsds";
    functionToAddSomeVauleTogether(a: 1, b: 12);

    return variable;
  }

  double functionToAddSomeVauleTogether({
    required int a,
    required int b,
  }) {
    return (a + b).toDouble();
  }
}

class Person {}
