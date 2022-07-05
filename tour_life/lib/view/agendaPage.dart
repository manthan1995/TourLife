import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:tour_life/constant/strings.dart';

import '../constant/lists.dart';
import '../widget/commanHeader.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

enum RadioItem {
  everybody,
  harryParslow,
  adamBastin,
  aleshaHickmans,
  alexMcArthur,
  holtHarmon,
  johnSchuster,
  jordanVogel,
  masonRippel,
  nathanielStiener,
  parkerCohen,
  tylerRittenhouse,
  willBurton
}

class _AgendaPageState extends State<AgendaPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String dropdownvalue = 'Alesha Hickmans';
  RadioItem _radioItem = RadioItem.everybody;

  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colorses.black,
        height: size.height,
        child: buildMainView(size: size),
      ),
    );
  }

  Widget buildMainView({Size? size}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          height: size!.height * 0.11,
          alignment: Alignment.bottomCenter,
          child: Text(
            Strings.agendaStr,
            style: TextStyle(
              color: Colorses.white,
              fontSize: 20,
              fontFamily: 'Inter-Bold',
            ),
          ),
        ),
        buildDropDownList(),
        buildCalendar(),
        buildList(size: size),
      ],
    );
  }

  Widget buildDropDownList() {
    bool valuefirst = false;

    return DropdownButton2(
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      scrollbarRadius: const Radius.circular(40),
      alignment: Alignment.bottomCenter,
      value: dropdownvalue,
      icon: Icon(
        Icons.arrow_drop_down_rounded,
        color: Colorses.red,
      ),
      selectedItemBuilder: (BuildContext context) {
        //<-- SEE HERE
        return Lists.dropdownItems.map((String value) {
          return Text(
            dropdownvalue,
            style: TextStyle(
                color: Colorses.white, fontFamily: 'Inter-Light', fontSize: 25),
          );
        }).toList();
      },
      items: Lists.dropdownItems.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: ListTile(
            title: Text(
              items,
              style: TextStyle(
                  color: Colorses.black,
                  fontFamily: 'Inter-Medium',
                  fontSize: 20),
            ),
            trailing: Radio(
              value: valuefirst,
              groupValue: valuefirst,
              onChanged: (bool? value) {
                setState(() {
                  valuefirst = value!;
                });
              },
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }

  Widget buildCalendar() {
    return TableCalendar(
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
        headerPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        formatButtonVisible: false,
      ),
      calendarStyle: CalendarStyle(
          weekendTextStyle: TextStyle(color: Colorses.white),
          defaultTextStyle: TextStyle(color: Colorses.white),
          todayDecoration:
              BoxDecoration(color: Colorses.red, shape: BoxShape.circle)),
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
    );
  }

  Widget buildList({Size? size}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: size!.height * 0.02),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
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
              SizedBox(
                height: 20,
              ),
              buildListItem(size: size),
              SizedBox(
                height: 20,
              ),
              buildListItem(size: size),
              SizedBox(
                height: 20,
              ),
              buildListItem(size: size),
              SizedBox(
                height: 20,
              ),
              buildListItem(size: size),
              SizedBox(
                height: 20,
              ),
              buildListItem(size: size),
              SizedBox(
                height: 20,
              ),
              buildListItem(size: size),
              SizedBox(
                height: 20,
              ),
              buildListItem(size: size),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItem({Size? size}) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colorses.red,
      ),
      width: size!.width * 0.9,
      height: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                color: Colorses.black,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                Strings.videoProgrammingStr,
                style: TextStyle(
                    color: Colorses.white,
                    fontFamily: 'Inter-Medium',
                    fontSize: 15),
              )),
          Text(
            Strings.timeStr2,
            style: TextStyle(
                color: Colorses.white,
                fontFamily: 'Inter-Regular',
                fontSize: 12),
          ),
          Text(
            Strings.arenaStr,
            style: TextStyle(
                color: Colorses.white,
                fontFamily: 'Inter-Medium',
                fontSize: 17),
          )
        ],
      ),
    );
  }
}
