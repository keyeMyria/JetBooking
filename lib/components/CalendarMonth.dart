import 'package:flutter/material.dart';

typedef Widget DateWidgetBuilder(BuildContext context, DateTime date);

class CalendarMonth extends StatelessWidget {
  final DateTime date;
  final DateWidgetBuilder dayBuilder;
  final List<List<DateTime>> weeksList;

  CalendarMonth({
    @required this.date,
    @required this.dayBuilder,
    Key key,
  })  : weeksList = _generateWeeks(date),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        children:
            weeksList.map((week) => _buildWeekRow(context, week)).toList(),
      ),
    );
  }

  Widget _buildWeekRow(context, List<DateTime> week) {
    return Flex(
      direction: Axis.horizontal,
      children: week.map((day) => _buildWeekDay(context, day)).toList(),
    );
  }

  Widget _buildWeekDay(context, DateTime date) {
    return Expanded(child: dayBuilder(context, date));
  }
}

List<List<DateTime>> _generateWeeks(currentDate) {
  final startDate = DateTime(currentDate.year, currentDate.month);
  final endDate = DateTime(currentDate.year, currentDate.month + 1, 0);
  final dayShift = startDate.weekday - 1;
  final weeksInMonth = ((endDate.day + (dayShift)) / 7).ceil();

  return List.generate(weeksInMonth, (weekIndex) {
    return List.generate(7, (i) {
      final weekday = i + 1;
      final day = (weekIndex * 7 + weekday) - dayShift;

      if (day < 1) return null;
      if (day > endDate.day) return null;

      return DateTime(
        currentDate.year,
        currentDate.month,
        day,
      );
    });
  });
}
