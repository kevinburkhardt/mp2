class Event{
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String description;
  final String organizer;
  final List<Attendee> attendees;
  final DateTime createdAt;

  Event({required this.id, required this.title, required this.startTime, required this.endTime,
    required this.location, required this.description, required this.organizer, required this.attendees, required this.createdAt
  });

  factory Event.fromJson(Map<String, dynamic> json){
    return Event(
      id: json['id'],
      title: json['title'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      location: json['location'],
      description: json['description'],
      organizer: json['organizer'],
      attendees: (json['attendees'] as List)
          .map((a) => Attendee.fromJson(a))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Attendee {
  final String name;
  final String email;
  final String response;

  Attendee({
    required this.name,
    required this.email,
    required this.response,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      name: json['name'],
      email: json['email'],
      response: json['response'],
    );
  }
}