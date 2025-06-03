part of 'message_cubit.dart';

@freezed
class MessageState with _$MessageState {
  const factory MessageState.initial() = _Initial;
  const factory MessageState.loading() = _Loading;
  const factory MessageState.sending(List<MessageEntity> messages) = _Sending;
  const factory MessageState.success(List<MessageEntity> messages) = _Success;
  const factory MessageState.error(String error) = _Error;
}
