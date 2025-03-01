// アプリの状態を表すクラスを定義
sealed class AppState {
  const AppState();
}

// 入力状態
class Input extends AppState {
  const Input() : super();
}

// APIのレスポンス待ち
class Loading extends AppState {
  const Loading() : super();
}

// APIのレスポンスを受け取った状態
class Data extends AppState {
  const Data(this.sentence);

  final String sentence;
}
