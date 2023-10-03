// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, annotate_overrides, library_private_types_in_public_api
import 'package:employed_target/admin/admin.dart';
import 'package:employed_target/ui/login_employe.dart';
import 'package:employed_target/ui/manager_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 600), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      // setState(() {});
      navigationToPage();
    });
  }

  void navigationToPage() async {
    final GetStorage box = GetStorage();
    // box.remove('login_employee');
    // box.remove('email');
    // box.remove('Email_employee');
    bool isLogin = box.read("login_employee") ?? false;
    String isAdmin = box.read('email') ?? '';
    if (isAdmin == 'mmmmmmmmmmm') {
      Get.off(() => const Admin());
    } else if (isLogin == true) {
      Get.off(() => ClientScreen());
    } else {
      Get.off(() => const LoginEmployee());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [
          Spacer(flex: 1),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 200,
              height: 200,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(200)),
              child: SizedBox(
                child: Image.asset(
                  "assets/img/Fb.jpg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Spacer(flex: 2)
        ],
      ),
    );
  }
}
