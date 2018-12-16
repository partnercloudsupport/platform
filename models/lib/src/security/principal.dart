import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'principal.g.dart';

@JsonSerializable()
class PrincipalModel extends ItemModel {
  String uid;
  String name;

  PrincipalModel(this.uid);

  factory PrincipalModel.fromJson(Map<String, dynamic> json) => _$PrincipalModelFromJson(json);

  static Map<String, dynamic> toJson(PrincipalModel model) => _$PrincipalModelToJson(model);
}
