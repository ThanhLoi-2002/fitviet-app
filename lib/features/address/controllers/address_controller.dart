import 'package:fitness_client/features/address/domains/services/address_service.dart';
import 'package:get/get.dart';

class AddressController extends GetxController implements GetxService {
  final AddressService addressService;
  AddressController({required this.addressService});

  Future<void> checkPermission() async {
    await addressService.checkPermission();
  }

  double getLongitude() {
    return addressService.getLongitude();
  }

  double getLatitude() {
    return addressService.getLatitude();
  }
}
