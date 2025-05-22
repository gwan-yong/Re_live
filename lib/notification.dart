import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:re_live/screen/camera_screen.dart';
import 'package:re_live/screen/missed_event_journal.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz; // ✅ 추가

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final notifications = FlutterLocalNotificationsPlugin();

Future<void> initNotification() async {
  //Timezone 초기화
  tz.initializeTimeZones();

  // 안드로이드용 아이콘 설정
  const androidSetting = AndroidInitializationSettings('app_icon');

  // iOS 권한 요청 설정
  const iosSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  // 플랫폼별 초기화 설정 묶기
  const initializationSettings = InitializationSettings(
    android: androidSetting,
    iOS: iosSetting,
  );

  // 알림 초기화 + 클릭 시 동작 설정
  await notifications.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payload = response.payload;

      if (payload != null) {
        final uri = Uri.parse('myapp://dummy?$payload');
        final type = uri.queryParameters['type'];
        final id = int.tryParse(uri.queryParameters['id'] ?? '');

        if (type == 'scheduled') {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (_) => CameraScreen()),
          );
        } else if (type == 'missed' && id != null) {
          final title = uri.queryParameters['title'] ?? '';
          final startTime = uri.queryParameters['startTime'];
          final endUsed = uri.queryParameters['endUsed'] == 'true';
          final endTime = uri.queryParameters['endTime'] ?? '';
          final color = int.tryParse(uri.queryParameters['color'] ?? '0') ?? 0;

          if (startTime != null) {
            navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder:
                    (_) => MissedEventJournal(
                      scheduledId: id,
                      title: title,
                      startTime: startTime,
                      endUsed: endUsed,
                      endTime: endTime,
                      color: Color(color),
                    ),
              ),
            );
          }
        }
      }
    },
  );
}

//등록된 일정에 울리는 알림
void showScheduledNotification(
  int scheduledId,
  DateTime scheduledDateTime,
  String scheduledTitle,
) async {
  // 이미 같은 ID의 알림이 예약되어 있다면 중복 등록 방지
  final pending = await notifications.pendingNotificationRequests();
  final exists = pending.any((element) => element.id == scheduledId);
  if (exists) return; // 이미 등록된 알림이면 함수 종료

  // 알림 상세 설정
  var androidDetails = AndroidNotificationDetails(
    'schedule_channel_id',
    '예약 알림',
    importance: Importance.max,
    priority: Priority.high,
  );

  var iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  // 예약 시간 timezone 형식으로 변환
  final scheduledDate = tz.TZDateTime.from(scheduledDateTime, tz.local);

  // 알림 등록
  await notifications.zonedSchedule(
    scheduledId,
    '일정을 기록해주세요!🔥🔥',
    '진행중인 ${scheduledTitle} 일정을 기록해주세요!',
    scheduledDate,
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    payload: 'type=scheduled&id=$scheduledId',
  );
  print('${scheduledTitle}알림등록됨');
}

//놓친 일정을 알리는 알림
void showMissedScheduleNotification(
  int scheduledId,
  String scheduledTitle,
  DateTime notificationTime,
  String startTime,
  bool endUsed,
  String endTime,
  int color,
) async {
  // 이미 같은 ID의 알림이 예약되어 있다면 중복 등록 방지
  final pending = await notifications.pendingNotificationRequests();
  final exists = pending.any((element) => element.id == scheduledId);
  if (exists) return; // 이미 등록된 알림이면 함수 종료
  final missedNotificationId = 10000 + scheduledId; //일정 알림 번호와 구별을 위해 +10000

  final payload = Uri.encodeFull(
    'type=missed'
    '&id=$scheduledId'
    '&title=$scheduledTitle'
    '&startTime=$startTime'
    '&endUsed=$endUsed'
    '&endTime=$endTime'
    '&color=$color',
  );

  // 알림 상세 설정
  var androidDetails = AndroidNotificationDetails(
    'schedule_channel_id',
    '놓친 알림',
    importance: Importance.max,
    priority: Priority.high,
  );

  var iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  final scheduledDate = tz.TZDateTime.from(notificationTime, tz.local);

  // 알림 등록
  await notifications.zonedSchedule(
    missedNotificationId,
    '일정기록 하지 못 하였어요😢',
    '놓친 ${scheduledTitle} 일정에 대해서 이야기해주세요',
    scheduledDate,
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    payload: payload,
  );
  print('${scheduledTitle}놓친 알림등록됨');
  print('payload${payload}');
}
