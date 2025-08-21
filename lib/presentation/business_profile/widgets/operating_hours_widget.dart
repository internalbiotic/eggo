import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OperatingHoursWidget extends StatelessWidget {
  final Map<String, dynamic> businessData;

  const OperatingHoursWidget({
    Key? key,
    required this.businessData,
  }) : super(key: key);

  String _getCurrentStatus() {
    final now = DateTime.now();
    final currentDay = _getDayName(now.weekday);
    final currentTime = TimeOfDay.now();

    final hours = businessData['operatingHours'] as Map<String, dynamic>?;
    if (hours == null) return 'Hours not available';

    final todayHours = hours[currentDay] as Map<String, dynamic>?;
    if (todayHours == null) return 'Closed today';

    final openTime = _parseTime(todayHours['open'] as String);
    final closeTime = _parseTime(todayHours['close'] as String);

    if (_isTimeInRange(currentTime, openTime, closeTime)) {
      return 'Open now • Closes at ${todayHours['close']}';
    } else {
      return 'Closed • Opens at ${todayHours['open']}';
    }
  }

  String _getDayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[weekday - 1];
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]);
    final isPM = timeString.toLowerCase().contains('pm');

    return TimeOfDay(
      hour: isPM && hour != 12 ? hour + 12 : (hour == 12 && !isPM ? 0 : hour),
      minute: minute,
    );
  }

  bool _isTimeInRange(TimeOfDay current, TimeOfDay open, TimeOfDay close) {
    final currentMinutes = current.hour * 60 + current.minute;
    final openMinutes = open.hour * 60 + open.minute;
    final closeMinutes = close.hour * 60 + close.minute;

    if (closeMinutes < openMinutes) {
      // Crosses midnight
      return currentMinutes >= openMinutes || currentMinutes <= closeMinutes;
    } else {
      return currentMinutes >= openMinutes && currentMinutes <= closeMinutes;
    }
  }

  bool _isCurrentDay(String day) {
    final now = DateTime.now();
    final currentDay = _getDayName(now.weekday);
    return day == currentDay;
  }

  @override
  Widget build(BuildContext context) {
    final hours = businessData['operatingHours'] as Map<String, dynamic>?;

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'access_time',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Operating Hours',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: _getCurrentStatus().startsWith('Open')
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getCurrentStatus(),
                        style:
                            AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                          color: _getCurrentStatus().startsWith('Open')
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (hours != null) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: hours.entries.map((entry) {
                  final day = entry.key;
                  final dayHours = entry.value as Map<String, dynamic>;
                  final isToday = _isCurrentDay(day);

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          day,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight:
                                isToday ? FontWeight.w600 : FontWeight.w400,
                            color: isToday
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme.lightTheme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          dayHours['open'] != null && dayHours['close'] != null
                              ? '${dayHours['open']} - ${dayHours['close']}'
                              : 'Closed',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight:
                                isToday ? FontWeight.w600 : FontWeight.w400,
                            color: isToday
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme.lightTheme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
