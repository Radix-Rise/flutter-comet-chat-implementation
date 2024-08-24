import 'package:comment_chat/app.dart';
import 'package:comment_chat/comet_chat/comet_chat_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final CometChatService cometChatService = CometChatService.instance;
  await cometChatService.initalize();
  await cometChatService.login(cometChatService.userId_1);
  runApp(const App());
}
