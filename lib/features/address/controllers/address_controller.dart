import 'package:fitness_client/features/address/domains/services/address_service.dart';
import 'package:get/get.dart';

class AddressController extends GetxController implements GetxService {
  final AddressService addressService;
  AddressController({required this.addressService});

  Future<void> checkPermission() async {
    await addressService.checkPermission();
  }

  String getLongitude() {
    return addressService.getLongitude();
  }

  String getLatitude() {
    return addressService.getLatitude();
  }
}
