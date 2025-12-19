import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String selectedPriority = "Low";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Task",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Task Title",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              hint: "Enter task title",
              maxLines: 1,
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              hint: "Enter task description",
              maxLines: 4,
            ),

            const SizedBox(height: 20),

            const Text(
              "Priority",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                ChoiceChip(
                  label: const Text("Low"),
                  selected: selectedPriority == "Low",
                  selectedColor: Colors.green.withOpacity(0.25),
                  onSelected: (_) {
                    setState(() => selectedPriority = "Low");
                  },
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text("Medium"),
                  selected: selectedPriority == "Medium",
                  selectedColor: Colors.orange.withOpacity(0.25),
                  onSelected: (_) {
                    setState(() => selectedPriority = "Medium");
                  },
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text("High"),
                  selected: selectedPriority == "High",
                  selectedColor: Colors.red.withOpacity(0.25),
                  onSelected: (_) {
                    setState(() => selectedPriority = "High");
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // UI only
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C4DFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Save Task",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildTextField({
    required String hint,
    required int maxLines,
  }) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
