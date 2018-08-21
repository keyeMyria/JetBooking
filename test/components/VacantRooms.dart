import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jetbooking/components/VacantRooms.dart';

findVacantRooms() {
  return find.descendant(
    of: find.byType(VacantRooms),
    matching: find.byType(ListTile),
  );
}

waitWhenVacantRoomsAreLoaded(tester) async {
  await (tester.widget(find.byType(FutureBuilder)) as FutureBuilder).future;
  await tester.pumpAndSettle();
}
