import 'package:flutter/material.dart';
import 'package:animations/animations.dart';



class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.child,
    required this.nextScreen,
    this.borderradius = 25.0,
  });

  final Widget child;
  final Widget nextScreen;
  final double borderradius;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderradius)),
      ),
      closedColor:  Color(0xFFE5E6E8),
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 850),
      closedBuilder: (_, VoidCallback openContainer) {
        return InkWell(onTap: openContainer, child: child);
      },
      openBuilder: (_, __) => nextScreen,
    );
  }
}
