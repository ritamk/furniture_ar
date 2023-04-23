import 'package:flutter/material.dart';
import 'package:furniture_ar/shared/constants.dart';

class HomeFilterList extends StatefulWidget {
  const HomeFilterList({Key? key}) : super(key: key);

  @override
  State<HomeFilterList> createState() => _HomeFilterListState();
}

class _HomeFilterListState extends State<HomeFilterList> {
  final filtersLen = FURNITURE_TYPE_LIST.length;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                      _selectedIndex == 0 ? Colors.black : Colors.black12),
                ),
                onPressed: () {
                  setState(() => _selectedIndex = 0);
                },
                child: Text(
                  "All",
                  style: TextStyle(
                      color: _selectedIndex == 0 ? Colors.white : Colors.black,
                      fontWeight: _selectedIndex == 0
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
                      _selectedIndex == (index + 1)
                          ? Colors.black
                          : Colors.black12),
                ),
                onPressed: () {
                  setState(() => _selectedIndex = index + 1);
                },
                child: Text(
                  capitaliseText(FURNITURE_TYPE_LIST[index - 1]),
                  style: TextStyle(
                      color: _selectedIndex == (index + 1)
                          ? Colors.white
                          : Colors.black,
                      fontWeight: _selectedIndex == (index + 1)
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
            ),
    );
  }
}
