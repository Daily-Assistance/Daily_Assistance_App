import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("달력"),
        centerTitle: true,
      ),
      body: Center(
          child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2023, 1, 1),
        lastDay: DateTime(2023, 12, 30),
        locale: 'ko-KR',
        daysOfWeekHeight: 30,
        headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronVisible: true,
            rightChevronVisible: true),
      )),
    );
  }
}
