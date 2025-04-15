part of 'base_models_lib.dart';

abstract class BaseResponse {
  const BaseResponse({
    required this.code,
    required this.message
  });
  final String message; final int code;
}
