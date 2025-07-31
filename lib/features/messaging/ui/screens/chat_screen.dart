// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:telemedicine_platform_for_remote_areas/app/app_colors.dart';
// import 'package:telemedicine_platform_for_remote_areas/core/widgets/messaging_service.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/message_model.dart';
//
//
// class ChatScreen extends StatefulWidget {
//   final String receiverId;
//   final String receiverName;
//
//   const ChatScreen({
//     super.key,
//     required this.receiverId,
//     required this.receiverName,
//   });
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final String currentUserId = 'patient_1';
//   final TextEditingController _messageController = TextEditingController();
//   List<Message> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//   }
//
//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   void _loadMessages() async {
//     final messagingService = context.read<MessagingService>();
//     await messagingService.loadMessages(currentUserId, widget.receiverId);
//
//     messagingService.messagesStream.listen((appMessages) {
//       setState(() {
//         messages = appMessages;
//       });
//     });
//   }
//
//   void _sendMessage() {
//     if (_messageController.text.trim().isEmpty) return;
//
//     context.read<MessagingService>().sendMessage(
//       senderId: currentUserId,
//       receiverId: widget.receiverId,
//       content: _messageController.text.trim(),
//     );
//
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: AppColors.themeColor,
//               child: Text(
//                 widget.receiverName[0].toUpperCase(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.receiverName,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const Text(
//                     'Online',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: AppColors.textSecondary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.videocam),
//             onPressed: () {
//               // Navigate to video call
//               Navigator.pushNamed(context, '/video_call');
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.call),
//             onPressed: () {
//               // Start voice call
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               reverse: true,
//               padding: const EdgeInsets.all(16),
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[messages.length - 1 - index];
//                 final isMe = message.senderId == currentUserId;
//
//                 return _buildMessageBubble(message, isMe);
//               },
//             ),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageBubble(Message message, bool isMe) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!isMe) ...[
//             CircleAvatar(
//               radius: 16,
//               backgroundColor: AppColors.themeColor,
//               child: Text(
//                 widget.receiverName[0].toUpperCase(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//           ],
//           Flexible(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: isMe ? AppColors.themeColor : AppColors.cardColor,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.1),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     message.content,
//                     style: TextStyle(
//                       color: isMe ? Colors.white : AppColors.textPrimary,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     _formatTime(message.timestamp),
//                     style: TextStyle(
//                       color: isMe ? Colors.white70 : AppColors.textSecondary,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isMe) ...[
//             const SizedBox(width: 8),
//             const CircleAvatar(
//               radius: 16,
//               backgroundColor: AppColors.secondaryColor,
//               child: Text(
//                 'Y',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.cardColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 8,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _messageController,
//                 decoration: InputDecoration(
//                   hintText: 'Type a message...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: AppColors.backgroundColor,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 12,
//                   ),
//                 ),
//                 onSubmitted: (_) => _sendMessage(),
//               ),
//             ),
//             const SizedBox(width: 12),
//             GestureDetector(
//               onTap: _sendMessage,
//               child: Container(
//                 width: 48,
//                 height: 48,
//                 decoration: const BoxDecoration(
//                   color: AppColors.themeColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.send,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _formatTime(DateTime dateTime) {
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);
//
//     if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/app/app_colors.dart';
import 'package:telemedicine_platform_for_remote_areas/core/widgets/messaging_service.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/chat_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/message_model.dart';


class ChatScreen extends StatelessWidget {
  final String receiverId;
  final String receiverName;
  final String currentUserId = 'patient_1';

  ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ChatController(
        messagingService: Get.find<MessagingService>(), // Make sure MessagingService is registered with Get.put()
        currentUserId: currentUserId,
        receiverId: receiverId,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.themeColor,
              child: Text(
                receiverName[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(receiverName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const Text('Online', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () => Navigator.pushNamed(context, '/video_call')),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[controller.messages.length - 1 - index];
                  final isMe = message.senderId == currentUserId;
                  return _buildMessageBubble(message, isMe);
                },
              );
            }),
          ),
          _buildMessageInput(controller),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message, bool isMe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.themeColor,
              child: Text(receiverName[0].toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          if (!isMe) const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.themeColor : AppColors.cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.content, style: TextStyle(color: isMe ? Colors.white : AppColors.textPrimary, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(_formatTime(message.timestamp), style: TextStyle(color: isMe ? Colors.white70 : AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
          ),
          if (isMe)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: CircleAvatar(radius: 16, backgroundColor: AppColors.secondaryColor, child: Text('Y', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(ChatController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onSubmitted: (_) => _sendMessage(controller),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _sendMessage(controller),
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(color: AppColors.themeColor, shape: BoxShape.circle),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(ChatController controller) {
    controller.sendMessage(_messageController.text);
    _messageController.clear();
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
    return 'Just now';
  }
}
