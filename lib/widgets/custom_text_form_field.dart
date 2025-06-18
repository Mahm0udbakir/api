import 'package:api/utils/colors.dart';
import 'package:api/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PasswordCubit<S> extends Cubit<S> {
  PasswordCubit(super.initialState);
  bool get passwordVisible;
  void togglePasswordVisibility();
}

class CustomTextFormField<C extends PasswordCubit<S>, S> extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.keyboardType,
    required this.text,
    this.onFieldSubmitted,
    this.onChanged,
    this.isPassword = false,
  });
  final TextInputType? keyboardType;
  final String text;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    var myAuthCubit = BlocProvider.of<C>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        style: MyAppTextStyles.poppins300size16,
        cursorColor: MyAppColors.primaryColor,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: MyAppTextStyles.poppins500size16,
          floatingLabelStyle: MyAppTextStyles.poppins500size16,
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    myAuthCubit.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: MyAppColors.grey,
                  ),
                  onPressed: () {
                    myAuthCubit.togglePasswordVisibility();
                  },
                )
              : null,
        ),
        obscureText: isPassword && !myAuthCubit.passwordVisible,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $text';
          }
          return null;
        },
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: BorderSide(
    color: MyAppColors.grey,
  ),
);
