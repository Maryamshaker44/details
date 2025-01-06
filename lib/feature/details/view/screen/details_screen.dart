import 'package:details/feature/home/view/screen/home_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String name;
  final int age;

  DetailsScreen({required this.name, required this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Name : $name",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                "Age : $age ",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                           HomeScreen(),
                      ),
                    );
                  
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}