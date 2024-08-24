import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:logger/logger.dart';

class CometChatService {
  CometChatService._();
  static final CometChatService instance = CometChatService._();

  // These are just for testing purpose in production app you will create your own user using self generated auth_token
  final List<String> availableUsers = [
    'cometchat-uid-1',
    'cometchat-uid-2',
    'cometchat-uid-3',
    'cometchat-uid-4',
    'cometchat-uid-5',
  ];

  // This navigator will be used to navigate to call screen from anywhere in the app.
  // For this to work we have to assign this to the top most widget of the app.
  // In our case we are gonna put it at MaterialApp
  final navigatorKey = CallNavigationContext.navigatorKey;

  // This intialization is necessary to make sure to connect the comet chat application
  Future<void> initalize() async {
    final UIKitSettingsBuilder builder = UIKitSettingsBuilder();
    builder.subscriptionType = CometChatSubscriptionType.allUsers;
    builder.autoEstablishSocketConnection = true;
    builder.region = 'IN';
    builder.appId = '262815bd015b8e63';
    builder.authKey = 'a458a53052635c4da34576bf2ec6848b55194d62';
    builder.extensions = CometChatUIKitChatExtensions.getDefaultExtensions();
    builder.callingExtension = CometChatCallingExtension();

    final UIKitSettings uiKitSettings = builder.build();
    await CometChatUIKit.init(uiKitSettings: uiKitSettings);
  }

  // Before enabling any communication between users we need to login that user in comet chat
  // This doesn't need to be a manual process. we can do that behind the scenes without use knowing anything.
  Future<void> login(String userId) async {
    final User? user = await CometChatUIKit.login(userId);
    if (user == null) {
      Logger().w('No user found with the porvided userId: $userId');
      return;
    }
  }

  Future<void> endAllExistingCalls() async {
    final call = await CometChat.getActiveCall();
    if (call == null || call.sessionId == null) return;
    CometChat.endCall(
      call.sessionId!,
      onSuccess: (message) {
        Logger().d('Session ended $message');
      },
      onError: (error) {
        Logger().e('Could not end session $error');
      },
    );

    await Future.delayed(const Duration(milliseconds: 200));
  }

  // This get will make sure that the user has been logged in before actually using it in the code.
  User get user {
    final user = CometChatUIKit.loggedInUser;
    if (user != null) return user;
    throw Exception('Please Login user');
  }
}
