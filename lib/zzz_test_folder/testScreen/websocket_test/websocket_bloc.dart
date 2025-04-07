import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_event.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  WebSocketChannel? _channel;
  // IO.Socket? _socket; // If using Socket.IO

  WebSocketBloc() : super(WebSocketInitialState()) {
    on<WebSocketConnectEvent>(_onConnect);
    on<WebSocketSendMessageEvent>(_onSendMessage);
    on<WebSocketDisconnectEvent>(_onDisconnect);
    on<WebSocketDataReceivedEvent>(_onWebSocketDataReceivedEvent);

    // WebSocketDataReceivedEvent
  }

  Future<void> _onConnect(
      WebSocketConnectEvent event, Emitter<WebSocketState> emit) async {
    emit(WebSocketConnectingState());
    try {
      _channel = WebSocketChannel.connect(Uri.parse(event.url));
      // If using Socket.IO:
      // _socket = IO.io(event.url);
      // _socket?.connect();
      // _socket?.on('connect', (_) => emit(WebSocketConnectedState()));
      // _socket?.on('disconnect', (_) => emit(WebSocketDisconnectedState()));
      // _socket?.on('error', (error) => emit(WebSocketErrorState(error.toString())));
      // _socket?.on('message', (data) => add(WebSocketDataReceivedEvent(data))); // Adjust event name
      print("sdbajsdConnected_sdbajsdConnected");
      _channel?.stream.listen(
        (data) {
          print("sdbajsdkjbadasdbhaj");
          add(WebSocketDataReceivedEvent(data));
        },
        onError: (error) {
          emit(WebSocketErrorState(error.toString()));
        },
        onDone: () {
          emit(WebSocketDisconnectedState());
        },
      );
      emit(WebSocketConnectedState());
    } catch (e) {
      // ss
      emit(WebSocketErrorState(e.toString()));
    }
  }

  void _onSendMessage(
      WebSocketSendMessageEvent event, Emitter<WebSocketState> emit) {
    if (_channel != null && state is WebSocketConnectedState) {
      _channel!.sink.add(event.message);
      // If using Socket.IO:
      // _socket?.emit('message', event.message); // Adjust event name
    } else {
      emit(const WebSocketErrorState('Not connected to WebSocket'));
    }
  }

  void _onDisconnect(
      WebSocketDisconnectEvent event, Emitter<WebSocketState> emit) {
    _channel?.sink.close();
    // If using Socket.IO:
    // _socket?.disconnect();
    emit(WebSocketDisconnectedState());
  }

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
}
