class CreditItem {
  final String category;     // 이수 구분 (예: 기초교양, 전공필수)
  final String targetCredit; // 기준/목표 학점 (예: "5", "40 이하", "74")

  CreditItem({required this.category, required this.targetCredit});
}

// 학번별 학점 데이터를 총괄하는 클래스
class CreditData {
  // 학번에 맞는 이수 항목 리스트를 반환하는 함수
  static List<CreditItem> getCreditList(String studentId) {
    if (studentId == '24학번') {
      return [
        CreditItem(category: "기초교양", targetCredit: "5학점"),
        CreditItem(category: "핵심교양", targetCredit: "6학점"),
        CreditItem(category: "공통교양 - 의사소통", targetCredit: "2학점"),
        CreditItem(category: "공통교양 - 인성", targetCredit: "2학점"),
        CreditItem(category: "심화교양", targetCredit: "15~31학점"),
        CreditItem(category: "교직", targetCredit: "22학점"),
        CreditItem(category: "전공 필수", targetCredit: "40학점 이하"),
        CreditItem(category: "전공 이수 최소학점", targetCredit: "74학점"),
      ];
    } else if (studentId == '25학번') {
      return [
        CreditItem(category: "기초교양", targetCredit: "10학점"),
        CreditItem(category: "핵심교양", targetCredit: "12학점"),
        CreditItem(category: "창의 교양", targetCredit: "8학점"),
        CreditItem(category: "교직", targetCredit: "22학점"),
        CreditItem(category: "전공 이수 최소학점", targetCredit: "74학점"),
      ];
    }
    return []; // 기본값 (빈 리스트)
  }

  // 학번에 따른 특이사항/메모를 반환하는 함수
  static String getMemo(String studentId) {
    if (studentId == '24학번') {
      return "💡 창의교양이 핵심교양으로 인정됩니다.";
    } else if (studentId == '25학번') {
      return "💡 25학번 기준 교양 체계가 적용됩니다(현재 25학번, 26학번 동일).";
    }
    return "";
  }
}
