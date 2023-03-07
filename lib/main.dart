import 'package:bloc_final_exame/routes/routes.dart';
import 'package:bloc_final_exame/weather/bloc/my_cities_cubit.dart';
import 'package:bloc_final_exame/weather/bloc/weather_cubit.dart';
import 'package:bloc_final_exame/weather/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (BuildContext context) => WeatherCubit(LocalStorage()),
        ),
        BlocProvider<MyCitiesCubit>(
          create: (BuildContext context) => MyCitiesCubit(LocalStorage()),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
