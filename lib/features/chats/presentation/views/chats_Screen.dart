import 'package:chat/core/service/fcm_service.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/features/chats/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_screen_body.dart';
import 'package:chat/features/chats/presentation/views/widgets/create_new_chat_bottom_sheet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ChatsScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const ChatsScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () async {
                FirebaseMessaging.instance.requestPermission();
                final token = await FirebaseMessaging.instance.getToken();
                final fcmService = FcmService();
                await fcmService.sendNotification(
                  recipientFCMToken: token!,
                  title: 'Test Notification',
                  body: 'This is a test notification',
                  data: {'key': 'value'},
                );
                final chatCubit = BlocProvider.of<ChatCubit>(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (bottomSheetContext) {
                    return BlocProvider.value(
                      value: chatCubit,
                      child: const CreateChatBottomSheet(),
                    );
                  },
                );
              },
              child: const Icon(
                Iconsax.message_add,
                color: AppTheme.primaryColor,
              ),
            );
          },
        ),
        backgroundColor: Colors.black,
        body: ChatScreenBody(scrollController: scrollController),
      ),
    );
  }
}
