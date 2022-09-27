import 'package:mim_generator/ui/views/error_page.dart';
import 'package:mim_generator/ui/views/home/home_page.dart';
import 'package:mim_generator/ui/views/wip_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Routes {
  static const String home = "home";
  static const String editor = "editor";
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    observers: [
      BotToastNavigatorObserver(),
    ],
    errorBuilder: (context, state) => ErrorPage(state.error),
    routes: [
      buildRoute(Routes.home, path: "/", page: HomePage()),
      buildRoute(Routes.editor, page: WipPage()),
    ],
  );
});

//  HELPER
buildPage(GoRouterState state, Widget page) {
  return CupertinoPage(
    key: state.pageKey,
    child: page,
  );
}

buildRoute(
  String name, {
  String? path,
  Widget? page,
  Function(GoRouterState)? builder,
}) {
  return GoRoute(
    path: path ?? "/$name",
    name: name,
    pageBuilder: (context, state) => buildPage(state, page ?? builder!(state)),
  );
}
