import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../provider/data_provider.dart';

part 'my_cities_state.dart';

class MyCitiesCubit extends Cubit<MyCitiesState> {
  MyCitiesCubit() : super(MyCitiesInitial());

  final LocalStorage localStorage = LocalStorage();

  void showCitiesList() async {
    List<String> savedCity = (await localStorage.getCity('savedCity')) != null
        ? List<String>.from(await localStorage.getCity('savedCity'))
        : [];
 emit(MyCitiesLoaded(savedCity));
  }

  void removeCityFromList(List<String>? list, String name) {
    List<String>? newList = list;
    newList?.remove(name);
    localStorage.setCity("savedCity", newList!);
    emit(MyCitiesLoaded(newList));
  }

void addCityToList( String? name) async {
  List<String> savedCity = (await localStorage.getCity('savedCity')) != null
      ? List<String>.from(await localStorage.getCity('savedCity'))
      : [];
  try{
    if (!savedCity.contains(name)) {
      savedCity.add(name!);
      localStorage.setCity('savedCity', savedCity);
    }
  }catch(e){
    emit(MyCitiesError(e.toString()));
  }

  }
}
