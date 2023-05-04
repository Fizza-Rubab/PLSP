
// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Home/Citizen.dart';
import 'package:google_maps/Lifesaver/Lifesaver.dart';
import 'package:google_maps/Lifesaver/RedirectDestination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Welcome/register.dart';
import '../constants.dart';
import 'Login.dart';
import '../shared.dart';
import '../texttheme.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

enum LocaleMenu { en, ur, ar}

TextDirection td = TextDirection.ltr;
int incident_id = -1;

class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.purple,
              ledColor: Colors.redAccent)
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }
  static Future<void> initializeRemoteNotifications({
    required bool debug
  }) async {
    await Firebase.initializeApp();
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
        onFcmTokenHandle: NotificationController.myFcmTokenHandle,
        onNativeTokenHandle: NotificationController.myNativeTokenHandle,
        // This license key is necessary only to remove the watermark for
        // push notifications in release mode. To know more about it, please
        // visit http://awesome-notifications.carda.me#prices
        debug: debug);

  }

   static Future<String> getFirebaseMessagingToken() async {
    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken = await AwesomeNotificationsFcm().requestFirebaseAppToken();
        print(firebaseAppToken);

      }
      catch (exception){
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    print(firebaseAppToken);
    return firebaseAppToken;
  }
  //  *********************************************
  ///     REMOTE NOTIFICATION EVENTS
  ///  *********************************************

  /// Use this method to execute on background when a silent data arrives
  /// (even while terminated)
  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    print('"SilentData": ${silentData.toString()}');

    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      print("bg");
    } else {
      print("FOREGROUND");
    }

    print("starting long task");
    await Future.delayed(Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");
  }

  /// Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('FCM Token:"$token"');
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');
  }
  
  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction) async {
    print("some action received");
    var payload = receivedAction.payload;
    var body = payload;
    print("payload " + body.toString());
    int incident = int.parse(body!['incident']!);
    print("incident");
    print(incident);
    int request = int.parse(body!['request_id']!);
    print("request");
    print(request);
    int no_of_patients = int.parse(body!['no_of_patients']!);
    print(no_of_patients);
    String citizen_name = body!['citizen_name']!;
    print(citizen_name);
    String citizen_contact = body!['citizen_contact']!;
    print(citizen_contact);
    String info = body!['info']!;
    print(info);
    double longitude = double.parse(body!['longitude']!);
    print(longitude);
    double latitude = double.parse(body!['latitude']!);
    print(latitude);


    var incident_obj = {
      "incident": incident,
      "request": request,
      "info": info,
      "latitude": latitude,
      "longitude": longitude,
      "no_of_patients": no_of_patients,
      "citizen_name": citizen_name,
      "citizen_contact": citizen_contact,
    };
    print("incident obj notif " + incident_obj.toString());
    if(
      receivedAction.actionType == ActionType.SilentAction ||
      receivedAction.actionType == ActionType.SilentBackgroundAction
    ){
      print("here in action1");
      print('Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      await executeLongTaskInBackground();
    }
    else {
      print("here in action2");
      if (Welcome.navigatorKey.currentState!=null){
        print(ApiConstants.baseUrl + '/incident/${request}/accept/${await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? "0")}');
        final http.Response result = await http.post(
        Uri.parse(ApiConstants.baseUrl + '/incident/${request}/accept/${await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? "0")}'));
        Map<String, dynamic> response = json.decode(result.body);
        print(response);
        if (response['status']=='accepted')
        Welcome.navigatorKey.currentState?.push(MaterialPageRoute(
                                          builder: (context) =>
                                              RedirectDestination(incident_obj:incident_obj)));
        
        // incident_id = -1;                                   
      }
                                            
    }
    
  }
    @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    print("notif created");
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
      // print("printing payload " + receivedNotification.payload.toString());
      // print("printing body " + receivedNotification.body!);
      // print("whole notification "+ receivedNotification.toString());
      // print(receivedNotification.payload!['incident']);
      // incident_id = int.parse(receivedNotification.payload!['incident']!);
      print("notif displayed");

  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
        print("notif dismissed");

  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = Welcome.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     BACKGROUND TASKS TEST
  ///  *********************************************
  static Future<void> executeLongTaskInBackground() async {
    print("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  static Future<void> createNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: 'Emergency! Urgent help is required!',
            body:
                "There is an accident in your vicinity. Accept and help!",
            bigPicture: 'https://cdn-icons-png.flaticon.com/256/9284/9284033.png',
            largeIcon: 'https://cdn-icons-png.flaticon.com/512/3393/3393714.png',
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(key: 'REDIRECT', label: 'ACCEPT'),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'DECLINE',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ]);
  }

  static Future<void> scheduleNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: "Huston! The eagle not has landed!",
            body:
                "A small step for a man, but a giant leap to Flutter's community!",
            bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {
              'notificationId': '1234567890'
            }),
        actionButtons: [
          NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ],
        schedule: NotificationCalendar.fromDate(
            date: DateTime.now().add(const Duration(seconds: 10))));
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}

class Welcome extends StatefulWidget {
  final String who;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  const Welcome ({Key? key, required this.who}) : super(key: key);

  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  Locale? _locale;
  bool is_lifesaver = false;
  void setLocale(Locale val) {
    setState(() {
      _locale = val;
    });
  }
  void updateCheck() async{
    bool x = await getBool('is_lifesaver')??false;
    setState(() {
      is_lifesaver = x;
    });
  }
  @override
  void initState() {
    print("who " + widget.who);
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
    super.initState(); 
    updateCheck();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.who);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PLSP',
        navigatorKey: Welcome.navigatorKey,
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.redAccent),
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          textTheme: customTextTheme,
          navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Colors.white,
              elevation: 0,
              height: 72,
              labelTextStyle: MaterialStateProperty.all(
                GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const StadiumBorder(),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              shape: const StadiumBorder(),
            ),
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        home: widget.who=='logged_in'? (is_lifesaver? Lifesaver(): Citizen()): WelcomeContent(setLocale: setLocale)
        // home: Scaffold()
        )
        ;
  }
}

class WelcomeContent extends StatefulWidget {
  const WelcomeContent({required this.setLocale, super.key});
  final void Function(Locale locale) setLocale;
  @override
  State<WelcomeContent> createState() => _WelcomeContentState();
}

class _WelcomeContentState extends State<WelcomeContent> {
  String selected_lang = 'English - en';

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: td,
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 5 / 8,
                  padding: const EdgeInsets.fromLTRB(14, 86, 14, 28),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/welcome-bg.png"),
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(Colors.white12, BlendMode.overlay)
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.plsp,
                          style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              color: Colors.black38),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PopupMenuButton<LocaleMenu>(
                              icon: const Icon(
                                Icons.translate_outlined,
                                size: 30,
                                color: Colors.white,
                              ), //use this icon
                              onSelected: (LocaleMenu item) {
                                setState(() {
                                  selected_lang = item.name;
                                  if (selected_lang != 'en') {
                                    td = TextDirection.rtl;
                                  } else {
                                    td = TextDirection.ltr;
                                  }
                                });
                                print(selected_lang);
                                widget.setLocale(Locale.fromSubtags(
                                    languageCode: selected_lang));
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<LocaleMenu>>[
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.en,
                                  child: Text('English - en'),
                                ),
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.ur,
                                  child: Text('Urdu - ur'),
                                ),
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.ar,
                                  child: Text('Sindhi - sd'),
                                ),
                                // const PopupMenuItem<LocaleMenu>(
                                //   value: LocaleMenu.ps,
                                //   child: Text('Pashto - ps'),
                                // ),
                                // const PopupMenuItem<LocaleMenu>(
                                //   value: LocaleMenu.pa,
                                //   child: Text('Panjabi - pa'),
                                // ),
                              ],
                            ),

                            // IconButton(
                            //   onPressed: () {},
                            //   color: Colors.white,
                            //   icon: const Icon(Icons.translate_outlined),
                            //   iconSize: 30,
                            // ),
                            const Spacer(),
                            SizedBox(
                                height: 48,
                                child: TextButton(
                                    onPressed: () => (Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const Register()))),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.white24),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 8),
                                      child: Text(
                                        AppLocalizations.of(context)!.register,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ))),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                  onPressed: () => (Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Login()))),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: const StadiumBorder(),
                                    backgroundColor: PrimaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ])),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
                      // decoration: const BoxDecoration(
                      //     image: DecorationImage(image: AssetImage("assets/images/welcome-bg.png"), fit: BoxFit.cover),
                      //     borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                AppLocalizations.of(context)!.welcome_caption,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.0,
                                    color: Colors.black38),
                              )),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          animType: AnimType.topSlide,
                                          descTextStyle: generalfontStyle,
                                          titleTextStyle: titleFontStyle,
                                          title:    AppLocalizations.of(context)!
                                        .request_sent,
                                          desc:
                                               AppLocalizations.of(context)!
                                        .request_sent_disc,
                                          btnOkOnPress: () {})
                                      .show();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red.withOpacity(0.15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .become_lifesaver,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.25,
                                        color: Colors.red.shade800),
                                  ),
                                )),
                          ),
                        ],
                      )))
            ],
          )),
    );
  }
}
