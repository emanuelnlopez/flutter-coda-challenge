import 'package:crud/src/core/core.dart';
import 'package:crud/src/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Injector _injector;

  @override
  void initState() {
    super.initState();
    _injector = DefaultInjector();
    _injector.initialize();
  }

  @override
  void dispose() {
    _injector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: _injector.isInitialized(),
      stream: _injector.initializationStream,
      builder: (context, snapshot) {
        Widget result = MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute:
              snapshot.data == true ? AppRouter.generatedRoutes : null,
          navigatorKey: snapshot.data == true ? _injector.navigatorKey : null,
          title: 'Minimal',
          home: snapshot.data == true ? null : LoadingScreen(),
        );

        if (snapshot.data == true) {
          result = Provider<Injector>.value(
            value: _injector,
            child: result,
          );
        }

        return result;
      },
    );
  }
}
