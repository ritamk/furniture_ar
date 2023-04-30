import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_ar/controllers/providers.dart';
import 'package:furniture_ar/shared/constants.dart';

class HomeFilterList extends StatefulWidget {
  const HomeFilterList({Key? key}) : super(key: key);

  @override
  State<HomeFilterList> createState() => _HomeFilterListState();
}

class _HomeFilterListState extends State<HomeFilterList> {
  final filtersLen = FURNITURE_TYPE_LIST.length;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => ListView.builder(
        clipBehavior: Clip.none,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: filtersLen + 1,
        itemBuilder: (_, index) => index == 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0)),
                    backgroundColor: MaterialStatePropertyAll(
                        ref.watch(filterIndexProvider) == 0
                            ? Colors.black
                            : Colors.black12),
                  ),
                  onPressed: () {
                    setState(
                        () => ref.read(filterIndexProvider.notifier).state = 0);
                  },
                  child: Text(
                    "All",
                    style: TextStyle(
                        color: ref.watch(filterIndexProvider) == 0
                            ? Colors.white
                            : Colors.black,
                        fontWeight: ref.watch(filterIndexProvider) == 0
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0)),
                    backgroundColor: MaterialStatePropertyAll(
                        ref.watch(filterIndexProvider) == (index + 1)
                            ? Colors.black
                            : Colors.black12),
                  ),
                  onPressed: () {
                    setState(() => ref
                        .read(filterIndexProvider.notifier)
                        .state = index + 1);
                  },
                  child: Text(
                    capitaliseText(FURNITURE_TYPE_LIST[index - 1]),
                    style: TextStyle(
                        color: ref.watch(filterIndexProvider) == (index + 1)
                            ? Colors.white
                            : Colors.black,
                        fontWeight:
                            ref.watch(filterIndexProvider) == (index + 1)
                                ? FontWeight.bold
                                : FontWeight.normal),
                  ),
                ),
              ),
      ),
    );
  }
}
