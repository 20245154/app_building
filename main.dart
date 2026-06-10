import 'package:flutter/material.dart';

// 💡 필수 Import 구문들
import 'subject.dart';
import 'non_subject.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GradPilot',
      theme: ThemeData(
        fontFamily: 'Noto Sans KR',
      ),
      home: const InitialConfigScreen(),
    );
  }
}

// ==========================================
// [1] 초기 설정 화면 (학번 선택)
// ==========================================
class InitialConfigScreen extends StatefulWidget {
  const InitialConfigScreen({super.key});

  @override
  State<InitialConfigScreen> createState() => _InitialConfigScreenState();
}

class _InitialConfigScreenState extends State<InitialConfigScreen> {
  String? _selectedStudentId;
  final List<String> _studentIdList = ['24학번', '25학번'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF005BAA).withValues(alpha: 0.15),
                          blurRadius: 20,
                        )
                      ],
                      border: Border.all(color: const Color(0xFF005BAA), width: 3),
                    ),
                    child: const Icon(Icons.school_rounded, size: 80, color: Color(0xFF005BAA)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "졸업 자가 진단 어플\n(순천대 컴교과 학생용)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("학번 입력", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedStudentId,
                        hint: const Text("예) 24학번"),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                        items: _studentIdList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(fontSize: 16)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedStudentId = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1C40F),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (_selectedStudentId != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainHomeScreen(studentId: _selectedStudentId!),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("학번을 먼저 선택해 주세요!")),
                        );
                      }
                    },
                    child: const Text("시작하기", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "국립순천대학교",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black38, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// [2] 메인 대시보드 화면
// ==========================================
class MainHomeScreen extends StatefulWidget {
  final String studentId;

  const MainHomeScreen({super.key, required this.studentId});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  // 💡 해결 포인트 1: 에러가 났던 교과 총 학점 저장 변수를 정상적으로 선언했습니다.
  int _totalSubjectCredit = 0;

  // 비교과 실시간 상태 변수
  int _genderEducation = 0;
  int _firstAid = 0;
  int _aptitudeTest = 0;
  bool _isGraduationProjectDone = false;
  bool _isHistoryLicenseDone = false;

  double _calculateNonSubjectProgress() {
    int totalCompleted = _genderEducation +
        _firstAid +
        _aptitudeTest +
        (_isGraduationProjectDone ? 1 : 0) +
        (_isHistoryLicenseDone ? 1 : 0);
    return totalCompleted / 10.0;
  }

  @override
  Widget build(BuildContext context) {
    double nonSubjectProgress = _calculateNonSubjectProgress();
    int nonSubjectPercentage = (nonSubjectProgress * 100).toInt();

    // 교과 학점 달성 비율 계산 (최대 140학점 기준)
    double subjectProgress = _totalSubjectCredit / 140.0;
    if (subjectProgress > 1.0) subjectProgress = 1.0; // 140점을 초과해도 게이지는 100% 유지
    int subjectPercentage = (subjectProgress * 100).toInt();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF005BAA)),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const InitialConfigScreen()),
                        );
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "졸업 진행 사항 / ${widget.studentId}",
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 30),

                // 2. [총 이수 학점 달성도] 원형 그래프 위젯 (💡 변수 연동 완료!)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("총 이수 학점 달성도", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                      const SizedBox(height: 12),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 160,
                            child: CircularProgressIndicator(
                              value: subjectProgress, // 고정값 0.50 대신 실시간 변수 바인딩
                              strokeWidth: 18,
                              backgroundColor: Colors.black.withValues(alpha: 0.05),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF005BAA)),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('$subjectPercentage%', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF005BAA))),
                              Text('$_totalSubjectCredit / 140', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                // 3. [비교과 요건 충족 현황] 원형 그래프 위젯
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("비교과 요건 충족 현황", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                      const SizedBox(height: 12),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 160,
                            child: CircularProgressIndicator(
                              value: nonSubjectProgress,
                              strokeWidth: 18,
                              backgroundColor: Colors.black.withValues(alpha: 0.05),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2B72B5)),
                            ),
                          ),
                          Text(
                            '$nonSubjectPercentage%',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2B72B5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // 4. 하단 메뉴 버튼 구역
                Row(
                  children: [
                    // 💡 해결 포인트 2: [학점 관리] 버튼 자리에 올바른 라우터와 콜백을 배치했습니다.
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF333333),
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
                          ),
                        ),
                        onPressed: () {
                          debugPrint("${widget.studentId} 학점 관리 화면으로 이동합니다.");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectScreen(
                                studentId: widget.studentId,
                                onSave: (totalAll, creditDetails) {
                                  setState(() {
                                    _totalSubjectCredit = totalAll;
                                    debugPrint("대시보드로 전달받은 총 학점: $totalAll");
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(Icons.menu_book_rounded, size: 38, color: Color(0xFF005BAA)),
                            SizedBox(height: 8),
                            Text("[학점 관리]", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // 💡 해결 포인트 3: 뒤섞여 있던 [비교과 요건] 버튼 이벤트를 원래 위치로 복원했습니다.
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF333333),
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
                          ),
                        ),
                        onPressed: () {
                          debugPrint("비교과 요건 화면으로 이동합니다.");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NonSubjectScreen(
                                initialGender: _genderEducation,
                                initialFirstAid: _firstAid,
                                initialAptitude: _aptitudeTest,
                                initialGraduation: _isGraduationProjectDone,
                                initialHistory: _isHistoryLicenseDone,
                                onStateChanged: (gender, firstAid, aptitude, grad, history) {
                                  setState(() {
                                    _genderEducation = gender;
                                    _firstAid = firstAid;
                                    _aptitudeTest = aptitude;
                                    _isGraduationProjectDone = grad;
                                    _isHistoryLicenseDone = history;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(Icons.favorite_rounded, size: 38, color: Color(0xFF2B72B5)),
                            SizedBox(height: 8),
                            Text("[비교과 요건]", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
