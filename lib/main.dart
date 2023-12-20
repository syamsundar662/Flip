import 'package:flip/application/business_logic/bloc/comment/comments_bloc.dart';
import 'package:flip/application/business_logic/bloc/follow/follow_bloc.dart';
import 'package:flip/application/business_logic/bloc/home/fetch_bloc.dart';
import 'package:flip/application/business_logic/bloc/post/post_bloc.dart';
import 'package:flip/application/business_logic/bloc/search/search_bloc.dart';
import 'package:flip/application/business_logic/bloc/user_profile/profile_bloc.dart';
import 'package:flip/data/firebase/auth_data_resourse/auth_services.dart';
import 'package:flip/data/firebase/comment_data_service/comment_darta.dart';
import 'package:flip/data/firebase/follow_data_resource/follow_data_resourse.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/data/firebase/save_post_data_service/save_post_service.dart';
import 'package:flip/data/firebase/user_data_resourse/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flip/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/utils/themes/dark_theme.dart';
import 'package:flip/application/business_logic/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:flip/application/presentation/screens/get_started_screen/get_started.dart';
import 'package:flip/application/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/utils/themes/light_theme.dart';

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
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(AuthServices())),
        BlocProvider<PostBloc>(
            create: (context) => PostBloc(PostServices(), UserService())),
        BlocProvider<FetchBloc>(create: (context) => FetchBloc(PostServices())),
        BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
                PostServices(), UserService(), SavePostDataService())),
        BlocProvider<BottomNavBarBloc>(create: (context) => BottomNavBarBloc()),
        BlocProvider<CommentsBloc>(
            create: (context) => CommentsBloc(CommentServises())),
        BlocProvider<FollowBloc>(
            create: (context) => FollowBloc(FollowDataSources())),
        BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(PostServices(),UserService())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flip',
          theme: lightTheme,
          darkTheme: DarkThemeClass().darkTheme,
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
            nextScreen: snapshot.hasData
                ? const RootScreen()
                : const GetStartedScreen(),
          );
        });
  }
}
