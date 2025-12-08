import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hesabres/core/theme/theme_cubit.dart';
import 'package:hesabres/presentation/screens/auth/login_screen.dart';
import 'package:hesabres/presentation/screens/auth/otp_verification_screen.dart';
import 'package:hesabres/presentation/screens/auth/profile_setup_screen.dart';
import 'package:hesabres/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:hesabres/presentation/screens/payment_result/payment_result_screen.dart';
import 'package:hesabres/presentation/screens/plan_details/plan_details_screen.dart';
import 'package:hesabres/presentation/screens/plans/plans_screen.dart';
import 'package:hesabres/presentation/screens/products/products_screen.dart';
import 'package:hesabres/presentation/screens/splash/splash_screen.dart';
import 'package:hesabres/presentation/screens/store/store_screen.dart';
import 'package:hesabres/presentation/screens/stores/stores_screen.dart';

import 'core/theme/theme_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final themeCubit = context.read<ThemeCubit>();
          return Directionality(
            textDirection: TextDirection.rtl,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "HesabRes",
              theme: themeCubit.light,
              darkTheme: themeCubit.dark,
              themeMode: themeState.mode,
              useInheritedMediaQuery: true,
              locale: const Locale('fa', 'IR'),
              supportedLocales: const [Locale('fa', 'IR')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: ProductsScreen(),
            ),
          );
        },
      ),
    );
  }
}
