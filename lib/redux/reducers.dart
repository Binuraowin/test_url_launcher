import 'actions.dart';
import 'package:test_url_launcher/locationItem.dart';

import 'actions.dart';


AppState appStateReducer(AppState state, action) {
  return AppState(
    locationList: locationReducer(state.locationList, action),
  );
}

List<TestLocation> locationReducer(List<TestLocation> state, action) {
  if (action is AddLocation) {
    return []
      ..addAll(state)
      ..add(TestLocation(action.location.lat, action.location.longi));
  }

  return state;
}