import 'package:bloc/bloc.dart';
import '../provider/data_provider.dart';

part 'my_cities_state.dart';

class MyCitiesCubit extends Cubit<MyCitiesState> {
  final CityDataProvider cityDataProvider;

  MyCitiesCubit(this.cityDataProvider) : super(MyCitiesInitial());

  void reset() async {
    List<String> lastCity =
        (await cityDataProvider.getCity('savedCity')) != null
            ? List<String>.from(await cityDataProvider.getCity('savedCity'))
            : [];
    emit(MyCitiesLoaded(lastCity));
  }

  void showCitiesList() async {
    var getCity = await cityDataProvider.getCity('savedCity');
    try {
      List<String> savedCity =
          getCity != null ? List<String>.from(getCity) : [];
      emit(MyCitiesLoaded(savedCity));
    } catch (e) {
      emit(MyCitiesError(e.toString()));
    }
  }

  void deleteCity(List<String> list, String name) {
    try {
      List<String> newList = deleteCityFromStorage(list, name);
      emit(MyCitiesLoaded(newList));
    } catch (e) {
      emit(MyCitiesError(e.toString()));
    }
  }

  void addCity(String? name) async {
    try {
      addCityToStorage(name);
    } catch (e) {
      emit(MyCitiesError(e.toString()));
    }
  }
}
