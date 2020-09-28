import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_profile/model/profile_model/profile_model.dart';
import 'package:swaptime_flutter/module_profile/service/my_profile/my_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class SwapNavigationDrawer extends StatelessWidget {
  final MyProfileService profileService;

  SwapNavigationDrawer(this.profileService);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 252,
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.softLight,
            ),
          ),

          Positioned.fill(
              child: Container(
            color: Colors.black54,
          )),

          // Foreground
          Positioned.fill(
              child: Container(
            color: Color(0x882CC0CD),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // region Header
                FutureBuilder(
                  future: profileService.getProfile(),
                  builder: (BuildContext context,
                      AsyncSnapshot<ProfileModel> snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Container();
                    }
                    if (snapshot.data.name == null) {
                      return Container();
                    }
                    return Container(
                      height: 116,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Color(0x8FFFFFFF)
                          : Color(0x8F000000),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // User Image
                            Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(snapshot.data.image))),
                            ),
                            // User Details
                            Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                !snapshot.hasData
                                    ? Text(S.of(context).loading)
                                    : Text(
                                        '${snapshot.data.name}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // endregion

                // region Sections
                Flex(
                  direction: Axis.vertical,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(HomeRoutes.ROUTE_HOME, arguments: 0);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.dashboard,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(
                              S.of(context).feed,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          HomeRoutes.ROUTE_HOME,
                          arguments: 1,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(S.of(context).notifications,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(HomeRoutes.ROUTE_HOME, arguments: 4);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(S.of(context).settings,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(S.of(context).tos,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(
                              S.of(context).privacyPolicy,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // endregion

                // region Social Links
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Container(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            'assets/images/twitter.svg',
                            color: Colors.white,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset(
                          'assets/images/facebook.svg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // endregion

                // region Feedback Button
                GestureDetector(
                  onTap: () {
                    canLaunch('https://www.google.com').then((value) {
                      if (value) {
                        launch('https://www.google.com');
                      }
                    });
                  },
                  child: Container(
                    width: 252,
                    height: 48,
                    alignment: Alignment.center,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    child: Text(S.of(context).feedback),
                  ),
                ),
                // endregion
              ],
            ),
          ))
        ],
      ),
    );
  }
}
