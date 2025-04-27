import 'package:chat/core/helper/app_regx.dart';
import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/features/chats/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat/features/chats/presentation/manager/chat_cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class CreateNewChatForm extends StatefulWidget {
  const CreateNewChatForm({
    super.key,
  });

  @override
  State<CreateNewChatForm> createState() => _CreateNewChatFormState();
}

class _CreateNewChatFormState extends State<CreateNewChatForm> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    if (!AppRegx.isEmailValid(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Start a new chat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(20),
          TextFormField(
            validator: _validateEmail,
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Enter email address',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.secondaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppTheme.secondaryColor, width: 2),
              ),
              prefixIcon: Icon(Iconsax.sms, color: AppTheme.secondaryColor),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          verticalSpace(16),
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is ChatLoadingState
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<ChatCubit>()
                                .createChat(_emailController.text);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: state is ChatLoadingState
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Create Chat'),
                ),
              );
            },
          ),
          verticalSpace(8),
        ],
      ),
    );
  }
}
