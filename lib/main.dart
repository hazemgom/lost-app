import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_stone/feature/authentication/sign_screen.dart';
import 'package:save_stone/feature/homePage/home_page.dart';
import 'package:save_stone/feature/onboarding/onboarding_screen.dart';
import 'package:save_stone/helper/components/bloc_observe/observe.dart';
import 'package:save_stone/helper/components/shared_preferences.dart';

dynamic uId = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');
  bool onboarding = CacheHelper.getData(key: 'onboardingIsSeen') ?? false;
  Widget startWidget = OnboardingScreen();
  print(uId);
  if (onboarding) {
    if (uId == '' || uId == null) {
      startWidget = const SignUpScreen();
    } else {
      startWidget = const HomeLayout();
    }
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp(this.startWidget, {super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade100),
      ),
      home: startWidget,
    );
  }
}
