import 'package:flutter/material.dart';
import 'package:furniture_ar/controllers/auth_controller.dart';
import 'package:furniture_ar/shared/custom_safearea.dart';
import 'package:furniture_ar/views/home/bottom_bar.dart';
import 'package:furniture_ar/views/home/filter_list.dart';
import 'package:furniture_ar/views/home/furniture_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      color: Colors.white70,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          toolbarHeight: 120.0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.0, left: 8.0, right: 8.0),
              child: SizedBox(height: 50.0, child: HomeFilterList()),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black12),
                    foregroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.search),
                      SizedBox(width: 5.0),
                      Flexible(
                        child: Text(
                          "find your dream furniture!",
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async =>
                      await AuthenticationController().signOut(),
                  icon: const Icon(Icons.logout))
            ],
          ),
        ),
        body: const HomeFurnitureList(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const HomeBottomBar(),
      ),
    );
  }
}
