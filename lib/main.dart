import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const DDayCalculatorApp());
}

class DDayCalculatorApp extends StatelessWidget {
  const DDayCalculatorApp({super.key});

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
      home: const DDayCalculatorPage(),
    );
  }
}

class DDayCalculatorPage extends StatefulWidget {
  const DDayCalculatorPage({super.key});

  @override
  State<DDayCalculatorPage> createState() => _DDayCalculatorPageState();
}

class _DDayCalculatorPageState extends State<DDayCalculatorPage> {
  DateTime? selectedDate;
  final TextEditingController _titleController = TextEditingController();
  final List<DDayEvent> _events = [];

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

  String _formatDate(DateTime date) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'D-DAY CALCULATOR',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'HYHeadlineM',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 2,
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
                    const Text(
                      'Add New D-Day',
                      style: TextStyle(
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
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
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
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month),
                              const SizedBox(width: 120),
                              Text(
                                selectedDate != null
                                    ? DateFormat(
                                        'MM/dd/yyyy',
                                      ).format(selectedDate!)
                                    : 'Select Date',
                                style: TextStyle(
                                  color: selectedDate != null
                                      ? Colors.black
                                      : Colors.grey,
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
                        label: const Text('Create'),
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
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_note, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Add a D-Day event!',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : CustomScrollView(
                      slivers: _events.asMap().entries.expand((entry) {
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
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: isToday
                                        ? Colors.orange
                                        : isPast
                                        ? Colors.red
                                        : Colors.green,
                                    child: Icon(
                                      isToday
                                          ? Icons.today
                                          : isPast
                                          ? Icons.event_busy
                                          : Icons.event_available,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    event.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(_formatDate(event.targetDate)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isToday
                                              ? Colors.orange
                                              : isPast
                                              ? Colors.red
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
                                      const SizedBox(width: 8),
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
                                  const Text(
                                    'Anniversaries',
                                    style: TextStyle(
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
                                          bottom: 8,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
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
                                                ? Colors.red
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
                                                        ? Colors.red[700]
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
                                                    ? Colors.red[100]
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
                                                      ? Colors.red[700]
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
