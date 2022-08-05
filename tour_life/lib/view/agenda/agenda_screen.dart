import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:tour_life/constant/images.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/view/agenda/utils/utils.dart';
import 'package:tour_life/model/all_data_model.dart';
import '../../constant/date_time.dart';
import '../../constant/preferences_key.dart';
import '../../model/auth_model/login_model.dart';
import '../gig_screen/schedules/car/car_journey.dart';
import '../gig_screen/schedules/flight/flight_journey_screen.dart';
import '../gig_screen/schedules/set_time/set_time_screen.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;
  late LoginModel loginData;
  late AllDataModel prefData;
  List<Schedule>? scheduleList = [];
  List<Users> alluserList = [];
  List<String> userFirstName = [];
  List<String> name = [];
  List finaldatelist = [];
  List datelist = [];
  List<Schedule> allData = [];
  int? _user;
  int? selectedUserId;
  List<Gigs> gigs = [];
  LinkedHashMap<DateTime, List<Event>>? kEvents;

  @override
  void initState() {
    var logindata = preferences.getString(Keys.loginReponse);
    loginData = LoginModel.fromJson(jsonDecode(logindata!));

    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));
    scheduleList = prefData.result!.schedule;

//dropdownlist
    for (int i = 0; i < prefData.result!.users!.length; i++) {
      alluserList.add(prefData.result!.users![i]);
      userFirstName.add(prefData.result!.users![i].firstName!);
    }

// calender date list
    getDateforList();
    getdateAndTime();
    _selectedDay = _focusedDay;
    getScheduleList();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    super.initState();
  }

  getScheduleList() {
    allData.clear();
    gigs.clear();
    if (loginData.result!.isManager!) {
      if (preferences.getBool(Keys.ismanagerValue) == null ||
          preferences.getBool(Keys.ismanagerValue)!) {
        for (int i = 0; i < prefData.result!.schedule!.length; i++) {
          if (DateFormat("yyyy-MM-dd")
                  .format(DateTime.parse(_selectedDay.toString())) ==
              DateFormat("yyyy-MM-dd").format(
                  DateTime.parse(prefData.result!.schedule![i].departTime!))) {
            allData.add(prefData.result!.schedule![i]);
          }
        }
      } else {
        for (int i = 0; i < prefData.result!.schedule!.length; i++) {
          if (preferences
              .getString(Keys.dropDownValue)!
              .contains(prefData.result!.schedule![i].user.toString())) {
            if (DateFormat("yyyy-MM-dd")
                    .format(DateTime.parse(_selectedDay.toString())) ==
                DateFormat("yyyy-MM-dd").format(DateTime.parse(
                    prefData.result!.schedule![i].departTime!))) {
              allData.add(prefData.result!.schedule![i]);
            }
          }
        }
      }
    } else {
      for (int i = 0; i < prefData.result!.schedule!.length; i++) {
        if (loginData.result!.id
            .toString()
            .contains(prefData.result!.schedule![i].user.toString())) {
          if (DateFormat("yyyy-MM-dd")
                  .format(DateTime.parse(_selectedDay.toString())) ==
              DateFormat("yyyy-MM-dd").format(
                  DateTime.parse(prefData.result!.schedule![i].departTime!))) {
            allData.add(prefData.result!.schedule![i]);
          }
        }
      }
    }

    for (int i = 0; i < allData.length; i++) {
      for (int j = 0; j < prefData.result!.users!.length; j++) {
        if (allData[i].user == prefData.result!.users![j].id) {
          name.add(prefData.result!.users![j].firstName!);
        }
      }
    }
    for (int i = 0; i < allData.length; i++) {
      for (int j = 0; j < prefData.result!.gigs!.length; j++) {
        if (allData[i].gig == prefData.result!.gigs![j].id &&
            allData[i].user == prefData.result!.gigs![j].user) {
          gigs.add(prefData.result!.gigs![j]);
        }
      }
    }
  }

  getDateforList() {
    datelist.clear();
    if (loginData.result!.isManager!) {
      if (preferences.getBool(Keys.ismanagerValue) == null ||
          preferences.getBool(Keys.ismanagerValue)!) {
        for (int i = 0; i < scheduleList!.length; i++) {
          datelist.add(DateFormat("yyyy-MM-dd")
              .format(DateTime.parse(scheduleList![i].departTime!)));
        }
      } else {
        for (int i = 0; i < scheduleList!.length; i++) {
          if (preferences
              .getString(Keys.dropDownValue)!
              .contains(scheduleList![i].user.toString())) {
            datelist.add(DateFormat("yyyy-MM-dd")
                .format(DateTime.parse(scheduleList![i].departTime!)));
          }
        }
      }
    } else {
      for (int i = 0; i < scheduleList!.length; i++) {
        if (loginData.result!.id
            .toString()
            .contains(scheduleList![i].user.toString())) {
          datelist.add(DateFormat("yyyy-MM-dd")
              .format(DateTime.parse(scheduleList![i].departTime!)));
        }
      }
    }
    finaldatelist.clear();
    finaldatelist = datelist.toSet().toList();
  }

  getdateAndTime() {
    final kEventSource = {
      for (var item in List.generate(finaldatelist.length, (index) => index))
        DateTime.parse(finaldatelist[item]): List.generate(scheduleList!.length,
            (index) => Event('Event $item | ${index + 1}'))
    };

    int getHashCode(DateTime key) {
      return key.day * 1000000 + key.month * 10000 + key.year;
    }

    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(kEventSource);
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents![day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        getScheduleList();
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colorses.white,
                        fontSize: 15,
                        fontFamily: 'Inter-Medium',
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      loginData.result!.firstName!,
                      style: TextStyle(
                        color: Colorses.red,
                        fontSize: 18,
                        fontFamily: 'Inter-Bold',
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
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
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                height: size.height * 0.11,
                alignment: Alignment.bottomCenter,
                child: Text(
                  "                ",
                  style: TextStyle(
                    color: Colorses.white,
                    fontSize: 20,
                    fontFamily: 'Inter-Bold',
                  ),
                ),
              ),
            ],
          ),
        ),
        loginData.result!.isManager!
            ? Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: buildDropDownList())
            : const SizedBox(),
        buildCalendar(),
        buildList(size: size),
      ],
    );
  }

  Widget buildDropDownList() {
    String valuefirst;

    return DropdownButton2(
      isExpanded: true,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      scrollbarRadius: const Radius.circular(40),
      alignment: Alignment.bottomCenter,
      value: preferences.getInt(Keys.userValue) == null
          ? userFirstName[0]
          : userFirstName[preferences.getInt(Keys.userValue)!],
      icon: Icon(
        Icons.arrow_drop_down_rounded,
        color: Colorses.red,
      ),
      selectedItemBuilder: (BuildContext context) {
        //<-- SEE HERE
        return userFirstName.map((String value) {
          return Text(
            value,
            style: TextStyle(
                color: Colorses.white, fontFamily: 'Inter-Light', fontSize: 25),
          );
        }).toList();
      },
      items: userFirstName.map((String items) {
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
              value: items,
              groupValue: preferences.getInt(Keys.userValue) == null
                  ? userFirstName[0]
                  : userFirstName[preferences.getInt(Keys.userValue)!],
              onChanged: (String? value) {
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
          _user = userFirstName.indexOf(newValue!);
          selectedUserId = int.parse(alluserList[_user!].id!.toString());

          preferences.setString(Keys.dropDownValue, selectedUserId!.toString());
          preferences.setInt(Keys.userValue, _user!);

          preferences.setBool(Keys.ismanagerValue,
              alluserList[preferences.getInt(Keys.userValue)!].isManager!);

          _selectedDay = _focusedDay;
          getScheduleList();
          getDateforList();
          getdateAndTime();
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
      eventLoader: _getEventsForDay,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colorses.white),
        weekendStyle: TextStyle(color: Colorses.white),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (BuildContext context, date, events) {
          if (events.isEmpty) return const SizedBox();
          return Container(
            margin: const EdgeInsets.only(top: 25),
            padding: const EdgeInsets.all(1),
            child: Container(
              width: 8,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colorses.red),
            ),
          );
        },
      ),
      headerStyle: HeaderStyle(
        titleCentered: true,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: TextStyle(color: Colorses.red),
        headerPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        formatButtonVisible: false,
      ),
      calendarStyle: CalendarStyle(
          weekendTextStyle: TextStyle(color: Colorses.white),
          defaultTextStyle: TextStyle(color: Colorses.white),
          selectedDecoration:
              BoxDecoration(color: Colorses.grey, shape: BoxShape.circle),
          todayDecoration:
              BoxDecoration(color: Colorses.red, shape: BoxShape.circle)),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: _onDaySelected,
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
          color: Colorses.red,
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
        child: ValueListenableBuilder<List<Event>>(
          valueListenable: _selectedEvents,
          builder: (context, value, _) {
            return ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                return allData.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildListItem(size: size, index: index),
                      )
                    : const SizedBox();
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildListItem({Size? size, required int index}) {
    return InkWell(
      onTap: () async {
        if (allData[index].type.toString().contains("flight")) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FlightJourneyPage(
                      id: index,
                      flightDataList: allData,
                      userName: name[index],
                      date: getOnlyDate(dates: gigs[index].startDate!),
                      month: getOnlyMonth(dates: gigs[index].startDate!),
                      location: gigs[index].location!,
                      profilePic: gigs[index].profilePic!,
                      coverPic: gigs[index].coverImage!,
                    )),
          );
        } else if (allData[index].type.toString().contains("cab")) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CarJourney(
                      id: index,
                      carDataList: allData,
                      userName: name[index],
                      date: getOnlyDate(dates: gigs[index].startDate!),
                      month: getOnlyMonth(dates: gigs[index].startDate!),
                      location: gigs[index].location!,
                      profilePic: gigs[index].profilePic!,
                      coverPic: gigs[index].coverImage!,
                    )),
          );
        } else if (allData[index].type.toString().contains("settime")) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SetTimeScreen(
                      id: index,
                      setTimeDataList: allData,
                      userName: name[index],
                      date: getOnlyDate(dates: gigs[index].startDate!),
                      month: getOnlyMonth(dates: gigs[index].startDate!),
                      location: gigs[index].location!,
                      profilePic: gigs[index].profilePic!,
                      coverPic: gigs[index].coverImage!,
                    )),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          color: Colorses.white,
        ),
        width: size!.width * 0.9,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            allData[index].type.toString().contains("flight")
                ? SvgPicture.asset(
                    Images.planeImage,
                  )
                : allData[index].type.toString().contains("cab")
                    ? SvgPicture.asset(
                        Images.carImage,
                      )
                    : SvgPicture.asset(
                        Images.settimeIconImage,
                      ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "${getTime(times: allData[index].departTime)}",
                      style: TextStyle(
                        color: Colorses.grey,
                        fontSize: 15,
                        fontFamily: 'Inter-SemiBold',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: allData[index]
                                    .type
                                    .toString()
                                    .contains("settime")
                                ? " - Set Time"
                                : allData[index]
                                        .type
                                        .toString()
                                        .contains("flight")
                                    ? " - Flight"
                                    : " - Car",
                            style: TextStyle(color: Colorses.red)),
                        TextSpan(
                            text: allData[index].type.toString().contains("cab")
                                ? " from"
                                : allData[index]
                                        .type
                                        .toString()
                                        .contains("flight")
                                    ? " from"
                                    : "",
                            style: TextStyle(color: Colorses.grey)),
                        TextSpan(
                            text: allData[index]
                                    .type
                                    .toString()
                                    .contains("settime")
                                ? ""
                                : allData[index]
                                        .type
                                        .toString()
                                        .contains("flight")
                                    ? " ${allData[index].departLocation}"
                                    : " ${allData[index].departLocation}",
                            style: TextStyle(color: Colorses.red)),
                        TextSpan(
                            text: allData[index]
                                    .type
                                    .toString()
                                    .contains("settime")
                                ? ""
                                : allData[index]
                                        .type
                                        .toString()
                                        .contains("flight")
                                    ? " to"
                                    : " to",
                            style: TextStyle(color: Colorses.grey)),
                        TextSpan(
                            text: allData[index]
                                    .type
                                    .toString()
                                    .contains("settime")
                                ? ""
                                : allData[index]
                                        .type
                                        .toString()
                                        .contains("flight")
                                    ? " ${allData[index].arrivalLocation}"
                                    : " ${allData[index].arrivalLocation}",
                            style: TextStyle(color: Colorses.red)),
                      ],
                    ),
                  ),
                  Text(
                    name[index],
                    style: TextStyle(
                      color: Colorses.black,
                      fontSize: 17,
                      fontFamily: 'Inter-Medium',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
