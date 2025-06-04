import 'package:chat/core/utils/functions/get_user.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/chats/presentation/manager/unread_count_cubit/unread_count_cubit.dart';
import 'package:chat/features/messages/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat/features/messages/presentation/views/widgets/chat_app_bar.dart';
import 'package:chat/features/messages/presentation/views/widgets/chat_text_field.dart';
import 'package:chat/features/messages/presentation/views/widgets/messages_list_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.user, required this.chatId});
  final UserEntity user;
  final String chatId;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // Controller for the text field
  final TextEditingController _messageController = TextEditingController();
  // Get Firebase Auth from GetIt instead of using instance directly

  // Current user ID from Firebase Auth - initialize with empty string
  String _currentUserId = '';
  // Chat ID formed from both user IDs

  // Store a reference to UnreadCountCubit
  late UnreadCountCubit _unreadCountCubit;
  late String currentUser; // Default value until loaded

  @override
  void initState() {
    super.initState();

    // Initialize user data asynchronously
    _loadUserData();
  }

  // Separate method to handle async initialization
  Future<void> _loadUserData() async {
    final user = await getUser();
    if (!mounted) return;
    setState(() {
      _currentUserId = user.id;
      currentUser = user.name;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Store reference to UnreadCountCubit and set current chat ID
    _unreadCountCubit = context.read<UnreadCountCubit>();
    _unreadCountCubit.setCurrentChat(widget.chatId);
  }

  @override
  void dispose() {
    _messageController.dispose();
    // Clear current chat ID when leaving the chat screen
    // Use the stored reference instead of accessing through context
    _unreadCountCubit.currentChatId.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(user: widget.user),
      body: Column(
        children: [
          Expanded(
            child: MessagesListView(
              chatId: widget.chatId,
              currentUserId: _currentUserId,
            ),
          ),
          ChatTextField(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    // Clear the text field first for better UX
    _messageController.clear();

    // Send the message using the MessageCubit
    context.read<MessageCubit>().sendMessage(
          content: messageText,
          chatId: widget.chatId,
          currentUserId: _currentUserId,
          receiverId: widget.user.id,
          senderName: currentUser,
          fcmToken: widget.user.pushToken,
        );
  }
}
