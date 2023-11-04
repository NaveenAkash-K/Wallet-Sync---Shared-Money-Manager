import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:walletSync/models/invitation_model.dart';

class InvitationsScreen extends StatefulWidget {
  const InvitationsScreen({super.key});
  @override
  State<StatefulWidget> createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State {
  final firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<Invitation> invitationsList = [];
  String? email;
  bool isFetching = false;

  void getEmail() async {
    setState(() {
      isFetching = true;
    });
    final snapshot = await firestore.collection('users').doc(uid).get();

    email = (snapshot
        .data()!
        .entries
        .firstWhere((element) => element.key == 'email')
        .value);
  }

  void getInvitations() async {
    final snapshot = await firestore
        .collection('invitations')
        .where('recipientEmail', isEqualTo: email)
        .get();

    setState(() {
      isFetching = false;
    });

    String? sharedExpenseId;
    String? senderUid;
    String? senderUsername;
    String? sharedExpenseTitle;

    if (snapshot.docs.isNotEmpty) {
      for (final invitations in snapshot.docs) {
        final invitationsMap = invitations.data();
        sharedExpenseId = invitationsMap['sharedExpenseId'];
        senderUid = invitationsMap['senderUid'];
        senderUsername = invitationsMap['senderUsername'];
        sharedExpenseTitle = invitationsMap['sharedExpenseTitle'];

        setState(() {
          invitationsList.add(Invitation(
            sharedExpenseId: sharedExpenseId!,
            senderUid: senderUid!,
            senderUsername: senderUsername!,
            sharedExpenseTitle: sharedExpenseTitle!,
          ));
        });
      }
    }
  }

  void acceptInvitation() {}

  @override
  void initState() {
    getEmail();
    getInvitations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isFetching
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : invitationsList.isEmpty
                  ? Center(
                      child: Text(
                        "No Invitations",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: invitationsList.length,
                        itemBuilder: (context, index) => ListTile(
                          title:
                              Text(invitationsList[index].sharedExpenseTitle),
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}
