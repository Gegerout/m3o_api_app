import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m30_api_app/auth/presentation/pages/signin_page.dart';
import 'package:m30_api_app/auth/presentation/states/signup_state.dart';

import '../../../utils/colors/colors.dart';
import '../widgets/text_field_widget.dart';

class SignupPage extends ConsumerWidget {
  SignupPage({Key? key}) : super(key: key);

  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();
  final TextEditingController nameCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/signup_top.png",
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset("assets/images/signup_bottom.png", scale: 4,)),
          const Padding(
            padding: EdgeInsets.only(top: 35, left: 36),
            child: Text(
              "Create\nAccount",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 46),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, top: 170),
            child: Column(
              children: [
                textFieldWidget("Username", (value) {
                  ref.read(signupProvider.notifier).checkName(value);
                },
                    ref.watch(signupProvider).isName
                        ? null
                        : Icon(
                            Icons.close,
                            color: const Color(0xFFFF0000).withOpacity(0.52),
                          ),
                    false,
                    nameCont),
                const SizedBox(height: 20),
                textFieldWidget("Your Email", (value) {
                  ref.read(signupProvider.notifier).checkEmail(value);
                },
                    ref.watch(signupProvider).isEmail
                        ? null
                        : Icon(
                            Icons.close,
                            color: const Color(0xFFFF0000).withOpacity(0.52),
                          ),
                    false,
                    emailCont),
                const SizedBox(height: 20),
                textFieldWidget("Password", (value) {
                  ref.read(signupProvider.notifier).checkPassword(value);
                },
                    ref.watch(signupProvider).isPassword
                        ? null
                        : Icon(
                            Icons.close,
                            color: const Color(0xFFFF0000).withOpacity(0.52),
                          ),
                    true,
                    passwordCont),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 32),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: FloatingActionButton(
                          onPressed: ref.watch(signupProvider).isValid
                              ? () {
                                  ref
                                      .read(signupProvider.notifier)
                                      .createUser(emailCont.text,
                                          passwordCont.text, nameCont.text)
                                      .then((value) {
                                    if (value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SigninPage()));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: const Text(
                                                "Something went wrong",
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
                      const Spacer(),
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
                                        builder: (context) => SigninPage()));
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 6)),
                              child: const Text(
                                "Sign In",
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
