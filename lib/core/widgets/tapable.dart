import 'package:flutter/material.dart';

class Tapable extends StatefulWidget {
  final Function()? onTap;
  final Widget child;

  const Tapable({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  State<Tapable> createState() => _TapableState();
}

class _TapableState extends State<Tapable> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = Tween(begin: 1.0, end: 0.92).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          tapped();
        }
      });

    super.initState();
  }

  void tapped() {
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: widget.onTap == null
          ? widget.child
          : InkWell(
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              onTap: () => _controller.forward(),
              child: widget.child,
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
