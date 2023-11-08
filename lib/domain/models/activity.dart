class Activity {
  Activity({
    this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.ended
  });

  int? id;
  String name;
  String description;
  String date;
  String location;
  bool ended;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        name: json["name"] ?? "somename",
        description: json["description"] ?? "description",
        date: json["date"] ?? "date",
        location: json["location"] ?? "0/0/00",
        ended: json["ended"] ?? false
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "name": name,
        "description": description,
        "date": date,
        "location": location,
        "ended": ended
      };
}
