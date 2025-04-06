import 'dart:io';
import 'package:floxi/view_model/camera_view_model.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final File image;
  static const String routeName = '/camera';

  const CameraScreen({super.key, required this.image});

  static Route route(CameraScreen cameraScreen) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CameraScreen(image: cameraScreen.image),
    );
  }

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Picture')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(40),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: isLoading?CircularProgressIndicator.adaptive():Image.file(widget.image),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  icon: Icon(Icons.cancel, size: 50),
                ),
                SizedBox(width: 30),
                IconButton(
                  onPressed: () async{
                    setState(() {
                      isLoading = true;
                    });
                    await CameraViewModel().sendImage(image:widget.image, context:context);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  color: Colors.green,

                  icon: Icon(Icons.check_circle, size: 50),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
