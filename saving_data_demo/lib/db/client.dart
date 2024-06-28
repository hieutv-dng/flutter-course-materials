import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable(explicitToJson: true)
class Client {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  Client({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
