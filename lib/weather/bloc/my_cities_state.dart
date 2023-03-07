part of 'my_cities_cubit.dart';

abstract class MyCitiesState {}

class MyCitiesInitial extends MyCitiesState {}

class MyCitiesLoading extends MyCitiesState {}

class MyCitiesLoaded extends MyCitiesState {
  final List<String> lastCity;

  MyCitiesLoaded(this.lastCity);
}

class MyCitiesError extends MyCitiesState {
  final String errorMessage;

  MyCitiesError(this.errorMessage);
}
