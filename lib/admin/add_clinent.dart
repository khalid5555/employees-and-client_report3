// ignore_for_file: library_private_types_in_public_api, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employed_target/controllers/employee_controller.dart';
import 'package:employed_target/model/employee_model.dart';
import 'package:employed_target/shared/utils/show_loding.dart';
import 'package:employed_target/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../shared/widgets/app_text_field.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});
  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final GlobalKey<FormState> _kyForm = GlobalKey<FormState>();
  bool isLoading = false;
  final GetStorage box = GetStorage();
  String? _category;
  var selected = [
    ' حالة العميل',
    ' جاري الاتفاق ',
    ' تم التعاقد',
    ' جاري التفواض',
    ' رفض الاتفاق'
  ];
  Widget _selectCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: DropdownButton(
          alignment: AlignmentDirectional.center,
          icon: const Icon(Icons.arrow_drop_down_circle_outlined),
          hint: Text(
            selected[0],
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          items: selected
              .map(
                (value) => DropdownMenuItem(
                  alignment: AlignmentDirectional.centerEnd,
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
          onChanged: (myValue) {
            // == '  ' حالة العميل''
            if (myValue == selected[0].toString()) {
              Get.snackbar('Hi', 'i am a modern snackbar');
            } else {
              setState(() {
                _category = myValue;
              });
            }
          },
          value: _category),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _phone.dispose();
    _description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 53, 160),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _kyForm,
            child: Column(
              children: [
                const SizedBox(height: 80),
                const App_Text(
                  data: 'اضافة عميل جديد',
                  color: Colors.lime,
                  size: 20,
                ),
                const SizedBox(height: 25),
                AppTextField(
                  myController: _name,
                  hint: ' اسم  العميل ',
                  icon: Icons.perm_identity,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  myController: _phone,
                  hint: "رقم الموبايل",
                  keytyp: TextInputType.number,
                  icon: Icons.phone_android,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  myController: _description,
                  hint: "معلومات عن العميل ",
                  min: 5,
                  icon: Icons.description_outlined,
                ),
                const SizedBox(height: 10),
                _selectCategory(),
                const SizedBox(height: 30),
                isLoading == true
                    ? const ShowLoading()
                    : OutlinedButton(
                        onPressed: () async {
                          bool isAdmin =
                              box.read('email') == 'admin_employee@gmail.com';
                         
                          final searchAdmin = isAdmin
                              ? Get.find<ClientController>().clients
                              : Get.find<ClientController>().filteredCustomers;
                          if (_kyForm.currentState!.validate() &&
                              !_category!.contains(' حالة العميل') &&
                              // _category != ' حالة العميل' &&
                              !searchAdmin.any((e) => e.phone == _phone.text)) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              await Get.find<ClientController>()
                                  .addClient(Client(
                                name: _name.text,
                                phone: _phone.text,
                                desc: _description.text,
                                category: _category ?? "",
                                employeeId: '${box.read('Email_employee')}',
                                createdAt: Timestamp.now(),
                              ));
                              Get.snackbar('done', 'تم الاضافة بنجاح');
                              setState(() {
                                _kyForm.currentState!.reset();
                                isLoading = false;
                                _name.clear();
                                _phone.clear();
                                _category = selected[0];
                                _description.clear();
                              });
                              Get.back(closeOverlays: true);
                            } catch (e) {
                              Get.snackbar('error', e.toString());
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            Get.snackbar('يوجد خطاء ', "",
                                colorText: Colors.white,
                                messageText: const App_Text(
                                    size: 12,
                                    maxLine: 2,
                                    data:
                                        '  قد يكون رقم الموبايل موجود من قبل او لم تكمل ملئ الحقول'),
                                backgroundColor: Colors.redAccent);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: const Text(
                          'حفظ العميل',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
