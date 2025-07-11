import 'dart:async';

import 'package:flutter/cupertino.dart';

class ReorderableAnimNotification extends StatefulWidget {
  const ReorderableAnimNotification({required this.child, Key? key, this.onNotification}) : super(key: key);
  final Widget child;
  static bool isScroll = false;
  final Function(ScrollNotification notification)? onNotification;

  @override
  State<StatefulWidget> createState() => ReorderableAnimNotificationState();
}

class ReorderableAnimNotificationState extends State<ReorderableAnimNotification> {
  Timer? _timer;

  void setScroll() {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 100), () {
      ReorderableAnimNotification.isScroll = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        widget.onNotification?.call(notification);
        if (notification is ScrollStartNotification) {
          _timer?.cancel();
          ReorderableAnimNotification.isScroll = true;
        } else if (notification is ScrollUpdateNotification) {
          _timer?.cancel();
          ReorderableAnimNotification.isScroll = true;
        } else if (notification is ScrollEndNotification) {
          setScroll();
        }
        return false;
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
