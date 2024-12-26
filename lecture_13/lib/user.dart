import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
    const factory UserModel({
    required String login,
    required String firstName,
    required String lastName,
    String? photo,
    @Default([]) List<UserModel> users,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}