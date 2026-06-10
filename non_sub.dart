import 'package:flutter/material.dart';

// [4] 비교과 요건 관리 화면
class NonSubjectScreen extends StatefulWidget {
  final int initialGender;
  final int initialFirstAid;
  final int initialAptitude;
  final bool initialGraduation;
  final bool initialHistory;
  // 💡 저장을 눌렀을 때만 부모(메인) 화면으로 데이터를 넘겨줄 콜백 함수
  final Function(int, int, int, bool, bool) onStateChanged;

  const NonSubjectScreen({
    super.key,
    required this.initialGender,
    required this.initialFirstAid,
    required this.initialAptitude,
    required this.initialGraduation,
    required this.initialHistory,
    required this.onStateChanged,
  });

  @override
  State<NonSubjectScreen> createState() => _NonSubjectScreenState();
}

class _NonSubjectScreenState extends State<NonSubjectScreen> {
  // 사용자가 화면 안에서 임시로 변경할 데이터 변수들
  late int _genderEducation;
  late int _firstAid;
  late int _aptitudeTest;
  late bool _isGraduationProjectDone;
  late bool _isHistoryLicenseDone;

  @override
  void initState() {
    super.initState();
    // 화면이 켜질 때 메인 대시보드의 기존 데이터를 복사해옵니다.
    _genderEducation = widget.initialGender;
    _firstAid = widget.initialFirstAid;
    _aptitudeTest = widget.initialAptitude;
    _isGraduationProjectDone = widget.initialGraduation;
    _isHistoryLicenseDone = widget.initialHistory;
  }

  // 카운트 증감 함수 (💡 실시간 전송 코드를 제거했습니다.)
  void _updateCount(String type, bool isIncrement) {
    setState(() {
      if (type == 'gender') {
        if (isIncrement && _genderEducation < 4) _genderEducation++;
        if (!isIncrement && _genderEducation > 0) _genderEducation--;
      } else if (type == 'firstAid') {
        if (isIncrement && _firstAid < 2) _firstAid++;
        if (!isIncrement && _firstAid > 0) _firstAid--;
      } else if (type == 'aptitude') {
        if (isIncrement && _aptitudeTest < 2) _aptitudeTest++;
        if (!isIncrement && _aptitudeTest > 0) _aptitudeTest--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text("비교과 요건 관리", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2B72B5),
        foregroundColor: Colors.white,
        elevation: 0,
        // 💡 상단 왼쪽 기본 뒤로가기 버튼도 '취소' 역할을 하도록 뒤로가기 동작을 명시적으로 제어합니다.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 아무것도 저장하지 않고 그냥 화면 닫기 (취소와 동일)
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. 비교과 요건 리스트 카드 박스
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _buildCounterRow(
                      title: "성인지 교육",
                      current: _genderEducation,
                      max: 4,
                      onMinus: () => _updateCount('gender', false),
                      onPlus: () => _updateCount('gender', true),
                    ),
                    const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),

                    _buildCounterRow(
                      title: "응급처치",
                      current: _firstAid,
                      max: 2,
                      onMinus: () => _updateCount('firstAid', false),
                      onPlus: () => _updateCount('firstAid', true),
                    ),
                    const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),

                    _buildCounterRow(
                      title: "인적성 검사",
                      current: _aptitudeTest,
                      max: 2,
                      onMinus: () => _updateCount('aptitude', false),
                      onPlus: () => _updateCount('aptitude', true),
                    ),
                    const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),

                    _buildCheckRow(
                      title: "졸업작품",
                      isChecked: _isGraduationProjectDone,
                      onChanged: (value) {
                        setState(() {
                          _isGraduationProjectDone = value ?? false;
                        });
                      },
                    ),
                    const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),

                    _buildCheckRow(
                      title: "한국사 자격증",
                      isChecked: _isHistoryLicenseDone,
                      onChanged: (value) {
                        setState(() {
                          _isHistoryLicenseDone = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 💡 2. 하단 [취소] / [저장] 버튼 구역 추가됨
            Row(
              children: [
                // [취소] 버튼
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF94A3B8), width: 1.5),
                      foregroundColor: const Color(0xFF475569),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      debugPrint("비교과 변경 사항 취소됨");
                      Navigator.pop(context); // 💡 데이터 전달 없이 화면만 닫음 (대시보드 반영 안 됨)
                    },
                    child: const Text("취소", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 14),

                // [저장] 버튼
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B72B5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      debugPrint("비교과 변경 사항 저장 완료");
                      // 💡 저장을 누르는 시점에만 대시보드 화면으로 수정된 값을 한방에 쏴줍니다.
                      widget.onStateChanged(
                        _genderEducation,
                        _firstAid,
                        _aptitudeTest,
                        _isGraduationProjectDone,
                        _isHistoryLicenseDone,
                      );
                      Navigator.pop(context); // 데이터 반영 후 화면 닫기
                    },
                    child: const Text("저장", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- 기존 리스트 UI 빌더 함수들은 변경 없음 ---
  Widget _buildCounterRow({
    required String title,
    required int current,
    required int max,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    final bool isCompleted = (current == max);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isCompleted ? Colors.black38 : Colors.black87,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Color(0xFF2B72B5), size: 28),
                onPressed: onMinus,
              ),
              SizedBox(
                width: 55,
                child: Center(
                  child: Text(
                    "$current/$max회",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? const Color(0xFF2B72B5) : Colors.black87,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Color(0xFF2B72B5), size: 28),
                onPressed: onPlus,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCheckRow({
    required String title,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!isChecked),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 2),
                color: isChecked ? Colors.black87 : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: isChecked ? const Icon(Icons.check, size: 18, color: Colors.white) : null,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isChecked ? Colors.black38 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
