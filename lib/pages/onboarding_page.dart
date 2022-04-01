import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../config/route/router.gr.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding"),
      ),
      body: Center(
        child: TextButton(
          child: const Text("Next"),
          onPressed: () => {
            AutoRouter.of(context).replace(const LoginPageRoute()),
          },
        ),
      ),
    );
  }
}
