// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learning/cache/cache_manager.dart';
import 'package:flutter_riverpod_learning/future_provider_example/model/login_request_model.dart';
import 'package:flutter_riverpod_learning/future_provider_example/providers/service_provider.dart';
import 'package:flutter_riverpod_learning/future_provider_example/screens/success_page.dart';
import 'package:get/get.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final CacheManager manager = CacheManager();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login Page"),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            _customTextFormField("Email", _emailController),
            const SizedBox(height: 20),
            _customTextFormField("Password", _passwordController, isVisible: true),
            const SizedBox(height: 50),
            _loginButton(ref, context),
          ],
        ),
      ),
    );
  }

  Container _loginButton(WidgetRef ref, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          try {
            final loginFunction = await ref.read(
              loginProvider(
                LoginRequestModel(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              ).future,
            );

            if (loginFunction != null) {
              await manager.saveToken(loginFunction.token.toString());
            }
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (_) =>  SuccessPage(),
              ),
            );
          } catch (e) {
            Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              borderRadius: 15,
              message: "Invalid email or password",
              backgroundColor: Colors.red,
              animationDuration: const Duration(seconds: 3),
            );
          }
        },
        child: const Text("Login"),
      ),
    );
  }

  Container _customTextFormField(
      String hintText, TextEditingController controller,
      {bool isVisible = false}) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        obscureText: isVisible,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
