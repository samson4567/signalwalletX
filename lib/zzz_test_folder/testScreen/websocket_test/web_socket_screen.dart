import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_event.dart';
import 'package:signalwavex/zzz_test_folder/testScreen/websocket_test/websocket_state.dart';
import 'websocket_bloc.dart';

class WebSocketScreen extends StatefulWidget {
  const WebSocketScreen({super.key});

  @override
  State<WebSocketScreen> createState() => _WebSocketScreenState();
}

class _WebSocketScreenState extends State<WebSocketScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WebSocketBloc>(context).add(const WebSocketConnectEvent(
        "wss://ws-api.testnet.binance.vision/ws-api/v3"
        // 'ws://echo.websocket.events'
        )); // Replace with your WebSocket URL
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    BlocProvider.of<WebSocketBloc>(context).add(WebSocketDisconnectEvent());
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      BlocProvider.of<WebSocketBloc>(context)
          .add(WebSocketSendMessageEvent(message));
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<WebSocketBloc, WebSocketState>(
              builder: (context, state) {
                if (state is WebSocketConnectingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WebSocketConnectedState) {
                  return BlocListener<WebSocketBloc, WebSocketState>(
                    listenWhen: (previous, current) =>
                        current is WebSocketDataState,
                    listener: (context, state) {
                      if (state is WebSocketDataState) {
                        setState(() {
                          _messages.add(state.data.toString());
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          try {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          } catch (e) {}
                        });
                      }
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text('Received: ${_messages[index]}'));
                      },
                    ),
                  );
                } else if (state is WebSocketErrorState) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is WebSocketDisconnectedState) {
                  return const Center(child: Text('Disconnected'));
                } else if (state is WebSocketDataState) {
                  return Center(child: Text('${state.data}'));
                } else {
                  return Center(
                      child: Text('Not connected ${state.runtimeType}'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Send Message',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<WebSocketBloc, WebSocketState>(
              builder: (context, state) {
                if (state is WebSocketConnectedState) {
                  return ElevatedButton(
                    onPressed: () => BlocProvider.of<WebSocketBloc>(context)
                        .add(WebSocketDisconnectEvent()),
                    child: const Text('Disconnect'),
                  );
                } else if (state is WebSocketDisconnectedState ||
                    state is WebSocketErrorState) {
                  return ElevatedButton(
                    onPressed: () => BlocProvider.of<WebSocketBloc>(context)
                        .add(const WebSocketConnectEvent(
                            "wss://ws-api.testnet.binance.vision/ws-api/v3"
                            // 'ws://echo.websocket.events'
                            )), // Replace with your URL
                    child: const Text('Reconnect'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
