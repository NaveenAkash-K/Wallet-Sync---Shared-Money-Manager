class Invitation {
  const Invitation(
      {required this.sharedExpenseId,
      required this.senderUid,
      required this.senderUsername,
      required this.sharedExpenseTitle
      // required this.recipientEmail,
      });

  final String sharedExpenseId;
  final String senderUid;
  final String senderUsername;
  final String sharedExpenseTitle;
  // final List<String> recipientEmail;
}
