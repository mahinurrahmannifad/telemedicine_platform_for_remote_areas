import 'dart:async';
import 'package:telemedicine_platform_for_remote_areas/core/database/doctor_database_helper.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/message_model.dart';
import 'package:uuid/uuid.dart';

class MessagingService {
  final DoctorDatabaseService _databaseService = DoctorDatabaseService.instance;
  final StreamController<List<Message>> _messagesController = StreamController<List<Message>>.broadcast();
  final Uuid _uuid = const Uuid();

  Stream<List<Message>> get messagesStream => _messagesController.stream;

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
    MessageType type = MessageType.text,
  }) async {
    final message = Message(
      id: _uuid.v4(),
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      type: type,
      timestamp: DateTime.now(),
    );

    await _databaseService.insertMessage(message);
    await _refreshMessages(senderId, receiverId);
  }

  Future<void> loadMessages(String userId1, String userId2) async {
    await _refreshMessages(userId1, userId2);
  }

  Future<void> _refreshMessages(String userId1, String userId2) async {
    final messages = await _databaseService.getMessagesBetweenUsers(userId1, userId2);
    _messagesController.add(messages);
  }

  void dispose() {
    _messagesController.close();
  }
}


// import 'package:get/get.dart';
// import 'package:telemedicine_platform_for_remote_areas/core/database/doctor_database_helper.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/message_model.dart';
// import 'package:uuid/uuid.dart';
//
// class MessagingController extends GetxController {
//   final DoctorDatabaseService _databaseService = DoctorDatabaseService.instance;
//   final Uuid _uuid = const Uuid();
//
//   var messages = <Message>[].obs;
//
//   Future<void> sendMessage({
//     required String senderId,
//     required String receiverId,
//     required String content,
//     MessageType type = MessageType.text,
//   }) async {
//     final message = Message(
//       id: _uuid.v4(),
//       senderId: senderId,
//       receiverId: receiverId,
//       content: content,
//       type: type,
//       timestamp: DateTime.now(),
//     );
//
//     await _databaseService.insertMessage(message);
//     await loadMessages(senderId, receiverId);
//   }
//
//   Future<void> loadMessages(String userId1, String userId2) async {
//     final loadedMessages =
//     await _databaseService.getMessagesBetweenUsers(userId1, userId2);
//     messages.assignAll(loadedMessages);
//   }
// }
