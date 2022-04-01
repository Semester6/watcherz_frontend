import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: "")
  final String firstName;
  @JsonKey(defaultValue: "")
  final String lastName;
  @JsonKey(defaultValue: "")
  final String email;
  @JsonKey(defaultValue: "")
  final String token;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token,
  });

  static const empty =
      User(id: 0, firstName: "", lastName: "", email: "", token: "");

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, firstName, lastName, email, token];
}
