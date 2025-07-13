import 'package:devgram/core/constants/strings/app_strings.dart';
import 'package:devgram/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/router/app_router.dart';

class Devgram extends StatelessWidget {
  const Devgram({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => InjectionContainer.getAuthBloc(),
          child: child!,
        );
      },
    );
  }
}
