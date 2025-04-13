import 'package:flutter/material.dart';
import '../../../models/schedule_model.dart';
import 'widgets/week_calendar.dart';
import 'widgets/schedule_timeline.dart';
import '../../../core/utils/date_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  List<Schedule> get dummySchedules => [
    // 2024년 3월 11일 (월)
    Schedule(
      dateTime: DateTime(2024, 3, 11, 9, 0),
      title: '주간 미팅',
      description: '팀 주간 목표 설정 및 진행 상황 공유',
    ),
    Schedule(
      dateTime: DateTime(2024, 3, 11, 14, 30),
      title: '클라이언트 미팅',
      description: '신규 프로젝트 요구사항 논의',
    ),
    Schedule(
      dateTime: DateTime(2024, 3, 11, 16, 0),
      title: '코드 리뷰',
      description: '팀원들의 PR 리뷰 및 피드백',
    ),

    // 2024년 3월 12일 (화)
    Schedule(
      dateTime: DateTime(2024, 3, 12, 10, 0),
      title: '디자인 리뷰',
      description: 'UI/UX 디자인 피드백 세션',
    ),
    Schedule(
      dateTime: DateTime(2024, 3, 12, 11, 30),
      title: '기술 세미나',
      description: '새로운 기술 스택 소개 및 실습',
    ),

    // 2024년 3월 13일 (수)
    Schedule(
      dateTime: DateTime(2024, 3, 13, 9, 30),
      title: '스프린트 플래닝',
      description: '다음 스프린트 작업 계획 세우기',
    ),
    Schedule(
      dateTime: DateTime(2024, 3, 13, 13, 0),
      title: 'QA 테스트',
      description: '새로운 기능 QA 테스트 진행',
    ),

    // 2024년 3월 14일 (목)
    Schedule(
      dateTime: DateTime(2024, 3, 14, 9, 0),
      title: '데일리 스크럼',
      description: '팀원들의 일일 진행 상황 공유',
    ),
    Schedule(
      dateTime: DateTime(2024, 3, 14, 11, 0),
      title: '프로토타입 데모',
      description: '클라이언트에게 프로토타입 시연',
    ),
    Schedule(
      dateTime: DateTime(2024, 3, 14, 15, 0),
      title: '기술 세션',
      description: '성능 최적화 기법 공유',
    ),

    // 2024년 3월 15일 (금)
    Schedule(
      dateTime: DateTime(2024, 3, 15, 10, 0),
      title: '주간 회고',
      description: '이번 주 진행 상황 및 개선점 논의',
    ),
    Schedule(
      dateTime: DateTime(2024, 3, 15, 14, 0),
      title: '기술 면접',
      description: '신규 개발자 면접 진행',
    ),

    // 2024년 3월 16일 (토)
    Schedule(
      dateTime: DateTime(2024, 3, 16, 11, 0),
      title: '워크샵',
      description: '팀 빌딩 및 기술 워크샵',
    ),

    // 2024년 3월 17일 (일)
    Schedule(
      dateTime: DateTime(2024, 3, 17, 13, 0),
      title: '개인 프로젝트',
      description: '사이드 프로젝트 개발',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels <= 0) {
      // 스크롤이 맨 위에 도달했을 때 이전 날짜로 변경
      setState(() {
        selectedDate = selectedDate.subtract(const Duration(days: 1));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${selectedDate.year}년 ${selectedDate.month}월',
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: WeekCalendar(
              selectedDate: selectedDate,
              onDateSelected: (date) {
                setState(() => selectedDate = date);
              },
            ),
          ),
          Expanded(
            child: ScheduleTimeline(
              schedules: dummySchedules,
              scrollController: _scrollController,
              currentDate: selectedDate,
            ),
          )
        ],
      ),
    );
  }
}
