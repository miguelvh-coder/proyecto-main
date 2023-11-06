class Activity {
  Activity({
    this.id,
    required this.name,
    required this.description,
    required this.date,
  });

  int? id;
  String name;
  String description;
  DateTime date;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        name: json["name"] ?? "somename",
        description: json["description"] ?? "description",
        date: json["date"] ?? "date",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "name": name,
        "description": description,
        "date": date,
      };
}
