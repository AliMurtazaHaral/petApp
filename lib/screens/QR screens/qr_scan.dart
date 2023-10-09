import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fyp/screens/QR%20screens/qr_result.dart';

class ScanQR_Screen extends StatefulWidget {

  @override
  State<ScanQR_Screen> createState() => _ScanQR_ScreenState();
}

class _ScanQR_ScreenState extends State<ScanQR_Screen> {

  var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Text('QR Scanner'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[800]),
                onPressed: () {
                  scanQRCode();
                },
                child: Text('Scan QR'),
              ),
              SizedBox(height: 20.0,),
              Text(getResult),
            ],
          )
      ),
    );
  }

  scanQRCode() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });

      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
    if(getResult != 'Failed to scan QR Code.' && getResult != "-1"){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Result_QR(
            animal_id: getResult,
          )
        ),
      );
    }
  }

}