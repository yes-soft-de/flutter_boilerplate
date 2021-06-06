// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i40;
import '../module_auth/authoriazation_module.dart' as _i35;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i16;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i14;
import '../module_auth/service/auth_service/auth_service.dart' as _i17;
import '../module_auth/service/auth_service_without_fire_base/auth_service_api.dart'
    as _i18;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i21;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i23;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i29;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i30;
import '../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i36;
import '../module_chat/chat_module.dart' as _i39;
import '../module_chat/manager/chat/chat_manager.dart' as _i26;
import '../module_chat/repository/chat/chat_repository.dart' as _i19;
import '../module_chat/service/chat/char_service.dart' as _i27;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i38;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i5;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i6;
import '../module_network/http_client/http_client.dart' as _i12;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i8;
import '../module_notifications/repository/notification_repo.dart' as _i22;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i28;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i4;
import '../module_report/manager/report_manager.dart' as _i31;
import '../module_report/presistance/report_prefs_helper.dart' as _i9;
import '../module_report/repository/report_repository.dart' as _i24;
import '../module_report/service/report_service.dart' as _i32;
import '../module_settings/settings_module.dart' as _i37;
import '../module_settings/ui/settings_page/settings_page.dart' as _i33;
import '../module_splash/splash_module.dart' as _i34;
import '../module_splash/ui/screen/splash_screen.dart' as _i25;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i10;
import '../module_theme/service/theme_service/theme_service.dart' as _i13;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i15;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i11;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i20;
import '../utils/logger/logger.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.LocalNotificationService>(
      () => _i4.LocalNotificationService());
  gh.factory<_i5.LocalizationPreferencesHelper>(
      () => _i5.LocalizationPreferencesHelper());
  gh.factory<_i6.LocalizationService>(
      () => _i6.LocalizationService(get<_i5.LocalizationPreferencesHelper>()));
  gh.factory<_i7.Logger>(() => _i7.Logger());
  gh.factory<_i8.NotificationsPrefsHelper>(
      () => _i8.NotificationsPrefsHelper());
  gh.factory<_i9.ReportPrefsHelper>(() => _i9.ReportPrefsHelper());
  gh.factory<_i10.ThemePreferencesHelper>(() => _i10.ThemePreferencesHelper());
  gh.factory<_i11.UploadRepository>(() => _i11.UploadRepository());
  gh.factory<_i12.ApiClient>(() => _i12.ApiClient(get<_i7.Logger>()));
  gh.factory<_i13.AppThemeDataService>(
      () => _i13.AppThemeDataService(get<_i10.ThemePreferencesHelper>()));
  gh.factory<_i14.AuthRepository>(
      () => _i14.AuthRepository(get<_i12.ApiClient>()));
  gh.factory<_i15.UploadManager>(
      () => _i15.UploadManager(get<_i11.UploadRepository>()));
  gh.factory<_i16.AuthManager>(
      () => _i16.AuthManager(get<_i14.AuthRepository>()));
  gh.factory<_i17.AuthService>(() =>
      _i17.AuthService(get<_i3.AuthPrefsHelper>(), get<_i16.AuthManager>()));
  gh.factory<_i18.AuthServiceApi>(() =>
      _i18.AuthServiceApi(get<_i3.AuthPrefsHelper>(), get<_i16.AuthManager>()));
  gh.factory<_i19.ChatRepository>(() =>
      _i19.ChatRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i20.ImageUploadService>(
      () => _i20.ImageUploadService(get<_i15.UploadManager>()));
  gh.factory<_i21.LoginStateManager>(
      () => _i21.LoginStateManager(get<_i17.AuthService>()));
  gh.factory<_i22.NotificationRepo>(() =>
      _i22.NotificationRepo(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i23.RegisterStateManager>(
      () => _i23.RegisterStateManager(get<_i17.AuthService>()));
  gh.factory<_i24.ReportRepository>(() => _i24.ReportRepository(
      get<_i12.ApiClient>(),
      get<_i17.AuthService>(),
      get<_i9.ReportPrefsHelper>()));
  gh.factory<_i25.SplashScreen>(
      () => _i25.SplashScreen(get<_i17.AuthService>()));
  gh.factory<_i26.ChatManager>(
      () => _i26.ChatManager(get<_i19.ChatRepository>()));
  gh.factory<_i27.ChatService>(() => _i27.ChatService(get<_i26.ChatManager>()));
  gh.factory<_i28.FireNotificationService>(() => _i28.FireNotificationService(
      get<_i8.NotificationsPrefsHelper>(), get<_i22.NotificationRepo>()));
  gh.factory<_i29.LoginScreen>(
      () => _i29.LoginScreen(get<_i21.LoginStateManager>()));
  gh.factory<_i30.RegisterScreen>(
      () => _i30.RegisterScreen(get<_i23.RegisterStateManager>()));
  gh.factory<_i31.ReportManager>(
      () => _i31.ReportManager(get<_i24.ReportRepository>()));
  gh.factory<_i32.ReportService>(
      () => _i32.ReportService(get<_i31.ReportManager>()));
  gh.factory<_i33.SettingsScreen>(() => _i33.SettingsScreen(
      get<_i17.AuthService>(),
      get<_i6.LocalizationService>(),
      get<_i13.AppThemeDataService>(),
      get<_i28.FireNotificationService>()));
  gh.factory<_i34.SplashModule>(
      () => _i34.SplashModule(get<_i25.SplashScreen>()));
  gh.factory<_i35.AuthorizationModule>(() => _i35.AuthorizationModule(
      get<_i29.LoginScreen>(), get<_i30.RegisterScreen>()));
  gh.factory<_i36.ChatPageBloc>(
      () => _i36.ChatPageBloc(get<_i27.ChatService>()));
  gh.factory<_i37.SettingsModule>(
      () => _i37.SettingsModule(get<_i33.SettingsScreen>()));
  gh.factory<_i38.ChatPage>(() =>
      _i38.ChatPage(get<_i36.ChatPageBloc>(), get<_i20.ImageUploadService>()));
  gh.factory<_i39.ChatModule>(
      () => _i39.ChatModule(get<_i38.ChatPage>(), get<_i17.AuthService>()));
  gh.factory<_i40.MyApp>(() => _i40.MyApp(
      get<_i13.AppThemeDataService>(),
      get<_i6.LocalizationService>(),
      get<_i28.FireNotificationService>(),
      get<_i4.LocalNotificationService>(),
      get<_i34.SplashModule>(),
      get<_i35.AuthorizationModule>(),
      get<_i39.ChatModule>(),
      get<_i37.SettingsModule>()));
  return get;
}
