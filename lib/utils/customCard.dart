import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/chat/screen/chat_screen.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/model/task.dart';

class CustomCard extends StatelessWidget {
  final Task task; // Define the task parameter

  // Constructor to accept task data
  CustomCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: boxShadow.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Chip(
                label: Text(task.heading1,
                    style: RTSTypography.buttonText
                        .copyWith(color: headingColor1)),
                backgroundColor: boxColor1,
                shape: null,
              ),
              const SizedBox(width: 25),
              Chip(
                label: Text(task.heading2,
                    style: RTSTypography.buttonText
                        .copyWith(color: headingColor2)),
                backgroundColor: boxColor2,
                shape: null,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              task.bodyText1,
              style: RTSTypography.buttonText
                  .copyWith(fontWeight: FontWeight.w500, color: textColor),
            ),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              task.bodyText2,
              style: RTSTypography.buttonText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: textColor.withOpacity(0.60)),
            ),
          ),
          const SizedBox(height: 16.0),
          const Divider(height: 20.0, color: boxShadow),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ChatScreen.routeName);
                      },
                      icon: const Icon(Icons.chat)),
                  const SizedBox(width: 8.0),
                  Text(task.teamId,
                      style:
                          RTSTypography.buttonText.copyWith(color: textColor)),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16.0, color: boxShadow),
                  const SizedBox(width: 4.0),
                  Text(task.date, style: RTSTypography.smallText2),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

