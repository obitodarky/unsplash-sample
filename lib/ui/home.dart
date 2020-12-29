import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("Discover")),
              Tab(icon: Text("Bookmarks")),
            ],
          ),
          title: Text('Unsplash demo'),
        ),
        body: TabBarView(
          children: [
            //infinite list view
            Container(color: Colors.red,),
            //bookmarks
            Container(color: Colors.purple),
          ],
        ),
      ),
    );
  }
}
