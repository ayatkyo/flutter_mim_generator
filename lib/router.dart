import 'package:mim_generator/models/meme.dart';
import 'package:mim_generator/ui/views/editor/editor_page.dart';
import 'package:mim_generator/ui/views/error_page.dart';
import 'package:mim_generator/ui/views/home/home_page.dart';
import 'package:mim_generator/ui/views/share/share_page.dart';
import 'package:mim_generator/ui/views/wip_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Routes {
  static const String home = "home";
  static const String editor = "editor";
  static const String share = "share";
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
      buildRoute(Routes.home, path: "/", page: HomePage(), routes: [
        buildRoute(
          Routes.editor,
          path: "editor",
          builder: (state) => EditorPage(state.extra! as Meme),
        ),
        buildRoute(
          Routes.share,
          path: "share",
          builder: (state) => SharePage(state.extra! as String),
        ),
      ]),
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
  List<RouteBase> routes = const <RouteBase>[],
}) {
  return GoRoute(
    path: path ?? "/$name",
    name: name,
    pageBuilder: (context, state) => buildPage(state, page ?? builder!(state)),
    routes: routes,
  );
}
