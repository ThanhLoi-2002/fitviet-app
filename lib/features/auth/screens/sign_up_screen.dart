import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/common/widgets/custom_text_field.dart';
import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:fitness_client/features/auth/domains/models/signup_body.dart';
import 'package:fitness_client/helper/validate_check.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> submitForm(AuthController authController) async {
      if (_formKey.currentState!.validate()) {
        String email = _emailController.text.trim();
        String phone = _phoneController.text.trim();
        String name = _nameController.text.trim();
        String password = _passwordController.text.trim();
        String confirmPassword = _confirmPasswordController.text.trim();
        SignUpBody signUpBody = SignUpBody(email: email, name: name, password: password, phone: phone, passwordConfirm: confirmPassword);
        ResponseModel response = await authController.registration(signUpBody);
        showCustomSnackBar(response.message, isError: !response.isSuccess);
        if (response.isSuccess) {
          Get.back();
        }
      }
    }

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
                          Get.back();
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
                          // Tiêu đề
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('Register to ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                    Text(
                                      AppConstants.appName,
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.orange300),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.help, color: Colors.grey[500]),
                            ],
                          ),
                          SizedBox(height: 40),
                          // Trường nhập tên đăng nhập
                          CustomTextField(
                            hintText: 'Tên đăng nhập',
                            controller: _nameController,
                            inputType: TextInputType.text,
                            prefixIcon: Icons.people,
                            required: true,
                            validator: (value) => ValidateCheck.validateEmptyText(value: value, name: 'tên đăng nhập'),
                          ),
                          SizedBox(height: 16),
                          // Trường nhập email
                          CustomTextField(
                            hintText: 'Email',
                            controller: _emailController,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: Icons.email,
                            required: true,
                            validator: (value) => ValidateCheck.validateEmail(value: value),
                          ),
                          SizedBox(height: 16),
                          // Trường nhập số điện thoại
                          CustomTextField(
                            hintText: 'Số điện thoại',
                            controller: _phoneController,
                            inputType: TextInputType.phone,
                            prefixIcon: Icons.phone,
                            required: true,
                            validator: (value) => ValidateCheck.validatePhone(value: value),
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
                          SizedBox(height: 16),
                          // Trường nhập xác nhận mật khẩu
                          CustomTextField(
                            hintText: 'Nhập lại mật khẩu',
                            controller: _confirmPasswordController,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            required: true,
                            isPassword: true,
                            validator: (value) => ValidateCheck.validateConfirmPassword(value: value, password: _passwordController.text),
                          ),
                          SizedBox(height: 20),
                          // Nút Đăng ký
                          CustomButton(buttonText: 'Đăng kí', isLoading: authController.isLoading, color: AppColors.orange300, onPressed: () => submitForm(authController)),
                          SizedBox(height: 20),
                          // Liên kết đăng nhập
                          Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Đã có tài khoản?'),
                              InkWell(
                                onTap: () => {Get.back()},
                                child: Text('Đăng nhập ngay', style: fontRegular.copyWith(color: AppColors.orange300)),
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
}
