import 'package:crud/src/core/core.dart';
import 'package:crud/src/features/features.dart';
import 'package:crud/src/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<Injector>().splashViewModel;
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _viewModel.checkAccessToken(),
    );
  }

  @override
  Widget build(BuildContext context) => BlurredBackground(
        color: AppColors.primaryColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Image.asset(
              AppImages.appLogo,
              fit: BoxFit.fitHeight,
              height: Spacing.large * 4,
            ),
          ),
        ),
      );
}
