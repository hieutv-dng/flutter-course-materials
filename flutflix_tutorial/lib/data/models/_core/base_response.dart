import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseResponse<T> {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'results')
  final List<T> results;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  BaseResponse({
    this.page = 1,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
}
