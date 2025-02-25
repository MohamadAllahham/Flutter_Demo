import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

const isTabMetaKey = 'isTab';

// routes with parameters require usePathAsKey to be true
// https://stackoverflow.com/questions/69700775/how-do-i-refresh-the-current-route-when-arguments-change
@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/home',
      page: MainRoute.page,
      children: [
        AutoRoute(
          path: 'home1',
          page: HomeRoute.page,
          usesPathAsKey: true,
          meta: {isTabMetaKey: true},
        ),
      ]
    ),
  ];
}
