// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DistricModel {
  final String id;
  final String zip_code;
  final String name_th;
  final String name_en;
  final String amphure_id;
  DistricModel({
    required this.id,
    required this.zip_code,
    required this.name_th,
    required this.name_en,
    required this.amphure_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'zip_code': zip_code,
      'name_th': name_th,
      'name_en': name_en,
      'amphure_id': amphure_id,
    };
  }

  factory DistricModel.fromMap(Map<String, dynamic> map) {
    return DistricModel(
      id: (map['id'] ?? '') as String,
      zip_code: (map['zip_code'] ?? '') as String,
      name_th: (map['name_th'] ?? '') as String,
      name_en: (map['name_en'] ?? '') as String,
      amphure_id: (map['amphure_id'] ?? '') as String,
    );
  }

  factory DistricModel.fromJson(String source) => DistricModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
