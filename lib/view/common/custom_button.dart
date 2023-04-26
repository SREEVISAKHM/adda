import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title, headerText;
  final Color? color, titleColor;
  final GestureTapCallback? onTap;
  const CustomButton({
    super.key,
    required this.title,
    this.headerText,
    this.onTap,
    this.color,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (headerText != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ' $headerText',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        height(5),
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
              height: 50,
              child: Card(
                color: color,
                elevation: 2,
                child: Center(
                    child: Text(
                  title!,
                  style: TextStyle(
                      color: titleColor ?? Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
              )),
        ),
      ],
    );
  }

  SizedBox height(double height) => SizedBox(
        height: height,
      );
}
