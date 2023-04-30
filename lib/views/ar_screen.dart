import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_ar/models/furniture_model.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArScreen extends StatefulWidget {
  const ArScreen({super.key, required this.furnitureModel});
  final FurnitureModel furnitureModel;

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  bool _loading = false;
  ArCoreController? arCoreController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.furnitureModel.name ?? ""),
      ),
      body: Stack(
        children: [
          ArCoreView(
            type: ArCoreViewType.STANDARDVIEW,
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
            enablePlaneRenderer: true,
          ),
          if (_loading)
            Center(
              child: CupertinoAlertDialog(
                content: Column(
                  children: const [
                    CupertinoActivityIndicator(color: Colors.black),
                    SizedBox(height: 5.0),
                    Text("Loading"),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onNodeTap = (name) => onTapHandler(name);
    arCoreController?.onPlaneTap = _handleOnPlaneTap;
  }

  Future _addSphere(ArCoreHitTestResult hit) async {
    final earthShape = ArCoreReferenceNode(
      objectUrl: widget.furnitureModel.modelLink,
      position: hit.pose.translation,
      rotation: hit.pose.rotation,
      // scale: vector.Vector3.all(hit.distance * 0.01),
    );

    arCoreController?.addArCoreNodeWithAnchor(earthShape);
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    setState(() => _loading = true);
    final hit = hits.first;
    _addSphere(hit).then((value) => setState(() => _loading = false));
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
