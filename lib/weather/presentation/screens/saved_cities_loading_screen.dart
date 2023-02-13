import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SavedCitiesLoadingScreen extends StatelessWidget {
  const SavedCitiesLoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/saved_city.jpg'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text(
                'My Saved Cities',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 27.0),
              )),
          body: const Center(
            child: SpinKitRing(
              color: Colors.white,
              size: 80.0,
            ),
          ),
        ));
  }
}
