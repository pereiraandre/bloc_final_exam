import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../provider/data_provider.dart';

part 'my_cities_state.dart';

class MyCitiesCubit extends Cubit<MyCitiesState> {
  MyCitiesCubit() : super(MyCitiesInitial());

  final LocalStorage localStorage = LocalStorage();

  void reset() async {
    List<String> lastCity = (await localStorage.getCity('savedCity')) != null
        ? List<String>.from(await localStorage.getCity('savedCity'))
        : [];
    emit(MyCitiesLoaded(lastCity));
  }

  void loading() {
    emit(MyCitiesLoading());
  }

  void showCitiesList() async {
    try {
      List<String> savedCity = (await localStorage.getCity('savedCity')) != null
          ? List<String>.from(await localStorage.getCity('savedCity'))
          : [];
      emit(MyCitiesLoaded(savedCity));
    } catch (e) {
      emit(MyCitiesError(e.toString()));
    }
  }

  void removeCityFromList(List<String>? list, String name) {
    List<String>? newList = list;
    try {
      newList?.remove(name);
      localStorage.setCity("savedCity", newList!);
      emit(MyCitiesLoaded(newList));
    } catch (e) {
      emit(MyCitiesError(e.toString()));
    }
  }

  void addCityToList(String? name) async {
    List<String> savedCity = (await localStorage.getCity('savedCity')) != null
        ? List<String>.from(await localStorage.getCity('savedCity'))
        : [];
    try {
      if (!savedCity.contains(name)) {
        savedCity.add(name!);
        localStorage.setCity('savedCity', savedCity);
      }
    } catch (e) {
      emit(MyCitiesError(e.toString()));
    }
  }
}
