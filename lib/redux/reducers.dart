import 'actions.dart';
import 'package:test_url_launcher/locationItem.dart';

List<TestLocation> locationReducer(
  List<TestLocation> testloc, dynamic action
){
  if(action is AddLatitudeAction){
      return addLatitude(testloc, action);
  } else if (action is AddLongitudeAction) {
    return addLongitude(testloc, action);
  }
  return testloc;
}

List<TestLocation> addLatitude(List<TestLocation> testloc, AddLatitudeAction action) {
  return new List.from(testloc)..add(action.latitude);
}

List<TestLocation> addLongitude(
    List<TestLocation> testloc, AddLongitudeAction action) {
 return new List.from(testloc)..add(action.longitude);
}