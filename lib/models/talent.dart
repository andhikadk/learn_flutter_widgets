class Talent {
  String name;
  String position;
  int salary;

  Talent({
    required this.name,
    required this.position,
    required this.salary,
  });

  Talent.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        position = json['position'],
        salary = json['salary'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'position': position,
        'salary': salary,
      };
}
