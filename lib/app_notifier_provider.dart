import 'dart:convert';

import 'package:hiragana_converter/app_state.dart';
import 'package:hiragana_converter/data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'app_notifier_provider.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  @override
  AppState build() {
    // 初期状態ではInput状態を返す
    return const Input();
  }

  void reset() {
    state = const Input();
  }

  Future<void> convert(String sentence) async {
    state = const Loading();

    // 2025/03/03に廃止される予定のAPIを使用
    final url = Uri.parse('https://labs.goo.ne.jp/api/hiragana');
    final headers = {'Content-Type': 'application/json'};
    final request = Request(
      appId: const String.fromEnvironment('appId'),
      sentence: sentence,
    );

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(request.toJson()),
    );

    // APIのレスポンスをデシリアライズ
    final result =
        Response.fromJson(json.decode(response.body) as Map<String, Object?>);

    state = Data(result.converted);
  }
}
