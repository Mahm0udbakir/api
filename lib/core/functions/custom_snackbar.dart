import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

abstract interface class SnackBarState {
  String? get message;
} 

void successSnackBar(BuildContext context, SnackBarState state) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      message: state.message ?? "Operation successful",
    ),
  );
}

void errorSnackBar(BuildContext context, SnackBarState state) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      message: state.message ?? "An error occurred",
    ),
  );
}

class InfoSnackBarState implements SnackBarState {
  @override
  final String message;
  InfoSnackBarState(this.message);
}

void infoSnackBar(BuildContext context, SnackBarState state) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.info(
      backgroundColor: Colors.yellow,
      message: state.message ?? "Loading...",
    ),
  );
}
