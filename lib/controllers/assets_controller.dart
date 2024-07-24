import 'package:get/get.dart';
import 'package:getx_intro/models/tracked_asset.dart';
import 'package:getx_intro/services/http_service.dart';

class AssetsController extends GetxController {
  RxBool loading = false.obs;
  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(trackedAssets);
  }

  Future<void> _getAssets()async{
loading.value = true;
HttpService httpService = Get.find();
  }

  void addTrackedAsset(String name, double amount) {
    trackedAssets.add(TrackedAsset(name: name, amount: amount));
    print(trackedAssets);
  }

  double getPortofolioValue() {
    if (trackedAssets.isEmpty) {
      return 0;
    }
    double value = 0;
    for (TrackedAsset asset in trackedAssets) {
      value += 
    }
  }
}
