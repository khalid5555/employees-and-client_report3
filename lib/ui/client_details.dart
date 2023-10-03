import 'package:employed_target/model/employee_model.dart';
import 'package:employed_target/shared/utils/constants.dart';
import 'package:employed_target/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CustomerDetailPage extends StatelessWidget {
  final Client client;
  const CustomerDetailPage({
    Key? key,
    required this.client,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: recolor(),
        title: const Text('تفاصيل العميل'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  App_Text(
                    data: 'رقم العميل: ${client.id}',
                    size: 12,
                  ),
                  App_Text(
                    data: 'الموظف المسئول عن العميل: ${client.employeeId}',
                    size: 12,
                    maxLine: 1888888888,
                  ),
                  App_Text(
                    data:
                        ' تاريخ الاضافة : ${'${client.createdAt!.toDate().day} : ${client.createdAt!.toDate().month} : ${client.createdAt!.toDate().year}'} ',
                    size: 12,
                    maxLine: 1888888888,
                  ),
                  Divider(
                    indent: 180,
                    height: 14,
                    color: recolor(),
                  ),
                  App_Text(
                    data: 'اسم العميل: ${client.name}',
                    color: Colors.redAccent,
                    maxLine: 20,
                  ),
                  const Divider(
                    indent: 150,
                    height: 12,
                  ),
                  App_Text(
                    data: 'حالة العميل: ${client.category}',
                    size: 15,
                    maxLine: 1888888888,
                  ),
                  App_Text(
                    data: 'رقم الهاتف: ${client.phone}',
                    size: 15,
                    maxLine: 1888888888,
                  ),
                  Divider(
                    indent: 80,
                    height: 12,
                    thickness: 3,
                    endIndent: 50,
                    color: recolor(),
                  ),
                  App_Text(
                    data: 'تفاصيل العميل: ${client.desc}',
                    size: 14,
                    maxLine: 1888888888,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
