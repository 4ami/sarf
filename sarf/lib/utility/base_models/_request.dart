part of 'base_models_lib.dart';

abstract class BaseRequest {
  const BaseRequest();
  Map<String, dynamic> toJSON();
  String get encoded => jsonEncode(toJSON());
}