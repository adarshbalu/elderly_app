import 'package:elderly_app/models/image.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';

class DocumentDetail extends StatefulWidget {
  final ImageClass image;
  DocumentDetail(this.image);
  @override
  _DocumentDetailState createState() => _DocumentDetailState();
}

class _DocumentDetailState extends State<DocumentDetail> {
  ImageClass image = ImageClass();
  @override
  void initState() {
    image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: image.name,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Image.network(
                    image.url,
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 1.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                image.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                print('Tap');
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green,
                child: Center(
                  child: Icon(
                    Icons.file_download,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text('Download to Device'),
            SizedBox(
              height: 8,
            )
          ],
        ),
        appBar: ElderlyAppBar(),
        drawer: AppDrawer(),
      ),
    );
  }
}
