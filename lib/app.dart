import 'package:mim_generator/router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_context/one_context.dart';

class App extends ConsumerWidget {
  const App({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    final botToastBuilder = BotToastInit();

    return MaterialApp.router(
      title: "Test Algostudio - Flutter Developer",
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", ""),
        Locale("id", ""),
      ],
      builder: (context, child) {
        //  OneContext
        child = OneContext().builder(context, child);

        //  Toast
        child = botToastBuilder(context, child);

        return child;
      },
    );
  }
}