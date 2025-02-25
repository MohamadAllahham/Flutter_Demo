import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/layout/responsive.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {

    return AutoRouter(
      builder: (context, content) {
        return Scaffold(
          body: Responsive(
            breakpoints: {
              ResponsiveBreakpoints.mobile.width: Text('home screen'),
              ResponsiveBreakpoints.desktop.width: Row(
                children: [
                  Expanded(child: Text('home screen')),
                ],
              ),
            },
          ),
        );
      },
    );
  }
}
