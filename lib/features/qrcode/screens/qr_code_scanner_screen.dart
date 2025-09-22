import 'dart:typed_data';

import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/features/package/controllers/package_controller.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/features/profile/domains/models/client.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerScreen extends StatefulWidget {
  const QrCodeScannerScreen({super.key});

  @override
  State<QrCodeScannerScreen> createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        Client? client = profileController.client;
        return GetBuilder<PackageController>(
          builder: (packageController) {
            return Scaffold(
              appBar: AppBar(title: Text('Quét mã QR', style: fontMedium.copyWith(fontSize: 20)), centerTitle: true),
              body: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Vui lòng quét QR code để checkin'),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: MobileScanner(
                        controller: MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates, returnImage: true),
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          final Uint8List? image = capture.image;
                          if (barcodes.isNotEmpty) {
                            // Xử lý mã vạch đầu tiên
                            final barcode = barcodes.first;

                            if (image != null) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0), // Adjust the radius here
                                    ),
                                    title: Text(barcode.rawValue ?? "Không xác định"),
                                    content: Image(image: MemoryImage(image)),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomButton(
                                            buttonText: 'Đóng',
                                            color: Colors.red,
                                            isBold: false,
                                            width: context.width * 0.3,
                                            radius: 8,
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),

                                          CustomButton(
                                            buttonText: 'Ckeck in',
                                            isLoading: packageController.isLoading,
                                            color: AppColors.orange300,
                                            width: context.width * 0.3,
                                            isBold: false,
                                            radius: 8,
                                            onPressed: () async {
                                              ResponseModel? response = await packageController.checkIn(client!.userCode!);
                                              if (response.isSuccess) {
                                                showCustomSnackBar(response.message, isError: false);
                                                Get.back();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
