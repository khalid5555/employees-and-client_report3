// employee_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employed_target/model/employee_model.dart';
import 'package:employed_target/shared/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmployeeController extends GetxController {
  RxList<Employee> employees = <Employee>[].obs;
  RxList<Employee> employees2 = <Employee>[].obs;
  RxList<Client> clients = <Client>[].obs;
  final _firestore = FirebaseFirestore.instance;
  final GetStorage box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    getEmployees();
    // getUser();
    getAllEmployees();
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      final ref =
          await _firestore.collection('employees').add(employee.toMap());
      employee.id = ref.id;
      await ref.update(employee.toMap());
      Get.snackbar('انتبه', 'تم اضافة موظف',
          colorText: AppColors.kWhite, backgroundColor: AppColors.signUpBg);
      Get.back(closeOverlays: true);
    } catch (e) {
      print('Error adding employee: $e');
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      await _firestore
          .collection('employees')
          .doc(employee.id)
          .set(employee.toMap(), SetOptions(merge: true));
      getAllEmployees();
    } catch (e) {
      print('Error deleting employee: $e');
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      await _firestore.collection('employees').doc(id).delete();
    } catch (e) {
      print('Error deleting employee: $e');
    }
  }

// import 'package:cloud_firestore/cloud_firestore.dart';
  Future<void> getEmployees() async {
    return await _firestore.collection('employees').get().then((snapshot) {
      employees.assignAll(snapshot.docs.map((doc) {
        return Employee.fromMap(doc.data());
      }));
    });
  }

  // Get all employees
  Future<List<Employee>> getAllEmployees() async {
    final employees2 = <Employee>[];
    final employeeCollection = _firestore.collection('employees');
    final employeeQuerySnapshot = await employeeCollection.get();
    for (final employeeDocument in employeeQuerySnapshot.docs) {
      final employee = Employee.fromMap(employeeDocument.data());
      employees2.add(employee);
    }
    return employees2;
  }
}

// client_controller.dart
class ClientController extends GetxController {
  RxList<Client> clients = <Client>[].obs;
  final _firestore = FirebaseFirestore.instance;
  final GetStorage box = GetStorage();
  RxList<Client> customers = <Client>[].obs;
  RxList<Client> filteredCustomers = <Client>[].obs;
  @override
  void onInit() {
    getClients();
    fetchCustomers();
    super.onInit();
  }

  Future<void> getClients() async {
    return await _firestore
        .collection('clients')
        .orderBy('createdAt', descending: true)
        .get()
        .then((snapshot) {
      clients.assignAll(snapshot.docs.map((doc) {
        return Client.fromMap(doc.data());
      }));
    });
  }

  Future<void> addClient(Client client) async {
    try {
      final ref = await _firestore.collection('clients').add(client.toMap());
      client.id = ref.id;
      await ref.update(client.toMap());
      getClients();
      fetchCustomers();
    } catch (e) {
      print('Error adding client: $e');
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      await _firestore
          .collection('clients')
          .doc(client.id)
          .set(client.toMap(), SetOptions(merge: true));
      await getClients();
      fetchCustomers();
      Get.snackbar('انتبه', '',
          colorText: AppColors.kWhite, backgroundColor: AppColors.signUpBg);
      Get.back(closeOverlays: true);
    } catch (e) {
      printInfo(info: 'Error updating client: $e');
    }
  }

  Future<void> deleteClient(String id) async {
    try {
      await _firestore.collection('clients').doc(id).delete();
      await getClients();
      fetchCustomers();
      // Get.back(closeOverlays: true);
    } catch (e) {
      print('Error deleting client: $e');
    }
  }

  Future<void> fetchCustomers() async {
    final customersSnapshot = await _firestore
        .collection('clients')
        .orderBy('createdAt', descending: true)
        .get();
    customers.value = customersSnapshot.docs.map((doc) {
      return Client.fromMap(doc.data());
    }).toList();
    // Filter customers based on the email field
    filterCustomers();
  }

  void filterCustomers() async {
    var emailEmployee = box.read('Email_employee');
    filteredCustomers.value = customers.where((client) {
      return client.employeeId == emailEmployee;
    }).toList();
    printInfo(info: box.read('Email_employee'));
    printInfo(info: 'ccccccccccccc ${customers.length}');
  }
}
