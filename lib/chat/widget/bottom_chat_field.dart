import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';

// class BottomChatField extends StatefulWidget {
//   const BottomChatField({super.key});

//   @override
//   State<BottomChatField> createState() => _BottomChatFieldState();
// }

// class _BottomChatFieldState extends State<BottomChatField> {
//   bool isShowSendButton = false;
//   final TextEditingController _messageController = TextEditingController();
//   // FlutterSoundRecorder? _soundRecorder;
//   bool isRecorderInit = false;
//   bool isShowEmojiContainer = false;
//   bool isRecording = false;
//   FocusNode focusNode = FocusNode();

//   void sendTextMessage() async {
//     if (isShowSendButton) {
//       // ref.read(chatControllerProvider).sendTextMessage(
//       //       context,
//       //       _messageController.text.trim(),
//       //       widget.recieverUserId,
//       //       widget.isGroupChat,
//       //     );
//       setState(() {
//         _messageController.text = '';
//       });
//     } else {
//       // var tempDir = await getTemporaryDirectory();
//       // var path = '${tempDir.path}/flutter_sound.aac';
//       if (!isRecorderInit) {
//         return;
//       }
//       // if (isRecording) {
//       //   await _soundRecorder!.stopRecorder();
//       //   sendFileMessage(File(path), MessageEnum.audio);
//       // } else {
//       //   await _soundRecorder!.startRecorder(
//       //     toFile: path,
//       //   );
//       // }

//       setState(() {
//         isRecording = !isRecording;
//       });
//     }
//   }

//   // void sendFileMessage(
//   //   File file,
//   //   MessageEnum messageEnum,
//   // ) {
//   //   ref.read(chatControllerProvider).sendFileMessage(
//   //         context,
//   //         file,
//   //         widget.recieverUserId,
//   //         messageEnum,
//   //         widget.isGroupChat,
//   //       );
//   // }

//   // void selectImage() async {
//   //   File? image = await pickImageFromGallery(context);
//   //   if (image != null) {
//   //     sendFileMessage(image, MessageEnum.image);
//   //   }
//   // }

//   // void selectVideo() async {
//   //   File? video = await pickVideoFromGallery(context);
//   //   if (video != null) {
//   //     sendFileMessage(video, MessageEnum.video);
//   //   }
//   // }

//   // void selectGIF() async {
//   //   final gif = await pickGIF(context);
//   //   if (gif != null) {
//   //     ref.read(chatControllerProvider).sendGIFMessage(
//   //           context,
//   //           gif.url,
//   //           widget.recieverUserId,
//   //           widget.isGroupChat,
//   //         );
//   //   }
//   // }

//   void hideEmojiContainer() {
//     setState(() {
//       isShowEmojiContainer = false;
//     });
//   }

//   void showEmojiContainer() {
//     setState(() {
//       isShowEmojiContainer = true;
//     });
//   }

//   void showKeyboard() => focusNode.requestFocus();
//   void hideKeyboard() => focusNode.unfocus();

//   void toggleEmojiKeyboardContainer() {
//     if (isShowEmojiContainer) {
//       showKeyboard();
//       hideEmojiContainer();
//     } else {
//       hideKeyboard();
//       showEmojiContainer();
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _messageController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final messageReply = ref.watch(messageReplyProvider);
//     //final isShowMessageReply = messageReply != null;
//     return Column(
//       children: [
//         // isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 focusNode: focusNode,
//                 controller: _messageController,
//                 keyboardType: TextInputType.text,
//                 onChanged: (val) {
//                   if (val.isNotEmpty) {
//                     setState(() {
//                       isShowSendButton = true;
//                     });
//                   } else {
//                     setState(() {
//                       isShowSendButton = false;
//                     });
//                   }
//                 },
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: mobileChatBoxColor,
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: SizedBox(
//                       width: 100,
//                       child: Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               toggleEmojiKeyboardContainer;
//                             },
//                             icon: const Icon(
//                               Icons.emoji_emotions,
//                               color: boxShadow,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               // selectGIF,
//                             },
//                             icon: const Icon(
//                               Icons.gif,
//                               color: boxShadow,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   suffixIcon: SizedBox(
//                     width: 100,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             //selectImage,
//                           },
//                           icon: const Icon(
//                             Icons.camera_alt,
//                             color: boxShadow,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             //selectVideo,
//                           },
//                           icon: const Icon(
//                             Icons.attach_file,
//                             color: boxShadow,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   hintText: 'Type a message!',
//                   hintStyle: RTSTypography.buttonText.copyWith(fontSize: 14),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: const BorderSide(
//                       width: 0,
//                       style: BorderStyle.none,
//                     ),
//                   ),
//                   contentPadding: const EdgeInsets.all(10),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 bottom: 8,
//                 right: 2,
//                 left: 2,
//               ),
//               child: CircleAvatar(
//                 backgroundColor: const Color(0xFF128C7E),
//                 radius: 25,
//                 child: GestureDetector(
//                     child: Icon(
//                       isShowSendButton
//                           ? Icons.send
//                           : isRecording
//                               ? Icons.close
//                               : Icons.mic,
//                       color: Colors.white,
//                     ),
//                     onTap: () {
//                       sendTextMessage;
//                     }),
//               ),
//             ),
//           ],
//         ),
//         isShowEmojiContainer
//             ? SizedBox(
//                 height: 310,
//                 child: EmojiPicker(
//                   onEmojiSelected: ((category, emoji) {
//                     setState(() {
//                       _messageController.text =
//                           _messageController.text + emoji.emoji;
//                     });

//                     if (!isShowSendButton) {
//                       setState(() {
//                         isShowSendButton = true;
//                       });
//                     }
//                   }),
//                 ),
//               )
//             : const SizedBox(),
//       ],
//     );
//   }
// }
class BottomChatField extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onSend;
  final VoidCallback onToggleEmojiKeyboard;
  final bool isShowEmojiContainer;
  final bool isShowSendButton;
  final Function(String) onTextChanged;

  const BottomChatField({
    required this.messageController,
    required this.onSend,
    required this.onToggleEmojiKeyboard,
    required this.isShowEmojiContainer,
    required this.isShowSendButton,
    required this.onTextChanged,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: mobileChatBoxColor, // Background color
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                isShowEmojiContainer ? Icons.keyboard : Icons.emoji_emotions,
                color: Colors.white, // Icon color
              ),
              onPressed: onToggleEmojiKeyboard,
            ),
            Expanded(
              child: TextField(
                controller: messageController,
                onChanged: onTextChanged,
                style:
                    const TextStyle(color: Colors.white), // Entered text color
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle:
                      const TextStyle(color: Colors.white), // Hint text color
                  filled: true,
                  fillColor: mobileChatBoxColor, // Same as container background
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isShowSendButton ? Icons.send : Icons.mic,
                color: Colors.white, // Icon color
              ),
              onPressed: isShowSendButton ? onSend : null,
            ),
          ],
        ),
      ),
    );
  }
}
