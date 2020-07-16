import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kpop/bloc/angel/angel_bloc.dart';
import 'package:kpop/bloc/auth/auth_bloc.dart';
import 'package:kpop/bloc/auth/auth_event.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/screen/home_screen.dart';
import 'package:kpop/screen/sign_in_screen.dart';
import 'package:kpop/screen/splash_screen.dart';
import 'package:kpop/static/localization_delegate.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/nav_key.dart';
import 'package:kpop/stream/reward_video_stream.dart';
import 'package:kpop/widget/loading_indicator.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'bloc/auth/auth_state.dart';
import 'bloc/favorite/favorite_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runZoned(() => runApp(Kpop()), onError: (error, stackTrace) async {
    Logger().e(error.toString());
  });
}

class Kpop extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(userRepository: userRepository)..add(AuthStarted()),
          lazy: false,
        ),
        BlocProvider<AngelBloc>(
          create: (_) => AngelBloc(userRepository: userRepository),
          lazy: false,
        ),
        BlocProvider<FavoriteBloc>(
          create: (_) => FavoriteBloc(userRepository: userRepository),
          lazy: false,
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>.value(value: userRepository),
        ],
        child: MultiProvider(
          providers: [
            StreamProvider<RewardedVideoAdEvent>(
              create: (_) =>
                  RewardVideoStream(userRepository: userRepository).stream,
              lazy: false,
            ),
          ],
          child: MaterialApp(
            title: 'kpop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              dividerColor: Colors.white,
              dividerTheme: DividerThemeData(space: 0),
              appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              brightness: Brightness.dark,
              scaffoldBackgroundColor: CustomColor.base,
              primaryColor: CustomColor.base,
            ),
            builder: (context, child) => MediaQuery(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: child,
              ),
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            ),
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return HomeScreen(userInfo: state.userInfo);
                }
                if (state is AuthFailure) {
                  return SiginInScreen();
                }
                if (state is AuthInProgress) {
                  return LoadingIndicator();
                }
                return SplashScreen();
              },
            ),
            navigatorKey: NavKey.globalKey,
            localizationsDelegates: [
              LocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: new Locale("en", "US"),
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('ko', 'KR'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
