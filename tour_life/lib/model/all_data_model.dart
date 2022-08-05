class AllDataModel {
  int? status;
  bool? error;
  String? message;
  Result? result;

  AllDataModel({this.status, this.error, this.message, this.result});

  AllDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Users>? users;
  List<Gigs>? gigs;
  List<Hotels>? hotels;
  List<Venues>? venues;
  List<Schedule>? schedule;
  List<Contacts>? contacts;
  List<Guestlists>? guestlists;
  List<Documents>? documents;

  Result(
      {this.users,
      this.gigs,
      this.hotels,
      this.venues,
      this.schedule,
      this.contacts,
      this.guestlists,
      this.documents});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    if (json['gigs'] != null) {
      gigs = <Gigs>[];
      json['gigs'].forEach((v) {
        gigs!.add(Gigs.fromJson(v));
      });
    }
    if (json['hotels'] != null) {
      hotels = <Hotels>[];
      json['hotels'].forEach((v) {
        hotels!.add(Hotels.fromJson(v));
      });
    }
    if (json['venues'] != null) {
      venues = <Venues>[];
      json['venues'].forEach((v) {
        venues!.add(Venues.fromJson(v));
      });
    }
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(Schedule.fromJson(v));
      });
    }
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(Contacts.fromJson(v));
      });
    }
    if (json['guestlists'] != null) {
      guestlists = <Guestlists>[];
      json['guestlists'].forEach((v) {
        guestlists!.add(Guestlists.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (gigs != null) {
      data['gigs'] = gigs!.map((v) => v.toJson()).toList();
    }
    if (hotels != null) {
      data['hotels'] = hotels!.map((v) => v.toJson()).toList();
    }
    if (venues != null) {
      data['venues'] = venues!.map((v) => v.toJson()).toList();
    }
    if (schedule != null) {
      data['schedule'] = schedule!.map((v) => v.toJson()).toList();
    }
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    if (guestlists != null) {
      data['guestlists'] = guestlists!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? firstName;
  String? lastName;
  bool? isManager;

  Users({this.id, this.firstName, this.lastName, this.isManager});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isManager = json['is_manager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['is_manager'] = isManager;
    return data;
  }
}

class Gigs {
  int? id;
  String? title;
  String? descriptions;
  String? profilePic;
  String? coverImage;
  String? location;
  String? show;
  String? stage;
  String? visa;
  bool? equipment;
  String? startDate;
  String? endDate;
  String? soundCheckTime;
  int? user;
  int? scheduleCount;
  int? contactCount;
  int? documentCount;

  Gigs(
      {this.id,
      this.title,
      this.descriptions,
      this.profilePic,
      this.coverImage,
      this.location,
      this.show,
      this.stage,
      this.visa,
      this.equipment,
      this.startDate,
      this.endDate,
      this.soundCheckTime,
      this.user,
      this.scheduleCount,
      this.contactCount,
      this.documentCount});

  Gigs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descriptions = json['descriptions'];
    profilePic = json['profile_pic'];
    coverImage = json['cover_image'];
    location = json['location'];
    show = json['show'];
    stage = json['stage'];
    visa = json['visa'];
    equipment = json['Equipment'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    soundCheckTime = json['sound_check_time'];
    user = json['user'];
    scheduleCount = json['schedule_count'];
    contactCount = json['contact_count'];
    documentCount = json['document_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['descriptions'] = descriptions;
    data['profile_pic'] = profilePic;
    data['cover_image'] = coverImage;
    data['location'] = location;
    data['show'] = show;
    data['stage'] = stage;
    data['visa'] = visa;
    data['Equipment'] = equipment;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['sound_check_time'] = soundCheckTime;
    data['user'] = user;
    data['schedule_count'] = scheduleCount;
    data['contact_count'] = contactCount;
    data['document_count'] = documentCount;
    return data;
  }
}

class Hotels {
  int? id;
  int? userId;
  String? userName;
  int? gigId;
  String? gigTitle;
  String? hotelName;
  String? address;
  String? direction;
  String? website;
  String? number;
  bool? wifiPaidFor;
  String? roomBuyout;

  Hotels(
      {this.id,
      this.userId,
      this.userName,
      this.gigId,
      this.gigTitle,
      this.hotelName,
      this.address,
      this.direction,
      this.website,
      this.number,
      this.wifiPaidFor,
      this.roomBuyout});

  Hotels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    gigId = json['gig_id'];
    gigTitle = json['gig_title'];
    hotelName = json['hotel_name'];
    address = json['address'];
    direction = json['direction'];
    website = json['website'];
    number = json['number'];
    wifiPaidFor = json['wifi_paid_for'];
    roomBuyout = json['room_buyout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['gig_id'] = gigId;
    data['gig_title'] = gigTitle;
    data['hotel_name'] = hotelName;
    data['address'] = address;
    data['direction'] = direction;
    data['website'] = website;
    data['number'] = number;
    data['wifi_paid_for'] = wifiPaidFor;
    data['room_buyout'] = roomBuyout;
    return data;
  }
}

class Venues {
  int? id;
  int? userId;
  String? userName;
  int? gigId;
  String? gigTitle;
  String? venueName;
  String? address;
  String? direction;
  String? website;
  String? number;
  bool? indoor;
  bool? covered;
  int? capacity;
  String? wather;
  String? credentialCollection;
  String? dressingRoom;
  bool? hospitality;
  String? hospitalityDetail;
  String? hospitalityEmail;
  bool? catring;
  String? catringDetail;

  Venues(
      {this.id,
      this.userId,
      this.userName,
      this.gigId,
      this.gigTitle,
      this.venueName,
      this.address,
      this.direction,
      this.website,
      this.number,
      this.indoor,
      this.covered,
      this.capacity,
      this.wather,
      this.credentialCollection,
      this.dressingRoom,
      this.hospitality,
      this.hospitalityDetail,
      this.hospitalityEmail,
      this.catring,
      this.catringDetail});

  Venues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    gigId = json['gig_id'];
    gigTitle = json['gig_title'];
    venueName = json['venue_name'];
    address = json['address'];
    direction = json['direction'];
    website = json['website'];
    number = json['number'];
    indoor = json['indoor'];
    covered = json['covered'];
    capacity = json['capacity'];
    wather = json['wather'];
    credentialCollection = json['credential_collection'];
    dressingRoom = json['dressing_room'];
    hospitality = json['hospitality'];
    hospitalityDetail = json['hospitality_detail'];
    hospitalityEmail = json['hospitality_email'];
    catring = json['catring'];
    catringDetail = json['catring_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['gig_id'] = gigId;
    data['gig_title'] = gigTitle;
    data['venue_name'] = venueName;
    data['address'] = address;
    data['direction'] = direction;
    data['website'] = website;
    data['number'] = number;
    data['indoor'] = indoor;
    data['covered'] = covered;
    data['capacity'] = capacity;
    data['wather'] = wather;
    data['credential_collection'] = credentialCollection;
    data['dressing_room'] = dressingRoom;
    data['hospitality'] = hospitality;
    data['hospitality_detail'] = hospitalityDetail;
    data['hospitality_email'] = hospitalityEmail;
    data['catring'] = catring;
    data['catring_detail'] = catringDetail;
    return data;
  }
}

class Schedule {
  String? type;
  int? flightId;
  String? departLocation;
  String? departLatLong;
  String? departTime;
  String? departTerminal;
  String? departGate;
  String? arrivalLocation;
  String? arrivalLatLong;
  String? arrivalTime;
  String? arrivalTerminal;
  String? arrivalGate;
  String? airlines;
  String? flightNumber;
  String? flightClass;
  String? wather;
  int? user;
  int? gig;
  int? cabId;
  String? driverName;
  String? driverNumber;
  int? settimeId;
  String? venue;

  Schedule(
      {this.type,
      this.flightId,
      this.departLocation,
      this.departLatLong,
      this.departTime,
      this.departTerminal,
      this.departGate,
      this.arrivalLocation,
      this.arrivalLatLong,
      this.arrivalTime,
      this.arrivalTerminal,
      this.arrivalGate,
      this.airlines,
      this.flightNumber,
      this.flightClass,
      this.wather,
      this.user,
      this.gig,
      this.cabId,
      this.driverName,
      this.driverNumber,
      this.settimeId,
      this.venue});

  Schedule.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    flightId = json['flight_id'];
    departLocation = json['depart_location'];
    departLatLong = json['depart_lat_long'];
    departTime = json['depart_time'];
    departTerminal = json['depart_terminal'];
    departGate = json['depart_gate'];
    arrivalLocation = json['arrival_location'];
    arrivalLatLong = json['arrival_lat_long'];
    arrivalTime = json['arrival_time'];
    arrivalTerminal = json['arrival_terminal'];
    arrivalGate = json['arrival_gate'];
    airlines = json['airlines'];
    flightNumber = json['flight_number'];
    flightClass = json['flight_class'];
    wather = json['wather'];
    user = json['user'];
    gig = json['gig'];
    cabId = json['cab_id'];
    driverName = json['driver_name'];
    driverNumber = json['driver_number'];
    settimeId = json['settime_id'];
    venue = json['venue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['flight_id'] = flightId;
    data['depart_location'] = departLocation;
    data['depart_lat_long'] = departLatLong;
    data['depart_time'] = departTime;
    data['depart_terminal'] = departTerminal;
    data['depart_gate'] = departGate;
    data['arrival_location'] = arrivalLocation;
    data['arrival_lat_long'] = arrivalLatLong;
    data['arrival_time'] = arrivalTime;
    data['arrival_terminal'] = arrivalTerminal;
    data['arrival_gate'] = arrivalGate;
    data['airlines'] = airlines;
    data['flight_number'] = flightNumber;
    data['flight_class'] = flightClass;
    data['wather'] = wather;
    data['user'] = user;
    data['gig'] = gig;
    data['cab_id'] = cabId;
    data['driver_name'] = driverName;
    data['driver_number'] = driverNumber;
    data['settime_id'] = settimeId;
    data['venue'] = venue;
    return data;
  }
}

class Contacts {
  int? id;
  int? userId;
  String? userName;
  int? gigId;
  String? gigTitle;
  String? type;
  String? name;
  String? number;
  String? email;
  bool? travellingParty;

  Contacts(
      {this.id,
      this.userId,
      this.userName,
      this.gigId,
      this.gigTitle,
      this.type,
      this.name,
      this.number,
      this.email,
      this.travellingParty});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    gigId = json['gig_id'];
    gigTitle = json['gig_title'];
    type = json['type'];
    name = json['name'];
    number = json['number'];
    email = json['email'];
    travellingParty = json['travelling_party'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['gig_id'] = gigId;
    data['gig_title'] = gigTitle;
    data['type'] = type;
    data['name'] = name;
    data['number'] = number;
    data['email'] = email;
    data['travelling_party'] = travellingParty;
    return data;
  }
}

class Guestlists {
  int? id;
  int? userId;
  String? userName;
  int? gigId;
  String? gigTitle;
  String? guestlistDetail;
  bool? guestlist;

  Guestlists(
      {this.id,
      this.userId,
      this.userName,
      this.gigId,
      this.gigTitle,
      this.guestlistDetail,
      this.guestlist});

  Guestlists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    gigId = json['gig_id'];
    gigTitle = json['gig_title'];
    guestlistDetail = json['guestlist_detail'];
    guestlist = json['guestlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['gig_id'] = gigId;
    data['gig_title'] = gigTitle;
    data['guestlist_detail'] = guestlistDetail;
    data['guestlist'] = guestlist;
    return data;
  }
}

class Documents {
  int? id;
  int? userId;
  String? userName;
  int? gigId;
  String? gigTitle;
  int? flightId;
  String? flightName;
  String? type;
  String? document;

  Documents(
      {this.id,
      this.userId,
      this.userName,
      this.gigId,
      this.gigTitle,
      this.flightId,
      this.flightName,
      this.type,
      this.document});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    gigId = json['gig_id'];
    gigTitle = json['gig_title'];
    flightId = json['flight_id'];
    flightName = json['flight_name'];
    type = json['type'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['gig_id'] = gigId;
    data['gig_title'] = gigTitle;
    data['flight_id'] = flightId;
    data['flight_name'] = flightName;
    data['type'] = type;
    data['document'] = document;
    return data;
  }
}
