// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    isUserLoggedIn: json['isUserLoggedIn'] as bool,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'isUserLoggedIn': instance.isUserLoggedIn,
      'uid': instance.uid,
    };
