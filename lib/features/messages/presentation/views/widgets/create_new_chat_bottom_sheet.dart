import 'package:chat/features/messages/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat/features/messages/presentation/manager/chat_cubit/chat_state.dart';
import 'package:chat/features/messages/presentation/views/widgets/create_new_chat_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateChatBottomSheet extends StatelessWidget {
  const CreateChatBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatCreatedState) {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Chat created successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is ChatErrorState) {
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: CreateNewChatForm(),
        );
      },
    );
  }
}
