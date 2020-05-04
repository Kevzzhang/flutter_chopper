import 'package:flutter/material.dart';
import 'package:flutterwithchopper/constant.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'data/post_api_service.dart';
import 'screens/home_page.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name} : ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      // The initialized PostApiService is now available down the widget tree
      create: (_) => PostApiService.create(),
      // Always call dispose on the ChopperClient to release resources
      dispose: (context, PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        navigatorKey: kGetAliceLib().getNavigatorKey(),
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}