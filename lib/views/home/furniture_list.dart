import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_ar/controllers/database.dart';
import 'package:furniture_ar/models/furniture_model.dart';
import 'package:furniture_ar/shared/snackbar.dart';

class HomeFurnitureList extends StatefulWidget {
  const HomeFurnitureList({super.key});

  @override
  State<HomeFurnitureList> createState() => HomeFurnitureStateList();
}

class HomeFurnitureStateList extends State<HomeFurnitureList> {
  bool _loadingItems = true;
  List<FurnitureModel> _furnitureModel = <FurnitureModel>[];

  @override
  void initState() {
    super.initState();
    getAllFurnitures();
  }

  void getAllFurnitures() {
    setState(() => _loadingItems = true);
    DatabaseController()
        .getFurnitures()
        .then((List<FurnitureModel> value) => setState(() {
              _furnitureModel = value;
              setState(() => _loadingItems = false);
            }))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      commonSnackbar("Couldn't load furnitures from store", context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_loadingItems
        ? CustomScrollView(
            slivers: [
              SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: _furnitureModel.length,
                        (context, index) => Center(
                              child: HomeFurnitureItem(
                                  furnitureModel: _furnitureModel[index]),
                            )),
                  )),
              const SliverPadding(padding: EdgeInsets.only(bottom: 40.0)),
            ],
          )
        : const Center(
            child: CupertinoActivityIndicator(
              color: Colors.black,
            ),
          );
  }
}

class HomeFurnitureItem extends StatefulWidget {
  const HomeFurnitureItem({
    super.key,
    required this.furnitureModel,
  });

  final FurnitureModel furnitureModel;

  @override
  State<HomeFurnitureItem> createState() => _HomeFurnitureItemState();
}

class _HomeFurnitureItemState extends State<HomeFurnitureItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      onPressed: () {},
      child: Column(
        children: [
          Image(
            image: NetworkImage(
              widget.furnitureModel.modelThumbnail ?? "",
            ),
            width: double.infinity,
            height: 250.0,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                Container(
              width: 50.0,
              height: 50.0,
              color: Colors.red,
            ),
            loadingBuilder: (context, child, loadingProgress) => const Center(
                child: CupertinoActivityIndicator(color: Colors.black)),
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.error)),
          ),
          Text(widget.furnitureModel.name ?? ""),
        ],
      ),
    );
  }
}
