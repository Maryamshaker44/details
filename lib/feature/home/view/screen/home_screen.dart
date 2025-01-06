import 'package:details/core/style/custom_textfield.dart';
import 'package:details/feature/details/view/screen/details_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  String? name;
  String? date;

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void show() {
    if (formKey.currentState!.validate()) {
      setState(() {
        name = nameController.text;
        date = dateController.text;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please correct the errors in the form')),
      );
    }
  }

  int calculateAge(String birthDate) {
    final parts = birthDate.split('/');
    if (parts.length != 3) return 0;

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final today = DateTime.now();
    final birthday = DateTime(year, month, day);

    int age = today.year - birthday.year;
    if (today.month < birthday.month ||
        (today.month == birthday.month && today.day < birthday.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomTextField(
                label: "Name",
                hint: "Enter your name",
                prefix: Icons.person,
                controller: nameController,
                keyboard: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  if (value.length < 3) {
                    return " Name must be at least 3 characters";
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: "Date of birth",
                hint: "Enter your date of birth",
                prefix: Icons.date_range,
                controller: dateController,
                keyboard: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your date of birth";
                  }
                  final regex = RegExp(
                      r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(\d{4})$");
                  if (!regex.hasMatch(value)) {
                    return "Date format must be DD/MM/YYYY";
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: show,
                child: Text("Show details"), 
              ),
              if (name != null && date != null)
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Name: $name",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        " Date of birth: $date",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final name = nameController.text;
                    final date = dateController.text;

                    final age = calculateAge(date);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(name: name, age: age),
                      ),
                    );
                  }
                },
                child: Text("Move"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}