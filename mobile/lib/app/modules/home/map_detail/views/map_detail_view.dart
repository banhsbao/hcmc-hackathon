import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/map_detail_controller.dart';

class MapDetailView extends GetView<MapDetailController> {
  const MapDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MapDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
