import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_text_field.dart';
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
  final TextEditingController _phoneOrEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRememberMe = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      if (_formKey.currentState!.validate()) {
        // Xử lý đăng ký ở đây
        debugPrint("Tên: ${_phoneOrEmailController.text}");
        debugPrint("Mật khẩu: ${_passwordController.text}");
      }
    }

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
                        controller: _phoneOrEmailController,
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
                          Checkbox(
                            value: isRememberMe,
                            onChanged: (value) {
                              setState(() => isRememberMe = !isRememberMe);
                            },
                            activeColor: AppColors.orange300,
                          ),
                          Text('Ghi nhớ mật khẩu'),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Nút Đăng nhập
                      CustomButton(buttonText: 'Đăng nhập', color: AppColors.orange300, onPressed: submitForm),

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
  }
}
