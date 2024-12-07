import 'package:code/core/constants/KBApiConstants.dart';
import 'package:code/data/apis/KBApiService.dart';
import 'package:code/features/knowledge/models/Unit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UnitProvider with ChangeNotifier {

  final KBApiService _kbApiService = KBApiService();

  UnitProvider();

  List<Unit> units = [];
  int offset = 0;
  bool hasNext = false;
  bool isLoading = true;

  void setLoading(bool value) {
    isLoading = value;
  }

  void clearUnits() {
    offset = 0;
    units.clear();
    notifyListeners();
  }

  Future<void> loadUnits(String knowledgeId) async {
    try {
      final response = await _kbApiService.dio.get(
          KBApiConstants.getUnits.replaceFirst("{id}", knowledgeId),
          queryParameters: {
            "order": "DESC",
            "order_field": "createdAt",
            "offset": offset,
            "limit": 20,
          },
          options: Options(
              extra: {
                "requireToken": true,
              }
          )
      );
      if(response.statusCode == 200) {
        units.addAll(
            List<Unit>.from(
                response.data["data"].map((item) => Unit.fromMap(item))
            )
        );
        offset = units.length;
        hasNext = response.data["meta"]["hasNext"];
        notifyListeners();
      }
    }
    catch(e) {
      print("Error when load knowledge");
    }
  }
}
