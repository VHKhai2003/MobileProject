import 'package:code/core/constants/KBApiConstants.dart';
import 'package:code/data/apis/KBApiService.dart';
import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class KnowledgeProvider with ChangeNotifier {

  final KBApiService _kbApiService = KBApiService();

  List<Knowledge> knowledges = [];
  bool hasNext = false;
  int offset = 0;
  bool isLoading = true;

  KnowledgeProvider();

  void setLoading(bool value) {
    isLoading = value;
  }
  void clearListKnowledge() {
    offset = 0;
    knowledges.clear();
    notifyListeners();
  }

  Future<void> loadKnowledge(String keyword) async {
    try {
      final response = await _kbApiService.dio.get(
          KBApiConstants.crudKnowledge,
          queryParameters: {
            "order": "DESC",
            "order_field": "updatedAt",
            "offset": offset,
            "limit": 20,
            "q": keyword
          },
          options: Options(
            extra: {
              "requireToken": true,
            }
          )
      );
      if(response.statusCode == 200) {
        knowledges.addAll(
            List<Knowledge>.from(
                response.data["data"].map((item) => Knowledge.fromMap(item))
            )
        );
        offset = knowledges.length;
        hasNext = response.data["meta"]["hasNext"];
        notifyListeners();
      }
    }
    catch(e) {
      print("Error when load knowledge");
    }
  }

  Future<bool> createKnowledge(String name, String description) async {
    try {
      final response = await _kbApiService.dio.post(
          KBApiConstants.crudKnowledge,
          data: {
            "knowledgeName": name,
            "description": description
          },
          options: Options(
              extra: {
                "requireToken": true,
              }
          )
      );
      if(response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    }
    catch(e) {
      print("Catch error when create knowledge");
    }
    return false;
  }

  Future<bool> deleteKnowledge(String id) async {
    try {
      final response = await _kbApiService.dio.delete(
          '${KBApiConstants.crudKnowledge}/$id',
          options: Options(
              extra: {
                "requireToken": true,
              }
          )
      );
      if(response.statusCode == 200) {
        return true;
      }
    }
    catch(e) {
      print("Catch error when delete knowledge");
    }
    return false;
  }

}
