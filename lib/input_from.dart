// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:hiragana_converter/data.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiragana_converter/app_notifier_provider.dart';

// ConsumerStatefulWidgetを継承
class InputFrom extends ConsumerStatefulWidget {
  const InputFrom({super.key});

  @override
  ConsumerState<InputFrom> createState() => _InputFromState();
}

class _InputFromState extends ConsumerState<InputFrom> {
  final _formKey = GlobalKey<FormState>();

  /// TextFieldウィジェットの入力文字や選択文字を取得、変更する紀を持つ
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              /// 値を取得するためのコントローラー
              controller: _textEditingController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '文章を入力してください。',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '文章を入力してください。';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              /// FormウィジェットからStateを取得
              final formState = _formKey.currentState!;
              if (!formState.validate()) {
                return;
              }
              final sentence = _textEditingController.text;
              await ref.read(appNotifierProvider.notifier).convert(sentence);
            },
            child: const Text('変換'),
          ),
        ],
      ),
    );
  }

  /// メモリリークを防ぐために、コントローラーを破棄する
  /// StatefulWidgetが破棄されるときに呼び出される
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
