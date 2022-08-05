// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}



/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
// final kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);

// final _kEventSource = Map.fromIterable(List.generate(2, (index) => index),
//     key: (item) => DateTime.parse(dates[item]),
//     value: (item) =>
//         List.generate(5, (index) => Event('Event $item | ${index + 1}')));

// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;

// }
