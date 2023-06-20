// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learning/authenticate/authenticate_user.dart';
import 'package:flutter_riverpod_learning/future_provider_example/screens/login_page.dart';
import 'package:flutter_riverpod_learning/future_provider_example/screens/success_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    _authenticate();
    super.initState();
  }

  _authenticate() async {
    await Future.delayed(const Duration(seconds: 4));
    final hasToken = await ref.read(authenticateUser.future);
    if (hasToken == true) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (_) =>  SuccessPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (_) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome our app"),
      ),
      body: Center(
        child: Image.asset("assets/images/hii.png"),
      ),
    );
  }
}
