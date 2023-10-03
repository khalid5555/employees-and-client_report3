// ignore_for_file: camel_case_types
import 'package:employed_target/controllers/employee_controller.dart';
import 'package:employed_target/model/employee_model.dart';
import 'package:employed_target/shared/utils/app_colors.dart';
import 'package:employed_target/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/utils/show_loding.dart';
import '../shared/widgets/app_text_field.dart';

class Add_employee extends StatefulWidget {
  const Add_employee({Key? key}) : super(key: key);
  @override
  State<Add_employee> createState() => _Add_employeeState();
}

class _Add_employeeState extends State<Add_employee> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    EmployeeController employeeController = Get.find<EmployeeController>();
    bool isLoading = false;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 108, 110, 117),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              const App_Text(
                data: "تسجيل موظف جديد",
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
              isLoading == false
                  ? Container(
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
                              await employeeController.addEmployee(
                                Employee(
                                  name: name.text,
                                  email: email.text,
                                  isManager: false,
                                ),
                              );
                              Get.snackbar('انتبه', 'تم اضافة موظف',
                                  colorText: AppColors.kWhite,
                                  backgroundColor: AppColors.signUpBg);
                              Get.back(closeOverlays: true);
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              Get.snackbar('error', e.toString());
                              // EasyLoading.showError('  $e....');
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
                      ))
                  : const ShowLoading(),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
