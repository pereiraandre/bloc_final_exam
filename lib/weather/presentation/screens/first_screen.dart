import 'package:bloc_final_exame/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../bloc/weather_cubit.dart';
import '../widgets/primary_button_widget.dart';
import '../widgets/text_field_widget.dart';

class FirstScreen extends StatelessWidget {
  final TextEditingController myController;

  const FirstScreen(this.myController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(),
            child: Text(
              'Let\'s see your city first',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 27.0,
          ),
          TextFieldWidget(
            controller: myController,
            hintText: 'insert city name',
          ),
          const Spacer(),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutePaths.savedCities);
              },
              child: const Text(
                'My Cities',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 23.0,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              )),
          const SizedBox(
            height: 19,
          ),
          PrimaryButton(
              text: 'LET\'S SEE',
              onPressed: () {
                myController.text.isEmpty
                    ? Fluttertoast.showToast(
                        msg: 'You forgot to put the city name',
                        backgroundColor: Colors.blueAccent,
                        gravity: ToastGravity.CENTER)
                    : BlocProvider.of<WeatherCubit>(context)
                        .getWeather(myController.text);
                myController.clear();
              }),
          const SizedBox(
            height: 47.0,
          ),
        ],
      ),
    );
  }
}
