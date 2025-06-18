
import 'package:api/functions/custom_snackbar.dart';

abstract class GlobalState {}

class GlobalLoadingState extends GlobalState {
  final String? loadingMessage;
  GlobalLoadingState({this.loadingMessage});
}

class GlobalErrorState extends GlobalState implements SnackBarState {
  final String? errorMessage;
  GlobalErrorState({this.errorMessage});
  @override
  String? get message => errorMessage;
}

class GlobalSuccessState extends GlobalState implements SnackBarState {
  final String? successMessage;
  final dynamic data;
  GlobalSuccessState({this.successMessage, this.data});
  @override
  String? get message => successMessage;
}
