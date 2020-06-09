

import 'package:flo/enum/user_state.dart';
import 'package:flo/provider/user_provider.dart';
import 'package:flo/resources/firebase_methods.dart';
import 'package:flo/screens/callscreens/pickup/pickup_layout.dart';
import 'package:flo/screens/pageviews/chat_list.dart';
//import 'package:flo/utils/Universal_variables.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
//import 'package:eva_icons_flutter/eva_icons_flutter.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  PageController pageController;
  int _page = 0;
  UserProvider userProvider;


  final AuthMethods _authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      _authMethods.setUserState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online, 
      );
    });

    WidgetsBinding.instance.addObserver(this);

    pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("detached state");
        break;
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
   

    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor:Colors.white,
        body: PageView(
          children: <Widget>[
            Container(
              child: ChatListScreen(),
            ),
            Center(
              child: Text(
                "Call Logs",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Center(
                child: Text(
              "Contact Screen",
              style: TextStyle(color: Colors.white),
            )),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: ScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CupertinoTabBar(
              backgroundColor:Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat,
                      color: (_page == 0)
                          ?Colors.pink[800]
                          :Colors.grey),
                  title: Text(
                    "Chats",
                    style: TextStyle(
                        fontSize: 15,
                        color: (_page == 0)
                            ?Colors.teal
                            : Colors.grey),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call,
                      color: (_page == 1)
                          ?Colors.pink[800]
                          :Colors.grey),
                  title: Text(
                    "Calls",
                    style: TextStyle(
                        fontSize: 15,
                        color: (_page == 1)
                            ?Colors.teal
                            : Colors.grey),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contact_phone,
                      color: (_page == 2)
                          ?Colors.pink[800]
                          :Colors.grey),
                  title: Text(
                    "Contacts",
                    style: TextStyle(
                        fontSize: 15,
                        color: (_page == 2)
                            ?Colors.teal
                            : Colors.grey),
                  ),
                ),
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            ),
          ),
        ),
      ),
    );
  }
}