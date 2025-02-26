import 'package:flutter/material.dart';

class InputFrom extends StatefulWidget {
  const InputFrom({super.key});

  @override
  State<InputFrom> createState() => _InputFromState();
}

class _InputFromState extends State<InputFrom> {
  final _formKey = GlobalKey<FormState>();

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
            onPressed: () {
              final formState = _formKey.currentState!;
              formState.validate();
            },
            child: const Text('変換'),
          ),
        ],
      ),
    );
  }
}
