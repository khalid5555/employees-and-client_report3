// employee_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  String? id;
  final String? name;
  final String? email;
  final bool? isManager;
  final Timestamp? createdAt;
  Employee({
    this.id,
    this.name,
    this.email,
    this.isManager,
    this.createdAt,
  });
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'isManager': isManager});
    result.addAll({'createdAt': createdAt});
    return result;
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      isManager: map['isManager'] ?? false,
      createdAt: map['createdAt'] ?? '',
    );
  }
}

// client_model.dart
class Client {
  String? id;
  final String? name;
  final String? phone;
  final String? desc;
  final String? category;
  final String? employeeId;
  final Timestamp? createdAt;
  Client({
    this.id,
    this.name,
    this.phone,
    this.desc,
    this.category,
    this.employeeId,
    this.createdAt,
  });
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'desc': desc});
    result.addAll({'category': category});
    result.addAll({'employeeId': employeeId});
    result.addAll({'createdAt': createdAt});
    return result;
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      desc: map['desc'] ?? '',
      category: map['category'] ?? '',
      employeeId: map['employeeId'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }
}
