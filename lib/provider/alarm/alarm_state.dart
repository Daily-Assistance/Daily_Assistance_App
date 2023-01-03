import 'package:flutter/material.dart';

class AlarmState extends ChangeNotifier {
  int? get callbackAlarmId => _callbackAlarmID;
  int? _callbackAlarmID;

  bool get isFired => _callbackAlarmID != null;

  void fire(int alarmId) {
    _callbackAlarmID = alarmId;
    notifyListeners();
    debugPrint('Alarm has fired #$alarmId');
  }

  void dismiss() {
    _callbackAlarmID = null;
    notifyListeners();
  }

}