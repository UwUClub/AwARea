import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Utils/Extensions/double_extensions.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              _animationController?.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController?.forward();
            }
          });

    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FadeTransition(
        opacity: _opacityAnimation!,
        child: SvgPicture.asset(
          'assets/images/Logo.svg',
          semanticsLabel: 'Logo',
          width: 300.0.ratioH(),
        ),
      ),
    );
  }
}
