import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:getx_intro/models/api_response.dart';
import 'package:getx_intro/models/coin_data.dart';
import 'package:getx_intro/models/tracked_asset.dart';
import 'package:getx_intro/services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetsController extends GetxController {
  RxList<CoinData> coinData = <CoinData>[].obs;
  RxBool loading = false.obs;
  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getAssets();
    _loadAssetsfromStorage();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HttpService httpService = Get.find();
    var responseData = await httpService.get('currencies');
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);

    coinData.value = currenciesListAPIResponse.data ?? [];
    loading.value = false;
  }

  void addTrackedAsset(String name, double amount) async {
    trackedAssets.add(TrackedAsset(name: name, amount: amount));
    List<String> data =
        trackedAssets.map((asset) => jsonEncode(asset)).toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("tracked_assets", data);
  }

  void _loadAssetsfromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? data = prefs.getStringList("tracked_assets");
    if (data != null) {
      trackedAssets.value = data
          .map((asset) => TrackedAsset.fromJson(jsonDecode(asset)))
          .toList();
    }
  }

  double getPortofolioValue() {
    if (trackedAssets.isEmpty || coinData.isEmpty) {
      return 0;
    }
    double value = 0;
    for (TrackedAsset asset in trackedAssets) {
      value += getAssetPrice(asset.name!) * asset.amount!;
    }

    return value;
  }

  double getAssetPrice(String name) {
    CoinData? data = getCoinData(name);
    return data?.values?.uSD?.price?.toDouble() ?? 0;
  }

  CoinData? getCoinData(String name) {
    return coinData.firstWhereOrNull((element) => element.name == name);
  }
}
