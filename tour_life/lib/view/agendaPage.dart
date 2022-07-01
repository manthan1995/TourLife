import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tour_life/constant/colorses.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("a"),
      ),
      body: Container(
        color: Colorses.black,
        height: size.height,
        child: Column(
          children: [
            TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colorses.white),
                weekendStyle: TextStyle(color: Colorses.white),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                leftChevronVisible: false,
                rightChevronVisible: false,
                titleTextStyle: TextStyle(color: Colorses.red),
                headerPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                formatButtonVisible: false,
              ),
              calendarStyle: CalendarStyle(
                  weekendTextStyle: TextStyle(color: Colorses.white),
                  defaultTextStyle: TextStyle(color: Colorses.white),
                  todayDecoration: BoxDecoration(
                      color: Colorses.red, shape: BoxShape.circle)),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.02),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colorses.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colorses.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      // shadow direction: bottom right
                    )
                  ],
                ),
                width: size.width,
                height: size.height * 0.15,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          color: Colorses.red,
                        ),
                        width: size.width * 0.9,
                        height: 125,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                  color: Colorses.black,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  "video Programming",
                                  style: TextStyle(
                                      color: Colorses.white,
                                      fontFamily: 'Inter-Medium',
                                      fontSize: 15),
                                )),
                            Text(
                              "05:00 AM 07:00 AM",
                              style: TextStyle(
                                  color: Colorses.white,
                                  fontFamily: 'Inter-Regular',
                                  fontSize: 12),
                            ),
                            Text(
                              "Xzibit at O2 Arena",
                              style: TextStyle(
                                  color: Colorses.white,
                                  fontFamily: 'Inter-Medium',
                                  fontSize: 17),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
