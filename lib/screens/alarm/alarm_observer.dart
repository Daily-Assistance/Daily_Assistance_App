import 'package:daily_assistance/model/alarm.dart';
import 'package:daily_assistance/provider/alarm/alarm_list_provider.dart';
import 'package:daily_assistance/provider/alarm/alarm_state.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alarm_screen.dart';

class AlarmObserver extends StatefulWidget {
  final Widget child;

  const AlarmObserver({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  State<AlarmObserver> createState() => _AlarmObserverState();
}

class _AlarmObserverState extends State<AlarmObserver> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmState>(builder: (context, state, child) {
      Widget? alarmScreen;

      if(state.isFired) {
        final callbackID = state.callbackAlarmId!;
        Alarm? alarm = context.read<AlarmListProvider>().getAlarmBy(callbackID);
        if(alarm != null) {
          alarmScreen = AlarmScreen(alarm: alarm);
        }
      }
      return IndexedStack(
        index: alarmScreen != null ? 0: 1,
        children: [
          alarmScreen ?? Container(),
          widget.child
        ],
      );
    });
  }
}
