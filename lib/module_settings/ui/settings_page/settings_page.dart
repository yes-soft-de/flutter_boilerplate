import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_auth/authorization_routes.dart';
import 'package:pasco_shipping/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:pasco_shipping/generated/l10n.dart';
import 'package:pasco_shipping/module_auth/service/auth_service/auth_service.dart';
import 'package:pasco_shipping/module_localization/service/localization_service/localization_service.dart';
import 'package:pasco_shipping/module_theme/service/theme_service/theme_service.dart';

@injectable
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final AppThemeDataService _themeDataService;
  final FireNotificationService _notificationService;

  SettingsScreen(
    this._authService,
    this._localizationService,
    this._themeDataService,
    this._notificationService,
  );

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).settings,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).darkMode),
                      Switch(
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (mode) {
                            widget._themeDataService
                                .switchDarkMode(mode)
                                .then((value) {});
                          })
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).language),
                      FutureBuilder(
                        initialData: Platform.localeName.substring(0, 2),
                        future: widget._localizationService.getLanguage(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          return DropdownButton(
                              value: snapshot.data ??
                                  Platform.localeName.substring(0, 2),
                              items: [
                                DropdownMenuItem(
                                  child: Text('العربية'),
                                  value: 'ar',
                                ),
                                DropdownMenuItem(
                                  child: Text('English'),
                                  value: 'en',
                                ),
                              ],
                              onChanged: (newLang) {
                                widget._localizationService
                                    .setLanguage(newLang.toString());
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                    future: widget._authService.isLoggedIn,
                    initialData: false,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data!) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).signOut),
                            IconButton(
                                icon: Icon(Icons.logout),
                                onPressed: () {
                                  widget._authService.logout().then((value) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AuthorizationRoutes.LOGIN_SCREEN,
                                        (route) => false);
                                  });
                                })
                          ],
                        );
                      } else {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).login),
                            IconButton(
                                icon: Icon(Icons.login),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      AuthorizationRoutes.LOGIN_SCREEN);
                                })
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
