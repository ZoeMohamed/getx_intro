import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/controllers/assets_controller.dart';
import 'package:getx_intro/widgets/add_asset_dialog.dart';

class HomePage extends StatelessWidget {
  AssetsController assetsController = Get.find();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Obx(() => _portofolioValue(context)),
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

  Widget _portofolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.03),
      child: Center(
        child: Text.rich(TextSpan(children: [])),
      ),
    );
  }
}
