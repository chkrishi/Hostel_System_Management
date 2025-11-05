import 'package:flutter/material.dart';
import 'package:univproject/Screens/color.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double font_and_icon_size;
  final String text;
  final IconData? icon;
  final Image? image;
  final VoidCallback onTap;
  final bool isEnabled;

  const CustomButton({
    super.key,
    this.font_and_icon_size = 14,
    this.height = 40,
    this.width = 258,
    required this.text,
    this.icon,
    this.image,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: isEnabled
              ? LinearGradient(
                  colors: const [
                    AppColors.gradientcolor1,
                    AppColors.gradirntcolor2
                  ],
                  begin: icon != null || image != null
                      ? Alignment.topCenter
                      : Alignment.centerLeft,
                  end: icon != null || image != null
                      ? Alignment.bottomCenter
                      : Alignment.centerRight,
                )
              : null,
          color: isEnabled ? null : AppColors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null) image!,
            if (icon != null)
              Icon(icon, color: AppColors.white, size: font_and_icon_size),
            if (icon != null || image != null) const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: font_and_icon_size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
