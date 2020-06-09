import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flo/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flo/models/contact.dart';

import 'package:flo/resources/chat_methods.dart';
import 'package:flo/screens/callscreens/pickup/pickup_layout.dart';
import 'package:flo/screens/pageviews/widgets/contact_view.dart';
import 'package:flo/screens/pageviews/widgets/new_chat_button.dart';
import 'package:flo/screens/pageviews/widgets/quiet_box.dart';
import 'package:flo/screens/pageviews/widgets/user_circle.dart';

import 'package:flo/widgets/appbar.dart';


import 'widgets/new_chat_button.dart';
import 'widgets/user_circle.dart';

class ChatListScreen extends StatelessWidget {
  CustomAppBar customAppBar(BuildContext context) {

    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.grey,
        ),
        onPressed: () {},
      ),
      title: UserCircle(),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/search_screen");
          },
        ),
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context),
        floatingActionButton: NewChatButton(),
        body: ChatListContainer(),
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return QuietBox();
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);

                  return ContactView(contact);
                },
              );
            }

            return Center(child:  SpinKitFadingFour(
               color: Colors.blue[900],
                size: 40.0,),
            );
          },
          ),
    );
  }
}