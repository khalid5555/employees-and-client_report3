import 'package:employed_target/controllers/employee_controller.dart';
import 'package:get/get.dart';

class EmployedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EmployeeController>(EmployeeController());
    Get.put<ClientController>(ClientController());
  }
}
