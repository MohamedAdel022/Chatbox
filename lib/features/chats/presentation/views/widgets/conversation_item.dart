import 'package:chat/core/di/get_it.dart';
import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/service/time_service.dart';
import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/features/chats/domain/entities/chat_entity.dart';
import 'package:chat/features/chats/presentation/manager/unread_count_cubit/unread_count_cubit.dart';
import 'package:chat/features/chats/presentation/manager/unread_count_cubit/unread_count_state.dart';
import 'package:chat/features/chats/presentation/views/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationItem extends StatelessWidget {
  final ChatEntity chat;

  const ConversationItem({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final displayName =
        chat.otherUserInfo?.name ?? "Chat ${chat.id.substring(0, 4)}";

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ProfileImage(
        radius: 28.r,
        isLoading: false,
        imageUrl: chat.otherUserInfo?.imageUrl ?? '',
      ),
      title: Text(
        displayName,
        style: AppTextStyle.mediumBlack20,
      ),
      subtitle: Text(
        chat.lastMessage,
        style: AppTextStyle.regularGray12,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getIt<TimeService>()
                .formatChatListTime(chat.lastMessageTime.toDate()),
            textAlign: TextAlign.right,
            style: AppTextStyle.regularGray12,
          ),
          verticalSpace(5),
          // Use BlocBuilder to listen for unread count updates
          BlocBuilder<UnreadCountCubit, UnreadCountState>(
            builder: (context, state) {
              // Get unread count from state
              final unreadCount =
                  state is UnreadCountLoaded ? state.getCountFor(chat.id) : 0;
              if (unreadCount > 0) {
                // Display unread messages count indicator
                return Container(
                  width: 22.w,
                  height: 22.h,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      unreadCount.toString(),
                      style: AppTextStyle.mediumWhite12,
                    ),
                  ),
                );
              }

              // If no unread messages, return empty
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
