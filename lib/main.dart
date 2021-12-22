import 'screens/pin_common_screen.dart';
import 'utilities/storage/shared_preference/shared_preferences_util.dart';

import 'navigation/navigation_utils.dart';
import 'package:flutter/material.dart';

void main() {
  setupApp();
}

Future<void> setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtil.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cake Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cake Wallet',
          style: TextStyle(color: Colors.white60),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _expandedButtonView(
              splashColor: Colors.green,
              text: 'Set Pin',
              onTap: () {
                NavigationUtils.moveToPinConfirmationScreen(context, title: 'Set Pin', pinConfig: PinConfig.SET_PIN);
              }),
          _expandedButtonView(
              splashColor: Colors.blue,
              text: 'Verify Pin',
              onTap: () {
                NavigationUtils.moveToPinConfirmationScreen(context, title: 'Verify Pin', pinConfig: PinConfig.VERIFY_PIN);
              }),
        ],
      ),
    );
  }

  Widget _expandedButtonView({required Color splashColor, required String text, required Function() onTap}) {
    final child = InkWell(
        splashColor: splashColor,
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: splashColor.withOpacity(0.7),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));

    return Expanded(child: child);
  }
}
