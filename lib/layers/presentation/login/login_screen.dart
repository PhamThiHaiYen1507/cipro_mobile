import 'package:base_project/app/builder/app_loading_builder_controller.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/gen/assets.gen.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/button/button.dart';
import '../common/text_input_validator/text_input_validator.dart';
import 'login_controller.dart';

class LoginScreen extends MobxStatefulWidget<LoginController> {
  const LoginScreen({super.key});

  @override
  MobxState<MobxStatefulWidget<LoginController>, LoginController>
      createState() => _LoginScreenState();
}

class _LoginScreenState extends MobxState<LoginScreen, LoginController> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController username = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Form(
        key: formKey,
        child: Padding(
          padding: AppPadding.a16,
          child: SafeArea(
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
                    Icons.lock_outline_rounded,
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
                  hintText: 'Password',
                  obscureText: true,
                  controller: password,
                  style: AppTextStyle.f16R,
                  errorStyle: AppTextStyle.f12R.copyWith(height: 0.4),
                  validator: (value) =>
                      emptyValidator(value, 'Password is required'),
                ),
                AppSpacing.h16,
                Button(
                  width: double.maxFinite,
                  onPressed: doLogin,
                  child: const Text('Sign In'),
                ),
                AppSpacing.h16,
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => AccountRegisterScreenRoute().push(context),
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: AppTextStyle.f14R
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                ),
                AppSpacing.h24,
                Row(
                  children: [
                    const Expanded(child: Divider(height: 1)),
                    Text(
                      '  or  ',
                      style: AppTextStyle.f14R.copyWith(color: Colors.black45),
                    ),
                    const Expanded(child: Divider(height: 1)),
                  ],
                ),
                AppSpacing.h16,
                Text(
                  'Sign In with',
                  style:
                      AppTextStyle.f16M.copyWith(color: AppColors.primaryColor),
                ),
                AppSpacing.h4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox.square(
                      dimension: 36,
                      child: Button(
                        backgroundColor: const Color(0xff111927),
                        padding: AppPadding.a2,
                        onPressed: controller.doLoginWithGithub,
                        child: SvgPicture.asset(
                          Assets.icons.githubWhite,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    AppSpacing.w83,
                    SizedBox.square(
                      dimension: 36,
                      child: Button.border(
                        side: const BorderSide(color: Color(0xffFC6D25)),
                        backgroundColor: Colors.white,
                        padding: AppPadding.a2,
                        onPressed: () {},
                        child: SvgPicture.asset(
                          Assets.icons.gitlab,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.h16,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> doLogin() async {
    if (formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      LoadingOverlay.show();

      await controller.doLogin(context, username.text, password.text);

      LoadingOverlay.close();
    }
  }

  String? emptyValidator(String? value, String errorText) =>
      value?.isNotEmpty != true ? errorText : null;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}
