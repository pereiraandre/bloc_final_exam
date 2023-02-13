import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../utils/constants/constants.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: const [
          SizedBox(
            height: 200.0,
          ),
          Text('We\'re seeing if it\'s safe', style: kTextLoadingScreen),
          Text(
            ' for you, hold',
            style: kTextLoadingScreen,
          ),
          Text(
            'on',
            style: kTextLoadingScreen,
          ),
          SizedBox(
            height: 32.0,
          ),
          SpinKitRing(
            color: Colors.white,
            size: 80.0,
          ),
        ],
      ),
    );
  }
}
