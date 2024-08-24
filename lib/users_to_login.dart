import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:comment_chat/comet_chat/comet_chat_service.dart';
import 'package:flutter/material.dart';

class UsersToLogin extends StatefulWidget {
  const UsersToLogin({super.key});

  @override
  State<UsersToLogin> createState() => _UsersToLoginState();
}

class _UsersToLoginState extends State<UsersToLogin> {
  final cometChatService = CometChatService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: cometChatService.availableUsers.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 100),
          itemBuilder: (_, index) {
            return ElevatedButton(
              onPressed: () async {
                await cometChatService.login(
                  cometChatService.availableUsers[index],
                );
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute<CometChatUsersWithMessages>(
                    builder: (_) => const CometChatUsersWithMessages(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: Text(
                'Login User ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
