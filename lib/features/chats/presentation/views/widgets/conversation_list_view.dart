import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/widgets/error_widget.dart';
import 'package:chat/core/widgets/loading_indicator.dart';
import 'package:chat/features/chats/domain/entities/chat_entity.dart';
import 'package:chat/features/chats/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat/features/chats/presentation/manager/chat_cubit/chat_state.dart';
import 'package:chat/features/chats/presentation/views/widgets/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationListView extends StatefulWidget {
  final ScrollController? scrollController;

  const ConversationListView({super.key, this.scrollController});

  @override
  State<ConversationListView> createState() => _ConversationListViewState();
}

class _ConversationListViewState extends State<ConversationListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return switch (state) {
          ChatLoadingState() => const Center(child: LoadingIndicator()),
          ChatErrorState(message: final message) =>
            Center(child: CustomErrorWidget(message: message)),
          ChatsLoadedState(chats: final chats) =>
            _buildChatsList(chats.isEmpty ? [] : chats),
          _ => _buildEmptyChatsList(),
        };
      },
    );
  }

  Widget _buildChatsList(List<ChatEntity> chats) {
    if (chats.isEmpty) {
      return _buildEmptyChatsList();
    }

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: chats.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.chatScreen,
                arguments: chat.otherUserInfo,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: ConversationItem(chat: chat),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyChatsList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.chat_bubble_outline, size: 50, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No chats found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => context.read<ChatCubit>().refreshChats(),
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }
}
