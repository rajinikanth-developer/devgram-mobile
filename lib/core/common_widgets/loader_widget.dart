import 'package:flutter/material.dart';

class LoaderWidget {
  static OverlayEntry? _overlayEntry;

  void show(BuildContext context) {
    hide();
    _overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
