import 'package:fitness_client/common/widgets/custom_app_bar.dart';
import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/features/profile/domains/models/change_password.dart';
import 'package:fitness_client/helper/validate_check.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/images.dart';
import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_client/helper/route_helper.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String? email;
  final bool fromPasswordChange;
  const ChangePasswordScreen({super.key, required this.fromPasswordChange, this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppBar(title: widget.fromPasswordChange ? 'Đổi mật khẩu' : 'Lấy lại mật khẩu'),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Center(
              child: Container(
                height: null,
                width: context.width > 700 ? 700 : context.width,
                margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                decoration: context.width > 700
                    ? BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
                      )
                    : null,
                child: Column(
                  children: [
                    Padding(
                      padding: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      child: Column(
                        children: [
                          Image.asset(Images.logo, height: 70),
                          const SizedBox(height: Dimensions.paddingSizeLarge),

                          widget.fromPasswordChange
                              ? Column(
                                  children: [
                                    CustomTextField(
                                      titleText: 'Nhập mật khẩu'.tr,
                                      controller: _newPasswordController,
                                      focusNode: _newPasswordFocus,
                                      nextFocus: _confirmPasswordFocus,
                                      inputType: TextInputType.visiblePassword,
                                      prefixIcon: Icons.lock,
                                      isPassword: true,
                                      divider: false,
                                      labelText: 'Mật khẩu mới',
                                      validator: (value) => ValidateCheck.validateEmptyText(value: value, name: 'mật khẩu mới'),
                                    ),
                                    const SizedBox(height: Dimensions.paddingSizeLarge),

                                    CustomTextField(
                                      titleText: 'Xác nhận mật khẩu',
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmPasswordFocus,
                                      inputAction: TextInputAction.done,
                                      inputType: TextInputType.visiblePassword,
                                      prefixIcon: Icons.lock,
                                      isPassword: true,
                                      labelText: 'Xác nhận mật khẩu',
                                      validator: (value) => ValidateCheck.validateEmptyText(value: value, name: 'xác nhận mật khẩu'),
                                    ),
                                  ],
                                )
                              : CustomTextField(
                                  titleText: 'Nhập email',
                                  controller: _emailController,
                                  inputType: TextInputType.emailAddress,
                                  prefixIcon: Icons.email,
                                  isPassword: false,
                                  labelText: 'Nhập email',
                                  validator: (value) => ValidateCheck.validateEmail(value: value),
                                ),
                          const SizedBox(height: 50),

                          GetBuilder<ProfileController>(
                            builder: (profileController) {
                              return CustomButton(
                                color: AppColors.orange300,
                                radius: Dimensions.radiusDefault,
                                buttonText: widget.fromPasswordChange ? 'Đổi mật khẩu' : 'Lấy lại mật khẩu',
                                isLoading: profileController.isLoading,
                                onPressed: () => widget.fromPasswordChange ? _onPressedPasswordChange() : _forgotPassword(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedPasswordChange() {
    String password = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    if (password.isEmpty) {
      showCustomSnackBar('Vui lòng nhập mật khẩu');
    } else if (password.length < 6) {
      showCustomSnackBar('Mật khẩu phải ít nhất 6 ký từ');
    } else if (password != confirmPassword) {
      showCustomSnackBar('Mật khẩu không khớp');
    } else {
      _changeUserPassword(password);
    }
  }

  void _changeUserPassword(String password) {
    String token = Get.find<AuthController>().getUserToken();
    ChangePassword changePassword = ChangePassword(email: widget.email, token: token, newPassword: password);
    Get.find<ProfileController>().changePassword(changePassword).then((response) {
      if (response.isSuccess) {
        Get.find<AuthController>().clearSharedData();
        Get.offAllNamed(RouteHelper.signIn);
        showCustomSnackBar('Đổi mật khẩu thành công, hãy đăng nhập lại', isError: false);
      }
    });
  }

  void _forgotPassword() {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      showCustomSnackBar('Vui lòng nhập email');
    } else {
      Get.find<ProfileController>().forgotPassword(email).then((response) {
        if (response.isSuccess) {
          Get.back();
          showCustomSnackBar(response.message, isError: false);
        }
      });
    }
  }
}
