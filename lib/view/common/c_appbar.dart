import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;

  const CommonAppBar({Key? key, required this.title, required this.backButton})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton
          ? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))
          : const Align(
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person)),
              ),
            ),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
