import 'dart:developer';

import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/contacts/presentation/views/widgets/contacts_header.dart';
import 'package:chat/features/contacts/presentation/views/widgets/contacts_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key, this.scrollController});
  final ScrollController? scrollController;

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("the contacts page is here ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          verticalSpace(20),
          ContactsHeader(),
          verticalSpace(50),
          Expanded(
            child: BackgroundContainer(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Contact',
                      style: TextStyle(
                        color: const Color(0xFF000D07),
                        fontSize: 16,
                        fontFamily: 'Caros',
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    verticalSpace(10),
                    Expanded(
                      child: ContactsListView(
                        scrollController: widget.scrollController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
