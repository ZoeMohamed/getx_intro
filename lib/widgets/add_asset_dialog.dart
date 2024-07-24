import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:getx_intro/controllers/assets_controller.dart';
import 'package:getx_intro/models/api_response.dart';
import 'package:getx_intro/services/http_service.dart';

class AddAssetDialogController extends GetxController {
  RxBool loading = true.obs;
  RxList<String> assets = <String>[].obs;
  RxString selectedAsset = "".obs;
  RxDouble assetValue = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getAssets();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HttpService httpService = Get.find();
    var responseData = await httpService.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    currenciesListAPIResponse.data?.forEach((coin) {
      assets.add(coin.name!);
      selectedAsset.value = assets.first;
    });
    loading.value = false;
  }
}

class AddAssetDialog extends StatelessWidget {
  final controller = Get.put(AddAssetDialogController());
  AddAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
          child: Container(
            height: MediaQuery.of(context).size.width * 0.80,
            width: MediaQuery.of(context).size.height * 0.40,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
                color: Colors.white),
            child: _buildUI(context),
          ),
        ),
      ),
    );
  }

  Widget _buildUI(context) {
    if (controller.loading.isTrue) {
      return Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton(
                value: controller.selectedAsset.value,
                items: controller.assets.map((asset) {
                  return DropdownMenuItem(value: asset, child: Text(asset));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedAsset.value = value;
                  }
                }),
            TextField(
              onChanged: (value) {
                controller.assetValue.value = double.parse(value);
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            MaterialButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                AssetsController assetsController = Get.find();
                assetsController.addTrackedAsset(controller.selectedAsset.value,
                    controller.assetValue.value);
                Get.back(closeOverlays: true);
              },
              child: const Text(
                "Add Asset",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    }
  }
}
