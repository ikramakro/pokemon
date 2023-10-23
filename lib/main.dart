import 'package:assesmant_task/screen/cubit/login_cubit.dart';
import 'package:assesmant_task/screen/cubit/pokemon_cubit.dart';
import 'package:assesmant_task/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Paint.enableDithering = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(screenwidth, screenheight),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<LoginCubit>(
                create: (context) => LoginCubit(),
              ),
              BlocProvider<PokemonCubit>(
                create: (context) => PokemonCubit(),
              ),
            ],
            child: GetMaterialApp(
              theme: Theme.of(context).copyWith(
                primaryColor: Colors.red,
              ),
              home: const SplashScreen(),
            ),
          );
        });
  }
}
