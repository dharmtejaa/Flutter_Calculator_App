import 'package:flutter/material.dart';

/// Custom button widget for calculator.
class CustomButton extends StatelessWidget {
  final String? title;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback onPress;

  const CustomButton({
    super.key,
    this.title,
    required this.textColor,
    required this.buttonColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.22,
        height: MediaQuery.of(context).size.height * 0.077,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: buttonColor,
        ),
        child:
            title == ''
                ? Icon(
                  Icons.backspace_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.onSecondary,
                )
                : Text(
                  title!,
                  style: TextStyle(fontSize: 33, color: textColor),
                ),
      ),
    );
  }
}