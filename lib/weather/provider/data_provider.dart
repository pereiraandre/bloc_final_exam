import 'package:shared_preferences/shared_preferences.dart';

abstract class CityDataProvider {
  void setCity(String key, dynamic data);

  dynamic getCity(String key);
}

class LocalStorage extends CityDataProvider {
  @override
  Future<void> setCity(String key, data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, data);
  }

  @override
  Future<dynamic> getCity(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final city = prefs.get(key);
    return city;
  }
}

void addCityToStorage(String? name) async {
  var getCity = await LocalStorage().getCity('savedCity');
  List<String> savedCity = getCity != null ? List<String>.from(getCity) : [];
  try {
    if (!savedCity.contains(name)) {
      savedCity.add(name!);
      LocalStorage().setCity('savedCity', savedCity);
    }
  } catch (e) {
    rethrow;
  }
}

List<String> deleteCityFromStorage(List<String> list, String name) {
  List<String> newList = list;
  try {
    newList.remove(name);
    LocalStorage().setCity("savedCity", newList);
    return newList;
  } catch (e) {
    rethrow;
  }
}
