import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';

import 'account_register_controller.dart';

class AccountRegisterScreen
    extends MobxStatefulWidget<AccountRegisterController> {
  const AccountRegisterScreen({super.key});

  @override
  MobxState<MobxStatefulWidget<AccountRegisterController>,
      AccountRegisterController> createState() => _AccountRegisterScreenState();
}

class _AccountRegisterScreenState
    extends MobxState<AccountRegisterScreen, AccountRegisterController> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController username = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: AppPadding.a16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: AppPadding.a16,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const Text(
                'Sign In',
                style: AppTextStyle.f24B,
              ),
              AppSpacing.h32,
              TextInputValidator(
                hintText: 'Username',
                controller: username,
                style: AppTextStyle.f16R,
                errorStyle: AppTextStyle.f12R.copyWith(height: 0.4),
                validator: (value) =>
                    emptyValidator(value, 'Username is required'),
              ),
              AppSpacing.h16,
              TextInputValidator(
                obscureText: true,
                hintText: 'Password',
                controller: password,
                style: AppTextStyle.f16R,
                errorStyle: AppTextStyle.f12R.copyWith(height: 0.4),
                validator: (value) =>
                    emptyValidator(value, 'Password is required'),
              ),
              AppSpacing.h16,
              TextInputValidator(
                hintText: 'Confirm password',
                obscureText: true,
                controller: confirmPassword,
                style: AppTextStyle.f16R,
                errorStyle: AppTextStyle.f12R.copyWith(height: 0.4),
                validator: (value) =>
                    emptyValidator(value, 'Confirm password is required') ??
                    comparePassword(value, 'Confirm password not match'),
              ),
              AppSpacing.h16,
              TextInputValidator(
                hintText: 'Email',
                controller: email,
                style: AppTextStyle.f16R,
                errorStyle: AppTextStyle.f12R.copyWith(height: 0.4),
                validator: (value) =>
                    emptyValidator(value, 'Email is required'),
              ),
              AppSpacing.h32,
              Button(
                width: double.maxFinite,
                onPressed: onRegisterAccount,
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onRegisterAccount() {
    if (formKey.currentState?.validate() == true) {
      controller.onRegisterAccount(
        context,
        username.text,
        password.text,
        confirmPassword.text,
        email.text,
      );
    }
  }

  String? emptyValidator(String? value, String errorText) =>
      value?.isNotEmpty != true ? errorText : null;

  String? comparePassword(String? value, String errorText) =>
      password.text != value ? errorText : null;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    email.dispose();
    super.dispose();
  }
}
