import 'package:flutter/material.dart';

class PulsingBackground extends StatefulWidget {
  const PulsingBackground({super.key});

  @override
  _PulsingBackgroundState createState() => _PulsingBackgroundState();
}

class _PulsingBackgroundState extends State<PulsingBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _colorAnimation =
        ColorTween(begin: Colors.red.withOpacity(0.6), end: Colors.red).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'Live Now',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white, fontSize: 20),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
