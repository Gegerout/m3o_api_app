import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m30_api_app/auth/presentation/pages/signup_page.dart';
import 'package:m30_api_app/auth/presentation/states/signin_state.dart';
import 'package:m30_api_app/auth/presentation/widgets/text_field_widget.dart';
import 'package:m30_api_app/home/presentation/pages/home_page.dart';

import '../../../utils/colors/colors.dart';

class SigninPage extends ConsumerWidget {
  SigninPage({Key? key}) : super(key: key);

  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/signin_top.png",
          ),
          const Padding(
            padding: EdgeInsets.only(top: 115, left: 36),
            child: Text(
              "Welcome\nBack",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 46),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, top: 250),
            child: Column(
              children: [
                textFieldWidget("Your Email", (value) {
                  ref.read(signinProvider.notifier).checkEmail(value);
                },
                    ref
                        .watch(signinProvider)
                        .isEmail
                        ? null
                        : Icon(
                      Icons.close,
                      color: const Color(0xFFFF0000).withOpacity(0.52),
                    ),
                    false, emailCont),
                const SizedBox(height: 20),
                textFieldWidget("Password", (value) {
                  ref.read(signinProvider.notifier).checkPassword(value);
                },
                    ref
                        .watch(signinProvider)
                        .isPassword
                        ? null
                        : Icon(
                      Icons.close,
                      color: const Color(0xFFFF0000).withOpacity(0.52),
                    ),
                    true, passwordCont),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    children: [
                      const Text(
                        "Sign in",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 32),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: FloatingActionButton(
                          onPressed: ref
                              .watch(signinProvider)
                              .isValid
                              ? () {
                            ref.read(signinProvider.notifier).loginUser(
                                emailCont.text, passwordCont.text).then((
                                value) {
                              if (value) {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()), (
                                        route) => false);
                              }
                              else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                          "Wrong creds",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok"))
                                        ],
                                      );
                                    });
                              }
                            });
                          }
                              : () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const Text(
                                      "Wrong creds",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Ok"))
                                    ],
                                  );
                                });
                          },
                          backgroundColor: AppColors.buttonColor,
                          elevation: 0,
                          child: const Icon(
                            Icons.arrow_forward_outlined,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Container(
                              width: 78,
                              height: 9,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF0B7EE8)
                                      .withOpacity(0.52)),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 6)),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: Colors.black),
                              ))
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Container(
                              width: 159,
                              height: 9,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFF0000)
                                      .withOpacity(0.52)),
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 9)),
                              child: const Text(
                                "Forgot Passwords",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: Colors.black),
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
