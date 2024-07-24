import 'package:get/get.dart';
import 'package:getx_intro/controllers/assets_controller.dart';
import 'package:getx_intro/services/http_service.dart';

Future<void> registerServices() async {
  Get.put(HttpService());
}

Future<void> registerControllers() async {
  Get.put(AssetsController());
}
