import 'package:employed_target/model/employee_model.dart';
import 'package:flutter/material.dart';
    
class CardView extends StatelessWidget {
final Client client;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const CardView(
      {super.key,
      required this.client,
      required this.onEdit,
      required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.cyan,
      surfaceTintColor: Colors.lightGreen,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        title: Text("name : ${client.name}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Phone: ${client.phone}"),
            Text("Details: ${client.desc}"),
            Text("Status: ${client.category}"),
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
    );
  }
}