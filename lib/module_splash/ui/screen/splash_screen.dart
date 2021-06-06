import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_auth/authorization_routes.dart';
import 'package:pasco_shipping/module_auth/enums/user_type.dart';
import 'package:pasco_shipping/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

  @injectable
  class SplashScreen extends StatefulWidget {
    final AuthService _authService;
  SplashScreen(
    this._authService,
  );
    @override
    _SplashScreenState createState() => _SplashScreenState();
  }
  
  class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {
    super.initState();
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) {
       Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
  }
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
    }
    
  Future<String> _getNextRoute() async {
    try {
      //var isInited = await _aboutService.isInited();

      // if (!isInited) {
      //   return AboutRoutes.ROUTE_ABOUT;
      // }
      var role = await widget._authService.userRole;
      await widget._authService.isLoggedIn.then((value) {
        if (value) {
          if (role == UserRole.ROLE_OWNER) {
            return AuthorizationRoutes.LOGIN_SCREEN;
          } else if (role == UserRole.ROLE_CAPTAIN) {
            return AuthorizationRoutes.LOGIN_SCREEN;
          } else {
            return AuthorizationRoutes.LOGIN_SCREEN;
          }
        } else {
          return AuthorizationRoutes.LOGIN_SCREEN;
        }
      });
    } catch (e) {
      return AuthorizationRoutes.LOGIN_SCREEN;
    }
    return AuthorizationRoutes.LOGIN_SCREEN;
  }
  }
