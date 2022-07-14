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
  List<Schedule>? schedule;

  Result({this.users, this.gigs, this.schedule});

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
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(new Schedule.fromJson(v));
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
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? id;
  String? firstName;
  String? lastName;

  Users({this.id, this.firstName, this.lastName});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
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
  String? date;
  String? soundCheckTime;
  int? user;

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
      this.date,
      this.soundCheckTime,
      this.user});

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
    date = json['date'];
    soundCheckTime = json['sound_check_time'];
    user = json['user'];
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
    data['date'] = this.date;
    data['sound_check_time'] = this.soundCheckTime;
    data['user'] = this.user;
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
      this.driverNumber});

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
    return data;
  }
}
