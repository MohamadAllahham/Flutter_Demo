import 'package:flutter/material.dart';
import 'package:flutter_common/layout/responsive.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //final content = const Text('home screen');

    return Responsive(
      breakpoints: {
        ResponsiveBreakpoints.mobile.width: Text('home screen'),
        ResponsiveBreakpoints.tablet.width: Center(child: Text('home screen')),
      },
    );
  }
}
