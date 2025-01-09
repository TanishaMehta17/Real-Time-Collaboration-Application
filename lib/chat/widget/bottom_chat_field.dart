import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';


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
