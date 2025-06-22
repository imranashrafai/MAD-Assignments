import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "",
      authDomain: "",
      projectId: "",
      storageBucket: "",
      messagingSenderId: "",
      appId: "",
      measurementId: "",
    ),
  );
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Entry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const StudentFormPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();
  Map<String, dynamic>? recentStudent;

  Future<void> addStudent() async {
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim());
    final course = courseController.text.trim();

    if (name.isEmpty || age == null || course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all fields correctly.'),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }

    final student = {
      'name': name,
      'age': age,
      'course': course,
      'timestamp': FieldValue.serverTimestamp(),
    };

    final docRef = await FirebaseFirestore.instance.collection('students').add(student);
    final docSnapshot = await docRef.get();

    setState(() {
      recentStudent = docSnapshot.data();
      nameController.clear();
      ageController.clear();
      courseController.clear();
    });
  }

  Stream<QuerySnapshot> fetchStudents() {
    return FirebaseFirestore.instance
        .collection('students')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Registration"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Enter Student Info",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Form Fields
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(labelText: 'Course'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: addStudent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white) ),
              ),
              const SizedBox(height: 20),

              // Recently Added
              if (recentStudent != null)
                Card(
                  color: Colors.lightBlue[50],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: const Text("Recently Added", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Name: ${recentStudent!['name']}, Age: ${recentStudent!['age']}, Course: ${recentStudent!['course']}"),
                  ),
                ),

              const SizedBox(height: 12),
              const Divider(),
              const Text(
                "All Students",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Student List
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: fetchStudents(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const CircularProgressIndicator();
                    final docs = snapshot.data!.docs;

                    if (docs.isEmpty) {
                      return const Text("No student records found.");
                    }

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[100],
                              child: Text(data['name'][0], style: const TextStyle(color: Colors.black)),
                            ),
                            title: Text(data['name'] ?? ''),
                            subtitle: Text('Age: ${data['age']} | Course: ${data['course']}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
