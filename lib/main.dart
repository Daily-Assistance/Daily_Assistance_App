import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:daily_assistance/model/alarm.dart';
import 'package:daily_assistance/provider/alarm/alarm_list_provider.dart';
import 'package:daily_assistance/provider/alarm/permission_provider.dart';
import 'package:daily_assistance/screens/alarm/alarm_observer.dart';
import 'package:daily_assistance/screens/alarm/permission_request_screen.dart';
import 'package:daily_assistance/service/alarm/alarm_file_handler.dart';
import 'package:daily_assistance/service/alarm/alarm_polling_worker.dart';
import 'package:daily_assistance/provider/alarm/alarm_state.dart';
import 'package:daily_assistance/screens/alarm/alarmTestPage.dart';
import 'package:daily_assistance/screens/calender.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  final AlarmState alarmState = AlarmState();
  final List<Alarm> alarms = await AlarmFileHandler().read() ?? [];
  final SharedPreferences preference = await SharedPreferences.getInstance();

  // 앱 진입시 알림 탐색 시작
  AlarmPollingWorker().createPollingWorker(alarmState);

  initializeDateFormatting().then((value) => runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => alarmState),
      ChangeNotifierProvider(create: (context) => AlarmListProvider(alarms)),
      ChangeNotifierProvider(create: (context) => PermissionProvider(preference))
    ],
    child: const MyApp()
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "일상 보조",
      debugShowCheckedModeBanner: false,
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "일상 보조 앱",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const PermissionRequestScreen(
                          child: AlarmObserver(child: AlarmTestPage())
                      ))
                  );
                },
                child: const Text("알림 받기")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CalenderPage()));
                },
                child: const Text("달력 페이지")),
          ],
        ),
      ),
    );
  }
}
