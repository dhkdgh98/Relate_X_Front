import 'package:flutter/material.dart';
import '../../../core/utils/date_utils.dart';

class WeekCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const WeekCalendar({
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  List<DateTime> _getWeekDates(DateTime date) {
    final weekStart = date.subtract(Duration(days: date.weekday));
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates(selectedDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDates.map((date) {
        final isSelected = date.day == selectedDate.day &&
                           date.month == selectedDate.month &&
                           date.year == selectedDate.year;

        return GestureDetector(
          onTap: () {
            if (date.weekday == DateTime.sunday) {
              onDateSelected(date);
            } else {
              onDateSelected(date);
            }
          },
          child: Column(
            children: [
              Text(
                DateUtilsX.formatWeekday(date),
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  DateUtilsX.formatDay(date),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
