import 'package:json_annotation/json_annotation.dart';

part 'scanner_info_model.g.dart';

@JsonSerializable()
class ScannerInfoModel {
  ScannerInfoModel();

  factory ScannerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ScannerInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScannerInfoModelToJson(this);
}
