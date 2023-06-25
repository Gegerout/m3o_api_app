import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m30_api_app/auth/presentation/pages/signin_page.dart';
import 'package:m30_api_app/core/states/main_state.dart';
import 'package:m30_api_app/home/presentation/pages/home_page.dart';
import 'package:m30_api_app/utils/colors/colors.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        fontFamily: "Futura BT"
      ),
      home: ref.watch(mainProvider).when(
              data: (value) {
                if(value != null) {
                  return HomePage();
                }
                return SigninPage();
              },
              error: (error, stacktrace) {
                return Scaffold(
                  body: Center(
                    child: Text(error.toString()),
                  ),
                );
              },
              loading: () => const Scaffold(
                body: Center(
                      child: CircularProgressIndicator(),
                    ),
              )),
    );
  }
}
