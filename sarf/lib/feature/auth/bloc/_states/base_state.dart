part of '../bloc.dart';

sealed class BaseAuthState {
  const BaseAuthState({this.event = const InitalAuthEvent()});
  final AuthEvent event;

  BaseAuthState copyWith({AuthEvent? event});
}