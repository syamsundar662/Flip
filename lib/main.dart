import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/business_logic/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:flip/application/presentation/screens/get_started_screen/get_started.dart';
import 'package:flip/application/presentation/screens/home_screen/home_screem.dart';
import 'package:flip/application/presentation/screens/home_screen/home_shimmer.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flip/application/presentation/widgets/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:flip/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( 
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<BottomNavBarBloc>(create: (context)=>BottomNavBarBloc())
        ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flip',
          theme: ThemeData.light(), 
          darkTheme: ThemeData.dark(), 
          home: splash()),
    );
  }

  StreamBuilder<User?> splash() {
    return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return AnimatedSplashScreen(
                pageTransitionType: PageTransitionType.rightToLeft, 
                backgroundColor: Colors.black, 
                animationDuration: const Duration(milliseconds: 1000),
                splashIconSize: double.infinity,
                splash: const SplashScreen(),
                nextScreen:
                    snapshot.hasData ? const RootScreen  () : const GetStartedScreen(),
              );
            });
  }
}
