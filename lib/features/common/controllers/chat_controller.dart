import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/core/widgets/messaging_service.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/message_model.dart';

class ChatController extends GetxController {
  final MessagingService messagingService;
  final String currentUserId;
  final String receiverId;

  var messages = <Message>[].obs;

  ChatController({
    required this.messagingService,
    required this.currentUserId,
    required this.receiverId,
  });

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void loadMessages() async {
    await messagingService.loadMessages(currentUserId, receiverId);
    messagingService.messagesStream.listen((msgList) {
      messages.value = msgList;
    });
  }

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;
    messagingService.sendMessage(
      senderId: currentUserId,
      receiverId: receiverId,
      content: content.trim(),
    );
  }
}
