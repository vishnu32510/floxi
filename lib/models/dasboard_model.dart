import 'package:flutter/material.dart';

class DashboardModel {
  double? totalEmissions;
  double? totalEmissionsSaved;
  int? monthlypoints;
  int? threshold;
  int? target;
  int? totalPoints;
  List<TransactionModel>? transactions;
  String? username;

  DashboardModel({
    this.totalEmissions,
    this.totalEmissionsSaved,
    this.totalPoints,
    this.transactions,
    this.username,
  });

  DashboardModel.fromJson(Map<String, dynamic> json) {
    totalEmissions = json['total_emissions'];
    totalEmissionsSaved = json['total_emissions_saved'];
    totalPoints = json['total_points'];
    threshold = json['threshold'];
    target = json['target'];
    monthlypoints = json['monthly_points'].toInt();
    if (json['transactions'] != null) {
      transactions = <TransactionModel>[];
      json['transactions'].forEach((v) {
        transactions!.add(TransactionModel.fromJson(v));
      });
    }
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_emissions'] = totalEmissions;
    data['total_emissions_saved'] = totalEmissionsSaved;
    data['total_points'] = totalPoints;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    data['username'] = username;
    return data;
  }
}

Icon getTransactionIcon(String transactionModelType) {
  switch (transactionModelType.toLowerCase()) {
    case 'grocery':
      return Icon(Icons.local_grocery_store, color: Colors.green);
    case 'travel':
      return Icon(Icons.train, color: Colors.blue);
    default:
      return Icon(Icons.help_outline, color: Colors.grey);
  }
}

class TransactionModel {
  int? id;
  List<ItemModel>? items;
  String? suggestion;
  double? emissions;
  int? points;
  DateTime? timestamp;
  String? title;
  String? type;

  TransactionModel({
    this.id,
    this.items,
    this.suggestion,
    this.timestamp,
    this.title,
    this.type,
    this.emissions,
    this.points,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['items'] != null) {
      items = <ItemModel>[];
      json['items'].forEach((v) {
        items!.add(ItemModel.fromJson(v));
      });
    }
    suggestion = json['suggestion'];
    emissions = json['emissions'].toDouble();
    points = json['points'];
    timestamp = DateTime.parse(json['timestamp']);
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['suggestion'] = suggestion;
    data['timestamp'] = timestamp;
    data['title'] = title;
    data['type'] = type;
    return data;
  }
}

class ItemModel {
  double? emissionSaved;
  double? emissions;
  String? grade;
  int? id;
  String? itemName;
  int? points;
  String? suggestedAlternative;

  ItemModel({
    this.emissionSaved,
    this.emissions,
    this.id,
    this.itemName,
    this.grade,
    this.points,
    this.suggestedAlternative,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    emissionSaved = json['emission_saved'];
    emissions = json['emissions'];
    grade = json['grade'];
    id = json['id'];
    itemName = json['item_name'];
    points = json['points'];
    suggestedAlternative = json['suggested_alternative'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emission_saved'] = emissionSaved;
    data['emissions'] = emissions;
    data['id'] = id;
    data['item_name'] = itemName;
    data['points'] = points;
    data['suggested_alternative'] = suggestedAlternative;
    return data;
  }
}

Color getGradeColor(String grade) {
  switch (grade.toUpperCase()) {
    case 'A':
      return Colors.green;
    case 'B':
    case 'C':
      return Colors.orange;
    case 'D':
      return Colors.red;
    default:
      return Colors.red; // fallback for unknown grades
  }
}
