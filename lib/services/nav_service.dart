import 'package:auto_route/auto_route.dart';
import 'package:flutter_common/logging.dart';

import '../app_router.dart';

class NavService {
  static final logger = createLogger(NavService);
  final AppRouter appRouter;
  PageRouteInfo<dynamic> defaultRoute;

  StackRouter get _router {
    RoutingController? router = appRouter.topMostRouter();
    while (router != null && router is! StackRouter) {
      router = router.parent();
    }
    return router as StackRouter;
  }

  NavService(this.appRouter, {required this.defaultRoute});

  /// Pushes a route.
  Future<T?> push<T>(PageRouteInfo route) async {
    logger.t('push ${route.routeName}');
    return await _router.push<T>(route);
  }

  /// Clears all routes and replaces the last one, instead of just replacing the top.
  Future<T?> replaceAll<T>(PageRouteInfo route) async {
    logger.t('replace all');
    _router.removeUntil((route) => false);
    return await push(route);
  }

  /// Attempts to pop(). Pushes a route instead if it fails.
  Future<void> popOrPush<T extends Object?>({
    T? result,
    required PageRouteInfo route,
  }) async {
    if (_canPop()) {
      logger.t('pop with result $result');
      await _router.maybePopTop(result);
    } else {
      logger.t('cannot pop, pushing ${route.routeName} instead');
      await push<void>(route);
    }
  }

  /// Runs pop() on the toplevel router.
  Future<void> pop<T extends Object?>([T? result]) async {
    await popOrPush(
      result: result,
      route: defaultRoute,
    );
  }

  /// Clears all routes, until a tab is reached.
  Future<void> backToTab({PageRouteInfo? fallbackRoute}) async {
    logger.t('back to tab');
    _router.removeUntil((route) {
      return route.meta.containsKey(isTabMetaKey);
    });
    if (!_router.current.meta.containsKey(isTabMetaKey)) {
      logger.t('No Tab found, pushing fallback');
      await push<void>(fallbackRoute ?? defaultRoute);
    }
  }

  /// Returns true, if there are other routes on the same stack.
  bool _canPop() {
    return _router.canPop(ignoreParentRoutes: true);
  }

  /// Retrieves a bool query parameter.
  bool getQueryParamAsBool(String name, [bool defaultValue = false]) {
    final queryParams = _router.current.route.queryParams;
    dynamic param = queryParams.get(name, defaultValue);
    // Query parameters passed by flutter are of type bool.
    if (param is bool) return param;
    // Query parameters passed by the browser are of type String.
    return queryParams.getBool(name, defaultValue);
  }
}
