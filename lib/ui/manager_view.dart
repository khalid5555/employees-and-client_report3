// manager_view.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employed_target/admin/add_clinent.dart';
import 'package:employed_target/controllers/employee_controller.dart';
import 'package:employed_target/model/employee_model.dart';
import 'package:employed_target/shared/utils/constants.dart';
import 'package:employed_target/shared/widgets/app_text.dart';
import 'package:employed_target/shared/widgets/app_text_field.dart';
import 'package:employed_target/ui/ProductSearchDelegate%20.dart';
import 'package:employed_target/admin/add_employee.dart';
import 'package:employed_target/ui/client_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeScreen extends StatelessWidget {
  final EmployeeController employeeController = Get.find();
  EmployeeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: recolor().withOpacity(.3),
        title: const Text("بيانات الموظفين"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add Employee"),
        onPressed: () {
          // Show dialog to add an employee
          showDialog(
            context: context,
            builder: (_) => const Add_employee(),
          );
        },
      ),
      body: Container(
        color: recolor().withOpacity(.1),
        child: Column(
          children: [
            Obx(() {
              employeeController.getAllEmployees();
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: employeeController.employees.length,
                  itemBuilder: (context, index) {
                    final employee = employeeController.employees[index];
                    return ListTile(
                      title: Text(employee.name!),
                      subtitle: Text(employee.email!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Show dialog to edit an employee
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    EditEmployeeDialog(employee: employee),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Delete the employee
                              employeeController.deleteEmployee(employee.id!);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ClientScreen extends StatelessWidget {
  final ClientController clientController = Get.find();
  ClientScreen({super.key});
  @override
  Widget build(BuildContext context) {
    clientController.getClients();
    clientController.fetchCustomers();
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Show dialog to add a client
            Get.to(() => const AddClient());
          },
          label: const Text("Add Client")),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("بيانات العملاء"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: recolor(),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: ClientSearchDelegate());
                  },
                  icon: const Icon(Icons.search)),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          App_Text(
            data:
                'الخاصة بالموظف   ${clientController.box.read('Email_employee')}',
          ),
          Expanded(
            child: Obx(() {
              return clientController.filteredCustomers.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: clientController.filteredCustomers.length,
                      itemBuilder: (context, index) {
                        final client =
                            clientController.filteredCustomers[index];
                        return CustomerCard(
                          client: client,
                          onDelete: () {
                            // Delete the client
                            clientController.deleteClient(client.id!);
                          },
                          onEdit: () {
                            // Delete the client
                            showDialog(
                              context: context,
                              builder: (_) => EditClientDialog(client: client),
                            );
                          },
                        );
                      },
                    )
                  : const Align(
                      alignment: Alignment.center,
                      child: App_Text(data: 'لا يوجد لديك عملاء حتى الان'),
                    );
            }),
          ),
        ],
      ),
    );
  }
}

class AllClientScreenForAdmin extends StatelessWidget {
  final ClientController clientController = Get.find();
  AllClientScreenForAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Show dialog to add a client
            Get.to(() => const AddClient());
          },
          label: const Text("Add Client")),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(" بيانات كل العملاء"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: ClientSearchDelegate());
                },
                icon: const Icon(Icons.search)),
          )
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            return App_Text(
              data: ' عدد جميع العملاء  : ${clientController.clients.length}',
            );
          }),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: clientController.clients.length,
                itemBuilder: (context, index) {
                  final client = clientController.clients[index];
                  return CustomerCard(
                    client: client,
                    onDelete: () {
                      // Delete the client
                      clientController.deleteClient(client.id!);
                    },
                    onEdit: () {
                      // Delete the client
                      showDialog(
                        context: context,
                        builder: (_) => EditClientDialog(client: client),
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
    // } else {
    //   return Center(child: CircularProgressIndicator());
    // }
  }
}

class EditEmployeeDialog extends StatelessWidget {
  final Employee employee;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final EmployeeController employeeController = Get.find();
  EditEmployeeDialog({super.key, required this.employee}) {
    nameController.text = employee.name!;
    emailController.text = employee.email!;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Employee"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Update the employee
            employeeController.updateEmployee(employee);
            Navigator.pop(context);
          },
          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}

class EditClientDialog extends StatefulWidget {
  final Client client;
  const EditClientDialog({super.key, required this.client});
  @override
  State<EditClientDialog> createState() => _EditClientDialogState();
}

class _EditClientDialogState extends State<EditClientDialog> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final ClientController clientController = Get.find();
  String? _category;
  var selected = [
    ' حالة العميل',
    ' جاري الاتفاق ',
    ' تم التعاقد',
    ' جاري التفواض',
    ' رفض الاتفاق'
  ];
  // var selected = [' حالة العميل', ' جاري', ' تم التعاقد', ' رفض الاتفاق'];
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
                        fontSize: 20,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
          onChanged: (myValue) {
            if (myValue == ' حالة العميل') {
              setState(() {
                _category = myValue;
              });
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
  void initState() {
    _name.text = widget.client.name!;
    _phone.text = widget.client.phone!;
    _description.text = widget.client.desc!;
    _category = widget.client.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printInfo(info: widget.client.id.toString());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 176, 230, 224),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 55),
              const App_Text(data: 'التعديل علي العميل'),
              const SizedBox(height: 55),
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
              const SizedBox(height: 20),
              _selectCategory(),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    clipBehavior: Clip.hardEdge,
                    onPressed: () {
                      // Update the client
                      clientController.updateClient(Client(
                        id: widget.client.id,
                        name: _name.text,
                        phone: _phone.text,
                        desc: _description.text,
                        category: _category ?? "",
                        employeeId: widget.client.employeeId,
                        createdAt: Timestamp.now(),
                      ));
                    },
                    child: const Text("Update"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final Client client;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const CustomerCard(
      {super.key,
      required this.client,
      required this.onEdit,
      required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.cyan,
      clipBehavior: Clip.hardEdge,
      surfaceTintColor: Colors.lightGreen,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onDoubleTap: () => Get.to(() => CustomerDetailPage(
              client: client,
            )),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          title: Text("name : ${client.name}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Phone: ${client.phone}"),
              Text("Details: ${client.desc}"),
              Text("Status: ${client.category}"),
              Text("employeeId: ${client.employeeId}"),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
                color: Colors.blue,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
