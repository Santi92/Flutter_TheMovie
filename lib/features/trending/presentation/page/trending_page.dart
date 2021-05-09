import 'package:flutter/material.dart';

class TredingPage extends StatefulWidget {
  @override
  _TredingPageState createState() => _TredingPageState();
}

class _TredingPageState extends State<TredingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        children: [_MovieItem(), _MovieItem(), _MovieItem(), _MovieItem()],
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.green,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0)
                      .copyWith(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Example"),
                      Text("Example"),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 70,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
