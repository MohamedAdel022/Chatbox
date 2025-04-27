import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/chats/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat/features/chats/presentation/views/widgets/conversation_list_view.dart';
import 'package:chat/features/chats/presentation/views/widgets/create_new_chat_bottom_sheet.dart';
import 'package:chat/features/chats/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ChatsScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const ChatsScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
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
          }),
          backgroundColor: Colors.black,
          body: Column(
            children: [
              verticalSpace(20),
              HomeHeader(
                title: "Chats",
              ),
              verticalSpace(50),
              Expanded(
                child: BackgroundContainer(
                  child: Column(
                    children: [
                      Expanded(
                        child: ConversationListView(
                          scrollController: scrollController,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
