import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int? id;
  final String name;
  final String email;
  final String gender;
  final String status;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => 
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [id, name, email, gender, status];
}