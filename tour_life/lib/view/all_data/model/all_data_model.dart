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
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
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
        users!.add(new Users.fromJson(v));
      });
    }
    if (json['gigs'] != null) {
      gigs = <Gigs>[];
      json['gigs'].forEach((v) {
        gigs!.add(new Gigs.fromJson(v));
      });
    }
    if (json['hotels'] != null) {
      hotels = <Hotels>[];
      json['hotels'].forEach((v) {
        hotels!.add(new Hotels.fromJson(v));
      });
    }
    if (json['venues'] != null) {
      venues = <Venues>[];
      json['venues'].forEach((v) {
        venues!.add(new Venues.fromJson(v));
      });
    }
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(new Schedule.fromJson(v));
      });
    }
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
    if (json['guestlists'] != null) {
      guestlists = <Guestlists>[];
      json['guestlists'].forEach((v) {
        guestlists!.add(new Guestlists.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.gigs != null) {
      data['gigs'] = this.gigs!.map((v) => v.toJson()).toList();
    }
    if (this.hotels != null) {
      data['hotels'] = this.hotels!.map((v) => v.toJson()).toList();
    }
    if (this.venues != null) {
      data['venues'] = this.venues!.map((v) => v.toJson()).toList();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    if (this.guestlists != null) {
      data['guestlists'] = this.guestlists!.map((v) => v.toJson()).toList();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? firstName;
  Null? lastName;
  bool? isManager;

  Users({this.id, this.firstName, this.lastName, this.isManager});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isManager = json['is_manager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['is_manager'] = this.isManager;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['descriptions'] = this.descriptions;
    data['profile_pic'] = this.profilePic;
    data['cover_image'] = this.coverImage;
    data['location'] = this.location;
    data['show'] = this.show;
    data['stage'] = this.stage;
    data['visa'] = this.visa;
    data['Equipment'] = this.equipment;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['sound_check_time'] = this.soundCheckTime;
    data['user'] = this.user;
    data['schedule_count'] = this.scheduleCount;
    data['contact_count'] = this.contactCount;
    data['document_count'] = this.documentCount;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['gig_id'] = this.gigId;
    data['gig_title'] = this.gigTitle;
    data['hotel_name'] = this.hotelName;
    data['address'] = this.address;
    data['direction'] = this.direction;
    data['website'] = this.website;
    data['number'] = this.number;
    data['wifi_paid_for'] = this.wifiPaidFor;
    data['room_buyout'] = this.roomBuyout;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['gig_id'] = this.gigId;
    data['gig_title'] = this.gigTitle;
    data['venue_name'] = this.venueName;
    data['address'] = this.address;
    data['direction'] = this.direction;
    data['website'] = this.website;
    data['number'] = this.number;
    data['indoor'] = this.indoor;
    data['covered'] = this.covered;
    data['capacity'] = this.capacity;
    data['wather'] = this.wather;
    data['credential_collection'] = this.credentialCollection;
    data['dressing_room'] = this.dressingRoom;
    data['hospitality'] = this.hospitality;
    data['hospitality_detail'] = this.hospitalityDetail;
    data['hospitality_email'] = this.hospitalityEmail;
    data['catring'] = this.catring;
    data['catring_detail'] = this.catringDetail;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['flight_id'] = this.flightId;
    data['depart_location'] = this.departLocation;
    data['depart_lat_long'] = this.departLatLong;
    data['depart_time'] = this.departTime;
    data['depart_terminal'] = this.departTerminal;
    data['depart_gate'] = this.departGate;
    data['arrival_location'] = this.arrivalLocation;
    data['arrival_lat_long'] = this.arrivalLatLong;
    data['arrival_time'] = this.arrivalTime;
    data['arrival_terminal'] = this.arrivalTerminal;
    data['arrival_gate'] = this.arrivalGate;
    data['airlines'] = this.airlines;
    data['flight_number'] = this.flightNumber;
    data['flight_class'] = this.flightClass;
    data['wather'] = this.wather;
    data['user'] = this.user;
    data['gig'] = this.gig;
    data['cab_id'] = this.cabId;
    data['driver_name'] = this.driverName;
    data['driver_number'] = this.driverNumber;
    data['settime_id'] = this.settimeId;
    data['venue'] = this.venue;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['gig_id'] = this.gigId;
    data['gig_title'] = this.gigTitle;
    data['type'] = this.type;
    data['name'] = this.name;
    data['number'] = this.number;
    data['email'] = this.email;
    data['travelling_party'] = this.travellingParty;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['gig_id'] = this.gigId;
    data['gig_title'] = this.gigTitle;
    data['guestlist_detail'] = this.guestlistDetail;
    data['guestlist'] = this.guestlist;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['gig_id'] = this.gigId;
    data['gig_title'] = this.gigTitle;
    data['flight_id'] = this.flightId;
    data['flight_name'] = this.flightName;
    data['type'] = this.type;
    data['document'] = this.document;
    return data;
  }
}
