// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiChatHistoryStoreHash() =>
    r'057f7310329a9d13778b7cc54301b0b2b2c34e5a';

/// See also [AiChatHistoryStore].
@ProviderFor(AiChatHistoryStore)
final aiChatHistoryStoreProvider =
    NotifierProvider<AiChatHistoryStore, List<AiChatSession>>.internal(
      AiChatHistoryStore.new,
      name: r'aiChatHistoryStoreProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$aiChatHistoryStoreHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AiChatHistoryStore = Notifier<List<AiChatSession>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
