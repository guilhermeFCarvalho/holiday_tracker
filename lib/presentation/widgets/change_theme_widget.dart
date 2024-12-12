import 'package:flutter/material.dart';

class ChangeThemeWidget extends StatefulWidget {
  final void Function() changeTheme;
  final ThemeMode currentTheme;
  const ChangeThemeWidget({
    super.key,
    required this.changeTheme,
    required this.currentTheme,
  });

  @override
  State<ChangeThemeWidget> createState() => _ChangeThemeWidgetState();
}

class _ChangeThemeWidgetState extends State<ChangeThemeWidget> {
  IconData _icon =  Icons.light_mode_outlined;

  void updateIcon() {
    setState(() {
      _icon = _icon == Icons.dark_mode
          ? Icons.light_mode_outlined
          : Icons.dark_mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.changeTheme();
        updateIcon();
      },
      icon: Icon(_icon),
    );
  }
}
