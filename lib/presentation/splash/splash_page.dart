import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organeasy/presentation/home/home_page.dart';
import 'package:organeasy/presentation/splash/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLightMode = MediaQuery.of(context).platformBrightness == Brightness.light;

    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HomePage()));
          }
        },
        child: Scaffold(
          backgroundColor: isLightMode ? const Color(0xe1f5fe).withOpacity(1.0) : const Color(0x042a49).withOpacity(1.0),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
