import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/common/widgets/permission_dialog_widget.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AddressService({required this.sharedPreferences, required this.apiClient});

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      showCustomSnackBar('Bạn phải cấp quyền');
    } else if (permission == LocationPermission.deniedForever) {
      Get.dialog(const PermissionDialogWidget());
    } else {
      // Lấy tọa độ
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      await sharedPreferences.setString(AppConstants.userLongitude, position.longitude.toString());
      await sharedPreferences.setString(AppConstants.userLatitude, position.latitude.toString());
    }
  }

  String getLongitude() {
    return sharedPreferences.getString(AppConstants.userLongitude) ?? "";
  }

  String getLatitude() {
    return sharedPreferences.getString(AppConstants.userLongitude) ?? "";
  }
}
