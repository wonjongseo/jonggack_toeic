// ignore_for_file: constant_identifier_names

class AppConstant {
  // 네이티브 광고 주기
  static const int PER_COUNT_NATIVE_ND = 4;

// 챕터 당 단어 수
  static const int MINIMUM_STEP_COUNT = 10;

// 틀린 문제로 다시 테스트를 본 경우 광고 넘어갈 수 있는 경우의 수
  static const int PROBABILITY_PASS_AD = 3;

  // 자주 틀리는 문제로 유도하는 [모르는 버튼] 누른 숫자 MIN = 15 AND MAX = 10
  // ACTUALLY MIN 15 <= x <= 30
  static const int INDUCE_USUALLY_WRONG_VOCA_PAGE_COUNT_MIN = 15;
  static const int INDUCE_USUALLY_WRONG_VOCA_PAGE_COUNT_MAX = 15;

  static const int HERAT_COUNT_MAX = 30;

// 광고 당 하트 수
  static const int HERAT_COUNT_AD = 3;

// 하트 증가 기본값
  static const int HERAT_COUNT_DEFAULT = 1;

  // 무료 버전이 볼 수 있는 1급 서브챕터 제한 인덱스
  static const int RESTRICT_SUB_STEP_INDEX = 3;
}

double threeWordButtonWidth = 99.36;
