import 'package:api/models/user_model.dart';

abstract class UserState {}
class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}
class OneUserLoaded extends UserState {
  final User user;
  OneUserLoaded(this.user);
}
class UserCreated extends UserState {
  final User newUser;
  UserCreated(this.newUser);
}
class UserError extends UserState {
  final String message;
  UserError(this.message);
}
