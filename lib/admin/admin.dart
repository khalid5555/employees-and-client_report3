import 'package:employed_target/controllers/employee_controller.dart';
import 'package:employed_target/shared/utils/app_colors.dart';
import 'package:employed_target/shared/widgets/app_text.dart';
import 'package:employed_target/ui/login_employe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/manager_view.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 166, 204, 171),
      appBar: AppBar(
        actions: [
          TextButton(
            child: const App_Text(data: 'exit'),
            onPressed: () {
              Get.find<EmployeeController>().box.remove('login_employee');
              Get.find<EmployeeController>().box.remove('email');
              Get.find<EmployeeController>().box.remove('Email_employee');
              Get.off(const LoginEmployee());
            },
          ),
        ],
        centerTitle: true,
        title: const Text(
          'لوحة تحكم الأدمن  ',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.home_filled),
              label: const App_Text(data: 'الصفحة الرئيسية'),
              onPressed: () {
                Get.to(() => AllClientScreenForAdmin());
              },
            ),
            // TextButton(
            //   child: const App_Text(data: 'اضافة عميل'),
            //   onPressed: () {
            //     Get.to(() => ClientScreen());
            //   },
            // ),
            OutlinedButton.icon(
              icon: const Icon(Icons.add_comment_outlined),
              label: const App_Text(data: 'اضافة موظف'),
              onPressed: () {
                Get.to(() => EmployeeScreen());
              },
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.receipt_outlined),
              label: const App_Text(data: ' تقارير  '),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: AppColors.kPr2Color,
                      title: const App_Text(data: 'تقارير العملاء والموظفين'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          App_Text(
                              data:
                                  ' عدد جميع العملاء : ${Get.find<ClientController>().clients.length}'),
                          App_Text(
                              data:
                                  ' عدد جميع الموظفين : ${Get.find<EmployeeController>().employees.length}'),
                        ],
                      ),
                      actions: <Widget>[
                        OutlinedButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
