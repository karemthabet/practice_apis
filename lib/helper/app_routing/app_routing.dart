import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_apis/busssiness_logic/cubit/user_cubit.dart';
import 'package:practice_apis/presentation/screens/home_screen.dart';
import 'package:practice_apis/presentation/utils/constants/app_constants.dart';

class AppRouting {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.homeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserCubit(),
            child:  HomeScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
