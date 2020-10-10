import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final bool isUserLoggedIn;
  final String uid;

  const UserModel({
    @required this.isUserLoggedIn,
    @required this.uid,
  });

  @override
  List<Object> get props => [
        isUserLoggedIn,
        uid,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
