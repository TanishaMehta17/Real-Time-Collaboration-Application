// import 'package:flutter/material.dart';
// import 'package:real_time_collaboration_application/chat/widget/bottom_chat_field.dart';
// import 'package:real_time_collaboration_application/chat/widget/display_text_image_gif.dart';
// import 'package:real_time_collaboration_application/chat/widget/enum.dart';
// import 'package:real_time_collaboration_application/common/colors.dart';

// class ChatScreen extends StatefulWidget {
//   static const String routeName = '/chat-screen';
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final ScrollController messageController = ScrollController();

//   void onMessageSwipe(String message, bool isMe, String type) {
//     // Add your swipe handling logic here
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               gradientColor1,
//               gradientColor2,
//               gradientColor1,
//             ],
//             stops: [0.2, 0.5, 1.0],
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Expanded(
//               child: StreamBuilder(
//                 stream: null, // Replace with your stream
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasData && snapshot.data != null) {
//                     return ListView.builder(
//                       controller: messageController,
//                       itemCount: 10, // Replace with snapshot.data.length
//                       itemBuilder: (context, index) {
//                         // Replace with actual message data
//                          String message = "Message $index"; // Example message
//                         const bool isReplying = true;
//                         const String username = "Username";
//                         const String repliedText = "Replied message";
//                         const String date = "12:00 PM";
//                         const bool isSeen = true;
//                         const MessageEnum type = MessageEnum.text;
//                         const MessageEnum repliedMessageType = MessageEnum.text;

//                         return Align(
//                           alignment: Alignment.centerRight,
//                           child: ConstrainedBox(
//                             constraints: BoxConstraints(
//                               maxWidth: MediaQuery.of(context).size.width - 45,
//                             ),
//                             child: Card(
//                               elevation: 1,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               color: messageColor,
//                               margin: const EdgeInsets.symmetric(
//                                 horizontal: 15,
//                                 vertical: 5,
//                               ),
//                               child: Stack(
//                                 children: [
//                                   Padding(
//                                     padding: type == MessageEnum.text
//                                         ? const EdgeInsets.only(
//                                             left: 10,
//                                             right: 30,
//                                             top: 5,
//                                             bottom: 20,
//                                           )
//                                         : const EdgeInsets.only(
//                                             left: 5,
//                                             top: 5,
//                                             right: 5,
//                                             bottom: 25,
//                                           ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         if (isReplying) ...[
//                                         const  Text(
//                                             username,
//                                             style:  TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 3),
//                                           Container(
//                                             padding: const EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                               color: backgroundColor
//                                                   .withOpacity(0.5),
//                                               borderRadius:
//                                                   const BorderRadius.all(
//                                                 Radius.circular(5),
//                                               ),
//                                             ),
//                                             child: const DisplayTextImageGIF(
//                                               message: repliedText,
//                                               type: repliedMessageType,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 8),
//                                         ],
//                                         DisplayTextImageGIF(
//                                           message: message,
//                                           type: type,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 const  Positioned(
//                                     bottom: 4,
//                                     right: 10,
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           date,
//                                           style:  TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.white60,
//                                           ),
//                                         ),
//                                          SizedBox(width: 5),
//                                         Icon(
//                                           isSeen
//                                               ? Icons.done_all
//                                               : Icons.done,
//                                           size: 20,
//                                           color: isSeen
//                                               ? Colors.blue
//                                               : Colors.white60,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                   return const Center(child: Text('No messages found.'));
//                 },
//               ),
//             ),
//             const BottomChatField(),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:real_time_collaboration_application/chat/widget/bottom_chat_field.dart';
import 'package:real_time_collaboration_application/common/colors.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat-screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<String> messages = [];
  bool isShowEmojiContainer = false;
  bool isShowSendButton = false;

  void sendTextMessage() {
    if (messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(messageController.text.trim());
        messageController.clear();
        isShowSendButton = false;
      });
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void toggleEmojiKeyboardContainer() {
    setState(() {
      isShowEmojiContainer = !isShowEmojiContainer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientColor1,
              gradientColor2,
              gradientColor1,
            ],
            stops: [0.2, 0.5, 1.0],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment:
                        Alignment.centerRight, // Align messages to the right
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: messageColor,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          messages[index], // Display the message content
                          style: const TextStyle(
                            color: Colors.white, // Set text color to white
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            BottomChatField(
              messageController: messageController,
              onSend: sendTextMessage,
              onToggleEmojiKeyboard: toggleEmojiKeyboardContainer,
              isShowEmojiContainer: isShowEmojiContainer,
              isShowSendButton: isShowSendButton,
              onTextChanged: (text) {
                setState(() {
                  isShowSendButton = text.trim().isNotEmpty;
                });
              },
            ),
            if (isShowEmojiContainer)
              SizedBox(
                height: 310,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    messageController.text += emoji.emoji;
                    setState(() {
                      isShowSendButton =
                          messageController.text.trim().isNotEmpty;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
