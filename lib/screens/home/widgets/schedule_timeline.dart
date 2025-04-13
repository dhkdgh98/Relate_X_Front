import 'package:flutter/material.dart';
import '../../../models/schedule_model.dart';
import '../../../core/utils/date_utils.dart';

class ScheduleTimeline extends StatelessWidget {
  final List<Schedule> schedules;
  final ScrollController scrollController;
  final DateTime currentDate;

  const ScheduleTimeline({
    super.key, 
    required this.schedules,
    required this.scrollController,
    required this.currentDate,
  });

  String _formatDate(DateTime date) {
    return '${date.month}월 ${date.day}일';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    // 모든 일정을 시간순으로 정렬
    final sortedSchedules = List<Schedule>.from(schedules)
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return ListView.builder(
      controller: scrollController,
      itemCount: sortedSchedules.length,
      itemBuilder: (_, index) {
        final schedule = sortedSchedules[index];
        final isToday = schedule.dateTime.year == currentDate.year &&
                        schedule.dateTime.month == currentDate.month &&
                        schedule.dateTime.day == currentDate.day;

        // 이전 일정과 같은 날짜인지 확인
        final isSameDateAsPrevious = index > 0 && 
            sortedSchedules[index - 1].dateTime.year == schedule.dateTime.year &&
            sortedSchedules[index - 1].dateTime.month == schedule.dateTime.month &&
            sortedSchedules[index - 1].dateTime.day == schedule.dateTime.day;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8 : 16,
            vertical: isSmallScreen ? 4 : 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 시간 표시
              Container(
                width: isSmallScreen ? 50 : 55,
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isSameDateAsPrevious) ...[
                      Text(
                        _formatDate(schedule.dateTime),
                        style: TextStyle(
                          fontSize: isSmallScreen ? 9 : 10,
                          color: isToday ? Colors.black : Colors.grey,
                        ),
                      ),
                    ],
                    Text(
                      TimeOfDay.fromDateTime(schedule.dateTime).format(context),
                      style: TextStyle(
                        fontSize: isSmallScreen ? 9 : 10,
                        fontWeight: FontWeight.bold,
                        color: isToday ? Colors.black : Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // 타임라인 라인
              Padding(
                padding: EdgeInsets.only(
                  left: isSmallScreen ? 16 : 18,  // 오른쪽으로 10픽셀 이동
                  right: isSmallScreen ? 6 : 8,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 2,
                      height: 8,
                      color: Colors.grey[300],
                    ),
                    Container(
                      width: isSmallScreen ? 10 : 12,
                      height: isSmallScreen ? 10 : 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday ? Colors.black : Colors.grey[300],
                      ),
                    ),
                    Container(
                      width: 2,
                      height: isSmallScreen ? 50 : 60,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
              // 일정 내용
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: isSmallScreen ? 10 : 15),
                  child: Container(
                    padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isToday ? Colors.black : Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 2 : 4),
                        Text(
                          schedule.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
