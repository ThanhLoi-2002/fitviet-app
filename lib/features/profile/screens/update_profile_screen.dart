import 'dart:io';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/common/widgets/custom_radio_widget.dart';
import 'package:fitness_client/features/profile/domains/models/client.dart';
import 'package:fitness_client/features/profile/domains/models/update_profile.dart';
import 'package:fitness_client/helper/date_converter.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:fitness_client/common/widgets/custom_text_field.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/features/profile/widgets/profile_bg_widget.dart';
import 'package:fitness_client/helper/validate_check.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/images.dart';
import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _dateOfBirthFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();
  final FocusNode _heightFocus = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  DateTime? _selectedDate;

  String selectedGender = 'male';

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void initData() {
    Client client = Get.find<ProfileController>().client!;
    _phoneController.text = client.phone!;
    _nameController.text = client.name!;
    _emailController.text = client.email!;
    _dateOfBirthController.text = DateConverter.formatOnlyDate(client.dateOfBirth!);
    _weightController.text = client.weight!.toString();
    _heightController.text = client.height!.toString();
    selectedGender = client.gender?.value ?? "male";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GetBuilder<ProfileController>(
        builder: (profileController) {
          return ProfileBgWidget(
            backButton: true,
            circularImage: Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: profileController.pickedFile != null
                        ? Image.file(File(profileController.pickedFile!.path), width: 100, height: 100, fit: BoxFit.cover)
                        : FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            image: profileController.client!.avatar!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 100, width: 100, fit: BoxFit.cover),
                          ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    top: 0,
                    left: 0,
                    child: InkWell(
                      onTap: () => profileController.pickImage(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            mainWidget: Column(
              children: [
                // Bọc toàn bộ nội dung form trong Expanded + ScrollView
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: SizedBox(
                              width: 1170,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  spacing: Dimensions.paddingSizeLarge,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20, width: context.width),

                                    CustomTextField(
                                      titleText: 'Nhập tên',
                                      controller: _nameController,
                                      capitalization: TextCapitalization.words,
                                      inputType: TextInputType.name,
                                      focusNode: _nameFocus,
                                      nextFocus: _emailFocus,
                                      prefixIcon: CupertinoIcons.person_alt_circle_fill,
                                      labelText: 'Tên',
                                      required: true,
                                      validator: (value) => ValidateCheck.validateEmptyText(value: value, name: 'tên'),
                                    ),

                                    CustomTextField(
                                      titleText: 'Nhập email',
                                      controller: _emailController,
                                      focusNode: _emailFocus,
                                      inputType: TextInputType.emailAddress,
                                      prefixIcon: CupertinoIcons.mail_solid,
                                      labelText: 'Email',
                                      required: true,
                                      validator: (value) => ValidateCheck.validateEmail(value: value),
                                    ),

                                    CustomTextField(
                                      titleText: 'Nhập số điện thoại',
                                      controller: _phoneController,
                                      focusNode: _phoneFocus,
                                      inputType: TextInputType.phone,
                                      prefixIcon: CupertinoIcons.phone,
                                      fromUpdateProfile: true,
                                      labelText: 'Số điện thoại',
                                      required: true,
                                      isPhone: true,
                                      validator: (value) => ValidateCheck.validatePhone(value: value),
                                    ),

                                    CustomTextField(
                                      titleText: 'Ngày sinh',
                                      controller: _dateOfBirthController,
                                      focusNode: _dateOfBirthFocus,
                                      inputType: TextInputType.text,
                                      prefixIcon: CupertinoIcons.calendar,
                                      // suffixChild: InkWell(
                                      //   onTap: () {
                                      //     pickDate(context);
                                      //   },
                                      //   child: Icon(CupertinoIcons.calendar),
                                      // ),
                                      fromUpdateProfile: true,
                                      labelText: 'Nhập ngày sinh dạng dd-mm-yyyy',
                                      required: true,
                                      validator: (value) => ValidateCheck.validateEmptyText(value: value, name: 'ngày sinh'),
                                    ),

                                    CustomTextField(
                                      titleText: 'Chiều cao',
                                      controller: _heightController,
                                      focusNode: _heightFocus,
                                      inputType: TextInputType.number,
                                      prefixIcon: Icons.height,
                                      fromUpdateProfile: true,
                                      labelText: 'Nhập chiều cao',
                                      required: true,
                                      validator: (value) => ValidateCheck.validateEmptyText(value: value, name: 'chiều cao'),
                                    ),

                                    CustomTextField(
                                      titleText: 'Cân nặng',
                                      controller: _weightController,
                                      focusNode: _weightFocus,
                                      inputType: TextInputType.number,
                                      prefixIcon: Icons.line_weight,
                                      fromUpdateProfile: true,
                                      labelText: 'Nhập cân nặng',
                                      required: true,
                                      validator: (value) => ValidateCheck.validateEmptyText(value: value, name: 'cân nặng'),
                                    ),

                                    Row(
                                      spacing: 5,
                                      children: [
                                        Text('Giới tính', style: fontRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                        CustomRadioWidget(
                                          value: 'male',
                                          selectedValue: selectedGender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedGender = value!;
                                            });
                                          },
                                        ),

                                        CustomRadioWidget(
                                          value: 'female',
                                          selectedValue: selectedGender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedGender = value!;
                                            });
                                          },
                                        ),

                                        CustomRadioWidget(
                                          value: 'other',
                                          selectedValue: selectedGender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedGender = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                    // Thêm khoảng trống để button không bị che
                                    const SizedBox(height: 100),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Button cố định ở bottom
                SafeArea(
                  child: CustomButton(
                    color: AppColors.orange300,
                    isLoading: profileController.isLoading,
                    onPressed: () => _updateProfile(profileController: profileController, fromButton: true, fromPhone: false),
                    margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    buttonText: 'Cập nhật',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('vi', 'VN'),
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;

      // Set text hiển thị cho user
      _dateOfBirthController.text = DateConverter.formatOnlyDate(picked);
    }
  }

  Future<void> _updateProfile({required ProfileController profileController, required bool fromButton, required bool fromPhone}) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String phoneNumber = _phoneController.text.trim();
      String gender = selectedGender;
      double weight = double.parse(_weightController.text.trim());
      double height = double.parse(_heightController.text.trim());
      DateTime? dateOfBirth = DateFormat("dd-MM-yyyy").parse(_dateOfBirthController.text.trim()); //_selectedDate!;

      UpdateProfile updateProfile = UpdateProfile(name: name, email: email, phone: phoneNumber, gender: gender, weight: weight, height: height, dateOfBirth: dateOfBirth);
      ResponseModel response = await profileController.updateProfile(updateProfile);
      if (response.isSuccess) {
        showCustomSnackBar(response.message, isError: false);
      }
    }
  }
}
