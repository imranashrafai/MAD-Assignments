// Also Available at: https://www.jdoodle.com/ga/igWtqSHvE49MFWRHofSlPA%3D%3D
import 'dart:io';

class Person {
  String _name = '';
  int age;

  Person(String name, this.age) {
    this.name = name;
  }

  String get name => _name;

  set name(String value) {
    if (value.isEmpty) {
      print("Name cannot be empty. Setting default name as 'Unknown'.");
      _name = "Unknown";
    } else {
      _name = value;
    }
  }

  void display() {
    print("Name: $_name, Age: $age");
  }
}

class Student extends Person {
  int rollNumber;
  String course;

  Student(String name, int age, this.rollNumber, this.course)
      : super(name, age);

  Student.namedConstructor({
    required String name,
    required int age,
    required this.rollNumber,
    required this.course,
  }) : super(name, age);

  @override
  void display() {
    print("Roll No: $rollNumber, Name: $name, Age: $age, Course: $course");
  }
}

void main() {
  Student s1 = Student("Ali", 20, 101, "Computer Science");
  Student s2 = Student.namedConstructor(
      name: "Sara", age: 21, rollNumber: 102, course: "Mathematics");
  Student s3 = Student("John", 22, 103, "Computer Science");
  Student s4 = Student("", 19, 104, "Physics"); // Name will be validated

  List<Student> students = [s1, s2, s3, s4];

  print("All Students:");
  for (var student in students) {
    student.display();
  }

  stdout.write("\nEnter course name to filter students: ");
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print("No course entered. Exiting filter.");
    return;
  }

  String targetCourse = input.trim();

  print("\nStudents enrolled in '$targetCourse':");
  filterByCourse(students, targetCourse);
}

void filterByCourse(List<Student> students, String courseName) {
  bool found = false;

  for (var student in students) {
    if (student.course.toLowerCase() == courseName.toLowerCase()) {
      student.display();
      found = true;
    }
  }

  if (!found) {
    print("No students found for course: $courseName");
  }
}

