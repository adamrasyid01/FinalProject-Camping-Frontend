import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

class CustomDialog extends StatelessWidget {
  final MyColor myColor = MyColor();
  final VoidCallback onConfirm;
  final String title;
  final String content;
  final String? canceledText; // ubah ke nullable
  final String? confirmedText; // ubah ke nullable
  final IconData icon;
  final Color iconBackgroundColor; // Remove default value here
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final TextAlign? alignContent; // Add alignContent as a nullable property

  CustomDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.content,
    this.canceledText, // tidak required
    this.confirmedText, // tidak required
    this.icon = Icons.info,
    this.titleStyle,
    this.contentStyle,
    this.alignContent, // Initialize alignContent in the constructor
    this.iconBackgroundColor =
        Colors.red, // Add iconBackgroundColor to constructor with default value
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
                Text(
                  title,
                  style: titleStyle ??
                      AppTextStyle.bold20.copyWith(color: myColor.black),
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  textAlign: alignContent ?? TextAlign.center,
                  style: contentStyle ??
                      AppTextStyle.semiBold16.copyWith(color: myColor.darkGrey),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (canceledText != null) // hanya tampil kalau tidak null
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: myColor.lightGrey,
                          ),
                          child: Text(
                            canceledText!,
                            style: AppTextStyle.semiBold16
                                .copyWith(color: myColor.customWhite),
                          ),
                        ),
                      ),
                    if (canceledText != null && confirmedText != null)
                      const SizedBox(
                          width: 10), // kasih jarak kalau dua-duanya ada
                    if (confirmedText != null) // hanya tampil kalau tidak null
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
                            confirmedText!,
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
  String? canceledText, // nullable
  String? confirmedText, // nullable
  IconData icon = Icons.info,
  Color iconBackgroundColor = Colors.red,
  TextStyle? titleStyle,
  TextStyle? contentStyle,
  TextAlign? alignContent, // nullable
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
      titleStyle: titleStyle,
      contentStyle: contentStyle,
      alignContent: alignContent, // pass alignContent to CustomDialog
    ),
  );
}
void showCustomDialogAutoDismiss({
  required BuildContext context,
  String title = 'Dialog Title',
  String content = 'Dialog Content',
  IconData icon = Icons.info,
  Color iconBackgroundColor = Colors.red,
  TextStyle? titleStyle,
  TextStyle? contentStyle,
  TextAlign? alignContent,
  Duration duration = const Duration(seconds: 1),
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      Future.delayed(duration, () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
      return CustomDialog(
        onConfirm: () {},
        title: title,
        content: content,
        canceledText: null,
        confirmedText: null,
        icon: icon,
        iconBackgroundColor: iconBackgroundColor,
        titleStyle: titleStyle,
        contentStyle: contentStyle,
        alignContent: alignContent,
      );
    },
  );
}
