import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading_Page extends StatelessWidget {
  const Loading_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitCircle(
          duration: const Duration(seconds: 2),
          size: 140,
          itemBuilder: (context, index){
            final colors = [Colors.white , Colors.red , Colors.yellow];
            final color = colors[index % colors.length];

            return DecoratedBox(decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle
            ),);
          },
        ),
      ),
    );
  }
}
