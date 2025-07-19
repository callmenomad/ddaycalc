import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const DDayCalculatorApp());
}

class DDayCalculatorApp extends StatefulWidget {
  const DDayCalculatorApp({super.key});

  @override
  State<DDayCalculatorApp> createState() => _DDayCalculatorAppState();
}

class _DDayCalculatorAppState extends State<DDayCalculatorApp> {
  String _currentLanguage = 'English';

  void _changeLanguage(String language) {
    setState(() {
      _currentLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'D-Day Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: DDayCalculatorPage(
        onLanguageChanged: _changeLanguage,
        currentLanguage: _currentLanguage,
      ),
    );
  }
}

class DDayCalculatorPage extends StatefulWidget {
  final Function(String) onLanguageChanged;
  final String currentLanguage;

  const DDayCalculatorPage({
    super.key,
    required this.onLanguageChanged,
    required this.currentLanguage,
  });

  @override
  State<DDayCalculatorPage> createState() => _DDayCalculatorPageState();
}

class _DDayCalculatorPageState extends State<DDayCalculatorPage> {
  DateTime? selectedDate;
  final TextEditingController _titleController = TextEditingController();
  final List<DDayEvent> _events = [];

  final Map<String, Locale> _languages = {
    'English': const Locale('en'),
    '한국어': const Locale('ko'),
    '日本語': const Locale('ja'),
    '中文': const Locale('zh'),
    'Español': const Locale('es'),
    'Português': const Locale('pt'),
    'Français': const Locale('fr'),
    'Tiếng Việt': const Locale('vi'),
    'ไทย': const Locale('th'),
    'Tagalog': const Locale('tl'),
    'Bahasa Indonesia': const Locale('id'),
  };

  final Map<String, Map<String, String>> _translations = {
    'English': {
      'appTitle': 'D-DAY CALCULATOR',
      'addNewDday': 'Add New D-Day',
      'title': 'Title',
      'selectDate': 'Select Date',
      'create': 'Create',
      'addDdayEvent': 'Add a D-Day event!',
      'anniversaries': 'Anniversaries',
      'delete': 'Delete',
    },
    '한국어': {
      'appTitle': '디데이 계산기',
      'addNewDday': '새 디데이 추가',
      'title': '제목',
      'selectDate': '날짜 선택',
      'create': '생성',
      'addDdayEvent': '디데이를 추가해보세요!',
      'anniversaries': '기념일',
      'delete': '삭제',
    },
    '日本語': {
      'appTitle': 'D-DAY計算機',
      'addNewDday': '新しいD-DAYを追加',
      'title': 'タイトル',
      'selectDate': '日付を選択',
      'create': '作成',
      'addDdayEvent': 'D-DAYイベントを追加してください！',
      'anniversaries': '記念日',
      'delete': '削除',
    },
    '中文': {
      'appTitle': 'D日计算器',
      'addNewDday': '添加新的D日',
      'title': '标题',
      'selectDate': '选择日期',
      'create': '创建',
      'addDdayEvent': '添加一个D日事件！',
      'anniversaries': '纪念日',
      'delete': '删除',
    },
    'Español': {
      'appTitle': 'CALCULADORA D-DAY',
      'addNewDday': 'Agregar Nuevo D-Day',
      'title': 'Título',
      'selectDate': 'Seleccionar Fecha',
      'create': 'Crear',
      'addDdayEvent': '¡Agrega un evento D-Day!',
      'anniversaries': 'Aniversarios',
      'delete': 'Eliminar',
    },
    'Português': {
      'appTitle': 'CALCULADORA D-DAY',
      'addNewDday': 'Adicionar Novo D-Day',
      'title': 'Título',
      'selectDate': 'Selecionar Data',
      'create': 'Criar',
      'addDdayEvent': 'Adicione um evento D-Day!',
      'anniversaries': 'Aniversários',
      'delete': 'Excluir',
    },
    'Français': {
      'appTitle': 'CALCULATRICE D-DAY',
      'addNewDday': 'Ajouter un Nouveau D-Day',
      'title': 'Titre',
      'selectDate': 'Sélectionner la Date',
      'create': 'Créer',
      'addDdayEvent': 'Ajoutez un événement D-Day !',
      'anniversaries': 'Anniversaires',
      'delete': 'Supprimer',
    },
    'Tiếng Việt': {
      'appTitle': 'MÁY TÍNH D-DAY',
      'addNewDday': 'Thêm D-Day Mới',
      'title': 'Tiêu đề',
      'selectDate': 'Chọn Ngày',
      'create': 'Tạo',
      'addDdayEvent': 'Thêm một sự kiện D-Day!',
      'anniversaries': 'Kỷ niệm',
      'delete': 'Xóa',
    },
    'ไทย': {
      'appTitle': 'เครื่องคำนวณ D-DAY',
      'addNewDday': 'เพิ่ม D-Day ใหม่',
      'title': 'หัวข้อ',
      'selectDate': 'เลือกวันที่',
      'create': 'สร้าง',
      'addDdayEvent': 'เพิ่มเหตุการณ์ D-Day!',
      'anniversaries': 'วันครบรอบ',
      'delete': 'ลบ',
    },
    'Tagalog': {
      'appTitle': 'D-DAY CALCULATOR',
      'addNewDday': 'Magdagdag ng Bagong D-Day',
      'title': 'Pamagat',
      'selectDate': 'Pumili ng Petsa',
      'create': 'Gumawa',
      'addDdayEvent': 'Magdagdag ng D-Day event!',
      'anniversaries': 'Mga Anibersaryo',
      'delete': 'Tanggalin',
    },
    'Bahasa Indonesia': {
      'appTitle': 'KALKULATOR D-DAY',
      'addNewDday': 'Tambah D-Day Baru',
      'title': 'Judul',
      'selectDate': 'Pilih Tanggal',
      'create': 'Buat',
      'addDdayEvent': 'Tambahkan acara D-Day!',
      'anniversaries': 'Hari Jadi',
      'delete': 'Hapus',
    },
  };

  // Language-specific date formats
  final Map<String, Map<String, dynamic>> _dateFormats = {
    'English': {
      'weekdays': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      'months': [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ],
      'format': 'MM/dd/yyyy',
    },
    '한국어': {
      'weekdays': ['월', '화', '수', '목', '금', '토', '일'],
      'months': [
        '1월',
        '2월',
        '3월',
        '4월',
        '5월',
        '6월',
        '7월',
        '8월',
        '9월',
        '10월',
        '11월',
        '12월',
      ],
      'format': 'yyyy. M. d.',
    },
    '日本語': {
      'weekdays': ['月', '火', '水', '木', '金', '土', '日'],
      'months': [
        '1月',
        '2月',
        '3月',
        '4月',
        '5月',
        '6月',
        '7月',
        '8月',
        '9月',
        '10月',
        '11月',
        '12月',
      ],
      'format': 'yyyy年M月d日',
    },
    '中文': {
      'weekdays': ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
      'months': [
        '1月',
        '2月',
        '3月',
        '4月',
        '5月',
        '6月',
        '7月',
        '8月',
        '9月',
        '10月',
        '11月',
        '12月',
      ],
      'format': 'yyyy年M月d日',
    },
    'Español': {
      'weekdays': ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
      'months': [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre',
      ],
      'format': 'dd/MM/yyyy',
    },
    'Português': {
      'weekdays': ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
      'months': [
        'Janeiro',
        'Fevereiro',
        'Março',
        'Abril',
        'Maio',
        'Junho',
        'Julho',
        'Agosto',
        'Setembro',
        'Outubro',
        'Novembro',
        'Dezembro',
      ],
      'format': 'dd/MM/yyyy',
    },
    'Français': {
      'weekdays': ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
      'months': [
        'Janvier',
        'Février',
        'Mars',
        'Avril',
        'Mai',
        'Juin',
        'Juillet',
        'Août',
        'Septembre',
        'Octobre',
        'Novembre',
        'Décembre',
      ],
      'format': 'dd/MM/yyyy',
    },
    'Tiếng Việt': {
      'weekdays': ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
      'months': [
        'Tháng 1',
        'Tháng 2',
        'Tháng 3',
        'Tháng 4',
        'Tháng 5',
        'Tháng 6',
        'Tháng 7',
        'Tháng 8',
        'Tháng 9',
        'Tháng 10',
        'Tháng 11',
        'Tháng 12',
      ],
      'format': 'dd/MM/yyyy',
    },
    'ไทย': {
      'weekdays': ['จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.', 'อา.'],
      'months': [
        'มกราคม',
        'กุมภาพันธ์',
        'มีนาคม',
        'เมษายน',
        'พฤษภาคม',
        'มิถุนายน',
        'กรกฎาคม',
        'สิงหาคม',
        'กันยายน',
        'ตุลาคม',
        'พฤศจิกายน',
        'ธันวาคม',
      ],
      'format': 'd MMMM yyyy',
    },
    'Tagalog': {
      'weekdays': ['Lun', 'Mar', 'Miy', 'Huw', 'Biy', 'Sab', 'Ling'],
      'months': [
        'Enero',
        'Pebrero',
        'Marso',
        'Abril',
        'Mayo',
        'Hunyo',
        'Hulyo',
        'Agosto',
        'Setyembre',
        'Oktubre',
        'Nobyembre',
        'Disyembre',
      ],
      'format': 'MM/dd/yyyy',
    },
    'Bahasa Indonesia': {
      'weekdays': ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
      'months': [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember',
      ],
      'format': 'dd/MM/yyyy',
    },
  };

  String _t(String key) {
    return _translations[widget.currentLanguage]?[key] ?? key;
  }

  String _formatDate(DateTime date) {
    final dateFormat = _dateFormats[widget.currentLanguage];
    if (dateFormat == null) {
      // Fallback to English format
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      final weekday = weekdays[date.weekday - 1];
      final month = months[date.month - 1];
      return '$month ${date.day}, ${date.year} ($weekday)';
    }

    final weekdays = dateFormat['weekdays'] as List<String>;
    final months = dateFormat['months'] as List<String>;
    final format = dateFormat['format'] as String;

    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];

    // Custom formatting based on language
    switch (widget.currentLanguage) {
      case '한국어':
        return '${date.year}. ${date.month}. ${date.day}.($weekday)';
      case '日本語':
        return '${date.year}年${date.month}月${date.day}日($weekday)';
      case '中文':
        return '${date.year}年${date.month}月${date.day}日($weekday)';
      case 'Español':
        return '${date.day} de $month de ${date.year} ($weekday)';
      case 'Português':
        return '${date.day} de $month de ${date.year} ($weekday)';
      case 'Français':
        return '${date.day} $month ${date.year} ($weekday)';
      case 'Tiếng Việt':
        return '${date.day}/${date.month}/${date.year} ($weekday)';
      case 'ไทย':
        return '${date.day} $month ${date.year} ($weekday)';
      case 'Tagalog':
        return '${date.month}/${date.day}/${date.year} ($weekday)';
      case 'Bahasa Indonesia':
        return '${date.day} $month ${date.year} ($weekday)';
      default:
        return '$month ${date.day}, ${date.year} ($weekday)';
    }
  }

  String _getDateFormat() {
    final dateFormat = _dateFormats[widget.currentLanguage];
    return dateFormat?['format'] as String? ?? 'MM/dd/yyyy';
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = 'D-Day';
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _addEvent() {
    if (selectedDate != null && _titleController.text.isNotEmpty) {
      setState(() {
        _events.add(
          DDayEvent(title: _titleController.text, targetDate: selectedDate!),
        );
        _titleController.text = 'D-Day';
        selectedDate = null;
      });
    }
  }

  void _removeEvent(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }

  List<AnniversaryEvent> _generateAnniversaries(DateTime baseDate) {
    final List<AnniversaryEvent> anniversaries = [];

    // D+100, 200, 300
    for (int days in [100, 200, 300]) {
      anniversaries.add(
        AnniversaryEvent(
          title: 'D+$days',
          targetDate: baseDate.add(Duration(days: days)),
          type: AnniversaryType.days,
          value: days,
        ),
      );
    }

    // 1st Anniversary to 10th Anniversary
    for (int years in List.generate(10, (index) => index + 1)) {
      String suffix;
      if (years == 1) {
        suffix = 'st';
      } else if (years == 2) {
        suffix = 'nd';
      } else if (years == 3) {
        suffix = 'rd';
      } else {
        suffix = 'th';
      }

      anniversaries.add(
        AnniversaryEvent(
          title: '${years}$suffix Anniversary',
          targetDate: DateTime(
            baseDate.year + years,
            baseDate.month,
            baseDate.day,
          ),
          type: AnniversaryType.years,
          value: years,
        ),
      );
    }

    // Ascending order (closest date first)
    anniversaries.sort((a, b) => a.targetDate.compareTo(b.targetDate));

    return anniversaries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _t('appTitle'),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'HYHeadlineM',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: (String language) {
              widget.onLanguageChanged(language);
            },
            itemBuilder: (BuildContext context) {
              return _languages.keys.map((String language) {
                return PopupMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Form
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _t('addNewDday'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: _titleController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: _t('title'),
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Stack(
                            children: [
                              // Calendar icon positioned on the left
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: const Icon(Icons.calendar_month),
                              ),
                              // Text centered in the container
                              Center(
                                child: Text(
                                  selectedDate != null
                                      ? DateFormat(
                                          _getDateFormat(),
                                        ).format(selectedDate!)
                                      : _t('selectDate'),
                                  style: TextStyle(
                                    color: selectedDate != null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton.icon(
                        onPressed: _addEvent,
                        icon: const Icon(Icons.add),
                        label: Text(_t('create')),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // D-Day List
            Expanded(
              child: _events.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.event_note,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _t('addDdayEvent'),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : CustomScrollView(
                      slivers: _events
                          .asMap()
                          .entries
                          .expand((entry) {
                        final index = entry.key;
                        final event = entry.value;
                        final days = event.getDaysFromNow();
                        final isPast = days < 0;
                        final isToday = days == 0;

                        // Generate anniversary list
                        final anniversaries = _generateAnniversaries(
                          event.targetDate,
                        );

                        return [
                          // Sticky Header
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverAppBarDelegate(
                              minHeight: 80,
                              maxHeight: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: isToday
                                            ? Colors.orange
                                            : isPast
                                            ? Colors.blue
                                            : Colors.green,
                                        child: Icon(
                                          isToday
                                              ? Icons.today
                                              : Icons.event_available,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              event.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              _formatDate(event.targetDate),
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isToday
                                              ? Colors.orange
                                              : isPast
                                              ? Colors.blue
                                              : Colors.green,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Text(
                                          isToday
                                              ? 'D-DAY'
                                              : isPast
                                              ? 'D+${days.abs()}'
                                              : 'D-${days}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      IconButton(
                                        onPressed: () => _removeEvent(index),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Anniversary Content
                          SliverToBoxAdapter(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: Colors.grey[50]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _t('anniversaries'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Column(
                                    children: anniversaries.map((anniversary) {
                                      final anniversaryDays = anniversary
                                          .getDaysFromNow();
                                      final isAnniversaryPast =
                                          anniversaryDays < 0;
                                      final isAnniversaryToday =
                                          anniversaryDays == 0;

                                      return Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(
                                          bottom: 4,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: isAnniversaryToday
                                                ? Colors.orange
                                                : isAnniversaryPast
                                                ? Colors.blue
                                                : Colors.green,
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                0.2,
                                              ),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  anniversary.title,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                                                                      color: isAnniversaryToday
                                                      ? Colors.orange
                                                      : isAnniversaryPast
                                                      ? Colors.blue[700]
                                                      : Colors.green[700],
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  _formatDate(
                                                    anniversary.targetDate,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: isAnniversaryToday
                                                    ? Colors.orange
                                                    : isAnniversaryPast
                                                    ? Colors.blue[100]
                                                    : Colors.green[100],
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Text(
                                                isAnniversaryToday
                                                    ? "D-DAY"
                                                    : isAnniversaryPast
                                                    ? "D+${anniversaryDays.abs()}"
                                                    : "D-${anniversaryDays}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                                                                  color: isAnniversaryToday
                                                    ? Colors.white
                                                    : isAnniversaryPast
                                                    ? Colors.blue[700]
                                                    : Colors.green[700],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Add minimal spacing between D-Day items
                          SliverToBoxAdapter(
                            child: Container(
                              height: 8,
                              color: Colors.transparent,
                            ),
                          ),
                        ];
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class DDayEvent {
  final String title;
  final DateTime targetDate;

  DDayEvent({required this.title, required this.targetDate});

  int getDaysFromNow() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    return target.difference(today).inDays;
  }
}

enum AnniversaryType { days, years }

class AnniversaryEvent {
  final String title;
  final DateTime targetDate;
  final AnniversaryType type;
  final int value;

  AnniversaryEvent({
    required this.title,
    required this.targetDate,
    required this.type,
    required this.value,
  });

  int getDaysFromNow() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    return target.difference(today).inDays;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
