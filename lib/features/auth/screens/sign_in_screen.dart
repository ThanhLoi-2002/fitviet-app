import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/common/widgets/custom_text_field.dart';
import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:fitness_client/features/auth/domains/models/login_body_model.dart';
import 'package:fitness_client/features/auth/widgets/social_login_widget.dart';
import 'package:fitness_client/helper/validate_check.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/images.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_client/helper/route_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AuthController authController = Get.find<AuthController>();

    _emailOrPhoneController.text = authController.getUserEmailOrPhone();
    _passwordController.text = authController.getUserPassword();
    if (authController.getUserPassword() != "") {
      authController.toggleRememberMe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.paddingSizeLarge),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.offAllNamed(RouteHelper.initial);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.paddingSizeExtraOverLarge),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Biểu tượng thể hình
                          Stack(
                            children: [
                              Image.asset(Images.orangeCircle),
                              Positioned(top: 0, left: 0, right: 0, bottom: 0, child: Image.asset(Images.logo)),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Tiêu đề
                          Text('Welcome to ${AppConstants.appName.toUpperCase()}', style: fontBold.copyWith(fontSize: Dimensions.fontSizeOverLarge)),
                          SizedBox(height: 40),
                          // Trường nhập số điện thoại hoặc email
                          CustomTextField(
                            hintText: 'Số điện thoại hoặc Email',
                            controller: _emailOrPhoneController,
                            inputType: TextInputType.text,
                            prefixIcon: Icons.people,
                            required: true,
                            validator: (value) => ValidateCheck.validateEmptyText(value: value, name: 'số điện thoại hoặc email'),
                          ),
                          SizedBox(height: 16),
                          // Trường nhập mật khẩu
                          CustomTextField(
                            hintText: 'Mật khẩu',
                            controller: _passwordController,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            required: true,
                            isPassword: true,
                            validator: (value) => ValidateCheck.validatePassword(value: value),
                          ),
                          SizedBox(height: 8),
                          // Checkbox "Ghi nhớ mật khẩu"
                          Row(
                            children: [
                              Checkbox(value: authController.isActiveRememberMe, onChanged: (value) => authController.toggleRememberMe(), activeColor: AppColors.orange300),
                              Text('Ghi nhớ mật khẩu'),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Nút Đăng nhập
                          CustomButton(buttonText: 'Đăng nhập', color: AppColors.orange300, isLoading: authController.isLoading, onPressed: () => submitForm(authController)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Hành động quên mật khẩu
                                },
                                child: Text('Quên mật khẩu?', style: fontRegular.copyWith(color: AppColors.orange300)),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Khu vực đăng nhập bằng mạng xã hội
                          SocialLoginWidget(),
                          SizedBox(height: 20),
                          // Liên kết đăng ký
                          Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Chưa có tài khoản?'),
                              InkWell(
                                onTap: () => {Get.toNamed(RouteHelper.signUp)},
                                child: Text('Đăng kí ngay', style: fontRegular.copyWith(color: AppColors.orange300)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void submitForm(AuthController authController) async {
    if (_formKey.currentState!.validate()) {
      // Xử lý đăng ký ở đây
      String emailOrPhone = _emailOrPhoneController.text.trim();
      String password = _passwordController.text.trim();
      LoginBodyModel loginBodyModel = LoginBodyModel(emailOrPhone: emailOrPhone, password: password);
      ResponseModel response = await authController.login(loginBodyModel);
      showCustomSnackBar(response.message, isError: !response.isSuccess);
      if (response.isSuccess) {
        if (authController.isActiveRememberMe) {
          authController.saveUserAccount(emailOrPhone, password);
        } else {
          authController.clearUserAccount();
        }
        Get.offAllNamed(RouteHelper.initial);
      }
    }
  }
}
