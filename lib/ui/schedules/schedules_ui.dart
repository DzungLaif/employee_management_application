import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//placeholder for schedules screen
class SchedulesUI extends StatelessWidget {
  const SchedulesUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedules'),
      ),
      body: SfCalendar(
        view: CalendarView.week,
      ),
    );
  }
}
