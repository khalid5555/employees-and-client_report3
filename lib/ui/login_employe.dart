import 'package:employed_target/admin/admin.dart';
import 'package:employed_target/controllers/employee_controller.dart';
import 'package:employed_target/shared/utils/app_colors.dart';
import 'package:employed_target/shared/utils/show_loding.dart';
import 'package:employed_target/shared/widgets/app_text.dart';
import 'package:employed_target/shared/widgets/app_text_field.dart';
import 'package:employed_target/ui/manager_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginEmployee extends StatefulWidget {
  const LoginEmployee({Key? key}) : super(key: key);
  @override
  State<LoginEmployee> createState() => _LoginFormState();
}

@override
class _LoginFormState extends State<LoginEmployee> {
  final GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    late TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    EmployeeController employeeController = Get.find<EmployeeController>();
    final employee = employeeController.employees;
    bool isLoading = false;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 102, 52, 218),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              const App_Text(
                data: "تسجيل الموظف ",
                size: 20,
                color: AppColors.kPr2Color,
              ),
              const Spacer(flex: 1),
              AppTextField(
                myController: name,
                hint: 'ادخل الاسم',
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              AppTextField(
                  myController: email,
                  hint: 'ادخل الايميل',
                  icon: Icons.email,
                  keytyp: TextInputType.emailAddress),
              const SizedBox(height: 15),
              AppTextField(
                myController: password,
                obscureText: true,
                hint: 'أدخل الرقم السري',
                icon: Icons.admin_panel_settings,
                keytyp: TextInputType.number,
              ),
              const Spacer(flex: 1),
              isLoading == true
                  ? const ShowLoading()
                  : Container(
                      decoration: const BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              for (var i = 0; i < employee.length; i++) {
                                if (email.text.trim() == employee[i].email &&
                                    email.text.trim() !=
                                        'admin_employee@gmail.com') {
                                  box.write("login_employee", true);
                                  box.write(
                                      "Email_employee", email.text.trim());
                                  Get.off(() => ClientScreen());
                                } else if (email.text.trim() ==
                                    'admin_employee@gmail.com') {
                                  box.write("email", email.text);
                                  Get.off(() => const Admin());
                                  box.write("Email_employee", email.text);
                                  printInfo(
                                      info:
                                          "my email  ${employeeController.box.read('email')}");
                                } else {
                                  Get.snackbar('no found', "no found");
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              Get.snackbar('error', e.toString());
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            Get.snackbar('انتبه', ' الرجاء ملئ الحقول',
                                colorText: AppColors.kWhite,
                                backgroundColor: AppColors.kbiColor);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: const App_Text(
                          data: "تسجيل الدخول",
                          size: 14,
                        ),
                      )),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
