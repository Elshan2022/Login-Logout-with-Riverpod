// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_learning/cache/cache_manager.dart';
import 'package:flutter_riverpod_learning/future_provider_example/screens/login_page.dart';

class SuccessPage extends StatelessWidget {
  SuccessPage({super.key});
  final CacheManager manager = CacheManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _logOutButton(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Let's start"),
    );
  }

  Center _logOutButton(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () async {
            await manager.deleteToken();
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (_) => LoginPage(),
              ),
            );
          },
          child: const Text("Log out"),
        ),
      ),
    );
  }
}
