// Also Available at: https://www.jdoodle.com/ga/HA08q9Obl2BHLDLQEdchew%3D%3D

import 'dart:io';

void main() {

  int number = 25;
  String message = "Welcome to Dart!";
  bool isActive = true;


  stdout.write("Enter your name: ");
  String? name = stdin.readLineSync();

  stdout.write("Enter your age: ");
  String? ageInput = stdin.readLineSync();
  int age = int.tryParse(ageInput ?? "0") ?? 0;

  print("\nHello, $name! You are $age years old.\n");


  List<String> cities = ['Karachi', 'Lahore', 'Islamabad', 'Quetta', 'Peshawar'];
  print("Original List of Cities:");
  print(cities);

  print("\nReversed List of Cities:");
  print(cities.reversed.toList());


  Map<String, int> studentMarks = {
    'Ali': 85,
    'Sara': 92,
    'John': 78,
  };


  studentMarks['Hina'] = 88;

  print("\nUpdated Student Marks:");
  studentMarks.forEach((key, value) {
    print("$key: $value");
  });

  String category = (age < 13)
      ? "Child"
      : (age >= 13 && age <= 19)
          ? "Teen"
          : (age >= 20 && age <= 59)
              ? "Adult"
              : "Senior";

  print("\nAge Category: $category");
}
