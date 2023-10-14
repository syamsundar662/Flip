import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/get_started_screen/get_started.dart';
import 'package:flip/application/presentation/screens/home_screen/home.dart';
import 'package:flip/application/presentation/screens/splash_screen/splash_screen.dart';
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
        BlocProvider<AuthBloc>(create: (context)=>AuthBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flip',
        theme: ThemeData(colorScheme: const ColorScheme.light(onPrimary: Colors.white)),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {

              return  
              AnimatedSplashScreen(
  pageTransitionType: PageTransitionType.rightToLeft  , 
  backgroundColor: Colors.black,
  animationDuration: Duration(milliseconds: 2000),
  splashIconSize: double.infinity,
  splash: SplashScreen(),
  nextScreen: snapshot.hasData ? HomePage() : GetStartedScreen(),
);
            }
         
        ) 


      ),
    );
  }
}
