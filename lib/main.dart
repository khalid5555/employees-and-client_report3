import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employed_target/controllers/employed_binding.dart';
import 'package:employed_target/controllers/employee_controller.dart';
import 'package:employed_target/ui/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const MyApp());
}

/* 
class MyApp extends StatelessWidget {
  final EmployeeController employeeController = Get.put(EmployeeController());
  final ClientController clientController = Get.put(ClientController());
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('employees').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            employeeController.employees.value = snapshot.data!.docs.map((doc) {
              return Employee(
                id: doc.id,
                name: doc['name'],
                isManager: doc['isManager'],
              );
            }).toList();
            return Obx(() {
              if (employeeController.employees.isNotEmpty) {
                final isManager = employeeController.employees
                    .firstWhere((employee) => employee.id == '1')
                    .isManager;
                return isManager
                    ? const ManagerView()
                    : const EmployeeView('1');
              } else {
                return const CircularProgressIndicator();
              }
            });
          },
        ),
      ),
    );
  }
} */
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final EmployeeController employeeController = Get.put(EmployeeController());
  final ClientController clientController = Get.put(ClientController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashView(),
      defaultTransition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 500),
      initialBinding: EmployedBinding(),
    );
  }
}
