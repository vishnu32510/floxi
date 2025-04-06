import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarCodeScreen extends StatefulWidget {
  static const String routeName = '/barCodeScreen';

  const BarCodeScreen({super.key});

  static Route route(BarCodeScreen barCodeScreen) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BarCodeScreen(),
    );
  }

  @override
  State<BarCodeScreen> createState() => _BarCodeScreenState();
}

class _BarCodeScreenState extends State<BarCodeScreen> {
  String barcode = "Scan a barcode";

  // Function to initiate barcode scanning
  Future<void> scanBarcode() async {
    // String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
    //   '#ff6666', // Custom color for the scan line
    //   'Cancel',   // Text for the cancel button
    //   true,       // Whether to show the flash icon (turn on/off)
    //   ScanMode.BARCODE, // Choose barcode scan mode
    // );

    // Update state with the scanned result
    setState(() {
      barcode = "Scan failed";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Barcode Scanner"), backgroundColor: Colors.blue),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Scanned Barcode:', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text(barcode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            ElevatedButton(onPressed: () async {
              String? res = await SimpleBarcodeScanner.scanBarcode(
                  context,
                  barcodeAppBar: const BarcodeAppBar(
                    appBarTitle: 'Test',
                    centerTitle: false,
                    enableBackButton: true,
                    backButtonIcon: Icon(Icons.arrow_back_ios),
                  ),
                  isShowFlashIcon: true,
                  delayMillis: 2000,
                  cameraFace: CameraFace.front,
                );
                setState(() {
                barcode = res ?? "Scan failed";
                });
            }, child: Text('Scan Barcode')),
          ],
        ),
      ),
    );
  }
}
