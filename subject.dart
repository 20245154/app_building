import 'package:flutter/material.dart';
import 'st24.dart';
import 'st25.dart'; // 💡 25학번 화면을 가져옵니다.

class SubjectScreen extends StatelessWidget {
  final String studentId;
  final Function(int totalAll, Map<String, int> creditDetails) onSave;

  const SubjectScreen({
    super.key,
    required this.studentId,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    // 학번에 따른 분기 처리 완료
    if (studentId == '24학번') {
      return St24Screen(
        studentId: studentId,
        onSave: onSave,
      );
    } else if (studentId == '25학번') {
      // 💡 25학번을 선택해 들어왔을 때 우리가 방금 만든 입력 창으로 연결됩니다!
      return St25Screen(
        studentId: studentId,
        onSave: onSave,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("준비 중")),
      body: const Center(child: Text("지원하지 않는 학번입니다.")),
    );
  }
}
