import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:walletSync/screens/invitations_screen.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              height: 250,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Wallet Sync",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                  Text(
                    "Personal and Shared Money Manager",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(MaterialCommunityIcons.account_multiple),
              title: const Text("Shared Expense Invitations"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InvitationsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(MaterialCommunityIcons.logout),
              title: const Text("Logout"),
              onTap: () {
                firebaseAuth.signOut();
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(MaterialCommunityIcons.code_brackets),
              title: const Text("About Developer"),
              onTap: () {},
            ),
          ],
        ),
      );
}
