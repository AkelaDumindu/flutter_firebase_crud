import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String name;
  DateTime createTime;
  DateTime updateTime;
  bool isUpdated;

  TaskModel({
    required this.id,
    required this.name,
    required this.createTime,
    required this.updateTime,
    required this.isUpdated,
  });

  // method to Convert the firebase object in to dart object
  factory TaskModel.fromJson(Map<String, dynamic> doc, String id) {
    return TaskModel(
      id: id,
      name: doc["name"],
      createTime: (doc["createTime"] as Timestamp).toDate(),
      updateTime: (doc["updateTime"] as Timestamp).toDate(),
      isUpdated: doc["isUpdated"],
    );
  }

  //convert task model to a firebase document
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "createTime": createTime,
      "updateTime": updateTime,
      "isUpdated": isUpdated,
    };
  }
}
