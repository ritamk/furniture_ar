import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_ar/controllers/database.dart';
import 'package:furniture_ar/controllers/providers.dart';
import 'package:furniture_ar/models/furniture_model.dart';
import 'package:furniture_ar/shared/constants.dart';
import 'package:furniture_ar/views/ar_screen.dart';

class HomeFurnitureList extends ConsumerStatefulWidget {
  const HomeFurnitureList({super.key});

  @override
  ConsumerState<HomeFurnitureList> createState() => HomeFurnitureStateList();
}

class HomeFurnitureStateList extends ConsumerState<HomeFurnitureList> {
  List<FurnitureModel> _furnitureModel = <FurnitureModel>[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.watch(filterIndexProvider) == 0
          ? DatabaseController().getFurnitures()
          : DatabaseController().getFilteredFurnitures(
              FURNITURE_TYPE_LIST[ref.watch(filterIndexProvider) - 2]),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          _furnitureModel = snapshot.data ?? [];
          if (_furnitureModel.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(Icons.info, color: Colors.black),
                Text("Could not find any furniture items in store")
              ],
            ));
          } else {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: _furnitureModel.length,
                      (context, index) => Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, left: 12.0, right: 12.0, bottom: 12.0),
                          child: HomeFurnitureItem(
                              furnitureModel: _furnitureModel[index]),
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 60.0)),
              ],
            );
          }
        } else {
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.black,
            ),
          );
        }
      },
    );
  }
}

class HomeFurnitureItem extends StatefulWidget {
  const HomeFurnitureItem({super.key, required this.furnitureModel});
  final FurnitureModel furnitureModel;

  @override
  State<HomeFurnitureItem> createState() => _HomeFurnitureItemState();
}

class _HomeFurnitureItemState extends State<HomeFurnitureItem> {
  final double _imageLen = 400.0;
  // double _discPerc = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _discPerc = ((widget.furnitureModel.mrp! - widget.furnitureModel.price!) /
  //           widget.furnitureModel.mrp!) *
  //       100;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ArScreen(furnitureModel: widget.furnitureModel),
      )),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CachedNetworkImage(
            imageUrl: widget.furnitureModel.modelThumbnail ?? "",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              width: double.infinity,
              height: _imageLen,
            ),
            progressIndicatorBuilder: (context, url, progress) =>
                const CupertinoActivityIndicator(color: Colors.black),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: _imageLen / 2.0,
            width: double.infinity,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.furnitureModel.name ?? "",
                  style: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white70,
                            fontFamily: "Montserrat"),
                        children: [
                          TextSpan(
                              text:
                                  "₹ ${widget.furnitureModel.price.toString()} "),
                          TextSpan(
                              text: widget.furnitureModel.mrp.toString(),
                              style: const TextStyle(
                                  color: Colors.white60,
                                  decoration: TextDecoration.lineThrough)),
                          // TextSpan(text: " (${_discPerc.toString()}% off)"),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green.shade600),
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
