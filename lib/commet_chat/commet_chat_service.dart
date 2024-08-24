import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:logger/logger.dart';

class CommetChatService {
  CommetChatService._();
  static final CommetChatService instance = CommetChatService._();

  // These are just for testing purpose in production app you will create your own user using self generated auth_token
  static const String userId_1 = 'cometchat-uid-1';
  static const String userId_2 = 'cometchat-uid-2';

  // This is the user that we get once we have logged into comet chat
  User? _user;

  // This intialization is necessary to make sure to connect the commet chat application
  Future<void> initalize() async {
    final UIKitSettingsBuilder builder = UIKitSettingsBuilder();
    builder.subscriptionType = CometChatSubscriptionType.allUsers;
    builder.autoEstablishSocketConnection = true;
    builder.region = 'IN';
    builder.appId = '262815bd015b8e63';
    builder.authKey = 'a458a53052635c4da34576bf2ec6848b55194d62';
    builder.extensions = CometChatUIKitChatExtensions.getDefaultExtensions();

    final UIKitSettings uiKitSettings = builder.build();
    await CometChatUIKit.init(
      uiKitSettings: uiKitSettings,
      onSuccess: (String successMessage) {},
      onError: (CometChatException error) {},
    );
  }

  // Before enabling any communication between users we need to login that user in comet chat
  // This doesn't need to be a manual process. we can do that behind the scenes without use knowing anything.
  Future<void> login(String userId) async {
    final User? user = await CometChatUIKit.login(userId);
    if (user == null) {
      Logger().w('No user found with the porvided userId: $userId');
      return;
    }
    _user = user;
  }

  // This get will make sure that the user has been logged in before actually using it in the code.
  User get user {
    if (_user != null) return _user!;
    throw Exception('Please Login user');
  }
}
