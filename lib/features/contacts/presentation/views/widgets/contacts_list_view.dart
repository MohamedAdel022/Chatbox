import 'package:chat/features/contacts/data/models/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsListView extends StatelessWidget {
  ContactsListView({super.key, this.scrollController});

  final ScrollController? scrollController;

  // Sample data - replace with your actual data source
  final List<Contact> contacts = [
    Contact(name: "Adam Smith", imageUrl: "assets/images/temp.png"),
    Contact(name: "Alex Johnson", imageUrl: "assets/images/temp.png"),
    Contact(name: "Bob Williams", imageUrl: "assets/images/temp.png"),
    Contact(name: "Catherine Davis", imageUrl: "assets/images/avatar4.png"),
    Contact(name: "David Brown", imageUrl: "assets/images/avatar5.png"),
    Contact(name: "Emma Wilson", imageUrl: "assets/images/avatar6.png"),
    Contact(name: "Frank Miller", imageUrl: "assets/images/avatar7.png"),
    Contact(name: "Grace Taylor", imageUrl: "assets/images/avatar8.png"),
    Contact(name: "Henry Jones", imageUrl: "assets/images/avatar9.png"),
  ];

  // Group contacts by first letter

  @override
  Widget build(BuildContext context) {
    final groupedContacts = _groupContactsByFirstLetter();

    return ListView.builder(
      controller: scrollController,
      itemCount: groupedContacts.length,
      itemBuilder: (context, index) {
        final letter = groupedContacts.keys.elementAt(index);
        final contactsInGroup = groupedContacts[letter]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                letter,
                style: TextStyle(
                  color: const Color(0xFF000D07),
                  fontSize: 16,
                  fontFamily: 'Caros',
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ),
            ...contactsInGroup.map((contact) => _buildContactTile(contact)),
          ],
        );
      },
    );
  }

  Widget _buildContactTile(Contact contact) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: AssetImage(contact.imageUrl),
        radius: 25.r,
      ),
      title: Text(
        contact.name,
        style: TextStyle(
          color: const Color(0xFF000D07),
          fontSize: 18,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          height: 1,
        ),
      ),
      onTap: () {
        // Handle contact tap
      },
    );
  }

  Map<String, List<Contact>> _groupContactsByFirstLetter() {
    final Map<String, List<Contact>> groupedContacts = {};

    for (var contact in contacts) {
      final firstLetter = contact.name[0].toUpperCase();
      if (!groupedContacts.containsKey(firstLetter)) {
        groupedContacts[firstLetter] = [];
      }
      groupedContacts[firstLetter]!.add(contact);
    }

    // Sort the keys alphabetically
    final sortedKeys = groupedContacts.keys.toList()..sort();
    final sortedGroupedContacts = {
      for (var key in sortedKeys) key: groupedContacts[key]!
    };

    return sortedGroupedContacts;
  }
}
