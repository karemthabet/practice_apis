part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final List<Usermodel> users;

  UserSuccess({required this.users});
}

final class UserError extends UserState {
  final String message;

  UserError({required this.message});
}
