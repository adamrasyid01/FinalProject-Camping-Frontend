import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

class CustomDialog extends StatelessWidget {
  final MyColor myColor = MyColor();
  final VoidCallback onConfirm;
  final String title;
  final String content;
  final String canceledText;
  final String confirmedText;
  final IconData icon;
  final Color iconBackgroundColor;

  CustomDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.content,
    required this.canceledText,
    required this.confirmedText,
    this.icon = Icons.info, // default icon
    this.iconBackgroundColor = Colors.red, // default background
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: myColor.customWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: AppTextStyle.bold20.copyWith(color: myColor.black)),
                const SizedBox(height: 10),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style:
                      AppTextStyle.semiBold16.copyWith(color: myColor.darkGrey),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColor.lightGrey,
                        ),
                        child: Text(
                          canceledText,
                          style: AppTextStyle.semiBold16
                              .copyWith(color: myColor.customWhite),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColor.customRed,
                          foregroundColor: myColor.customWhite,
                        ),
                        child: Text(
                          confirmedText,
                          style: AppTextStyle.semiBold16
                              .copyWith(color: myColor.customWhite),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -30,
            child: CircleAvatar(
              backgroundColor: iconBackgroundColor,
              radius: 30,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
  String title = 'Dialog Title',
  String content = 'Dialog Content',
  String canceledText = 'Cancel',
  String confirmedText = 'Confirm',
  IconData icon = Icons.info,
  Color iconBackgroundColor = Colors.red,
}) {
  showDialog(
    context: context,
    builder: (context) => CustomDialog(
      onConfirm: onConfirm,
      title: title,
      content: content,
      canceledText: canceledText,
      confirmedText: confirmedText,
      icon: icon,
      iconBackgroundColor: iconBackgroundColor,
    ),
  );
}
