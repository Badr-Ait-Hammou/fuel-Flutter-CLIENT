import 'package:flutter/material.dart';

class SubmitPage extends StatefulWidget {
  final double modalHeight;
  SubmitPage({super.key, required this.modalHeight});

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController type = TextEditingController(text: "Gasoil");
  TextEditingController total = TextEditingController();

  @override
  void dispose() {
    type.dispose();
    total.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        height: widget.modalHeight,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    "Consommation",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              DropdownButtonFormField<String>(
                value: type.text,
                onChanged: (value) {
                  setState(() {
                    type.text = value!;
                  });
                },
                items: ["Gasoil", "SansPlomb", "Excellium"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a type";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Fuel Type",
                  hintText: "Select your fuel type",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: total,
                onChanged: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the total price";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Total price",
                  hintText: "Enter the total price",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
