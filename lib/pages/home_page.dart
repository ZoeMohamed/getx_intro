import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/controllers/assets_controller.dart';
import 'package:getx_intro/models/tracked_asset.dart';
import 'package:getx_intro/pages/details_page.dart';
import 'package:getx_intro/widgets/add_asset_dialog.dart';
import 'package:getx_intro/widgets/utils.dart';

class HomePage extends StatelessWidget {
  AssetsController assetsController = Get.find();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(context),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Obx(() => Column(
            children: [_portfolioValue(context), _trackedAssetsList(context)],
          )),
    );
  }

  PreferredSizeWidget _appBar(BuildContext conext) {
    return AppBar(
      title: const CircleAvatar(
        backgroundImage: NetworkImage(
            'https://media.istockphoto.com/id/1651049276/id/foto/potret-wanita-senior-tersenyum.jpg?s=1024x1024&w=is&k=20&c=I3QNxKzdh4Tn5Uj5EjoQ3RYpfg1ae6gyE42ucR_SJr8='),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.dialog(AddAssetDialog());
            },
            icon: const Icon(Icons.add))
      ],
    );
  }

  Widget _portfolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.03,
      ),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            const TextSpan(
              text: "\$",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text:
                  "${assetsController.getPortofolioValue().toStringAsFixed(2)}\n",
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(
              text: "Portfolio value",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trackedAssetsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
            child: const Text(
              "Portofolio",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black38,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            width: MediaQuery.sizeOf(context).width,
            child: ListView.builder(
              itemCount: assetsController.trackedAssets.length,
              itemBuilder: (context, index) {
                TrackedAsset trackedAsset =
                    assetsController.trackedAssets[index];

                return ListTile(
                  leading: Image.network(getCryptoImageURL(trackedAsset.name!)),
                  onTap: () {
                    Get.to(() {
                      return DetailsPage(
                          coin: assetsController
                              .getCoinData(trackedAsset.name!)!);
                    });
                  },
                  title: Text(trackedAsset.name!),
                  trailing: Text(
                    trackedAsset.amount.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                      "USD : ${assetsController.getAssetPrice(trackedAsset.name!).toStringAsFixed(2)}"),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
