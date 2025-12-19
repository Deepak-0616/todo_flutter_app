import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  List<Map<String, dynamic>> todos = [];

  void addTodo() {
    if (titleController.text.trim().isEmpty) return;

    setState(() {
      todos.insert(0, {
        "title": titleController.text,
        "description": descController.text,
        "done": false,
      });
    });

    titleController.clear();
    descController.clear();
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index]["done"] = !todos[index]["done"];
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 12,
        shadowColor: Colors.redAccent.withOpacity(0.6),
        centerTitle: true,
        title: const Text(
          "THE LIST",
          style: TextStyle(
            color: Colors.redAccent,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🩸 ADD TASK PANEL
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0E0E0E),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.25),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Title field
                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.redAccent),
                    cursorColor: Colors.redAccent,
                    decoration: InputDecoration(
                      hintText: "Task title",
                      hintStyle: TextStyle(
                        color: Colors.redAccent.withOpacity(0.4),
                      ),
                      border: InputBorder.none,
                    ),
                  ),

                  const Divider(color: Colors.redAccent),

                  // Description field
                  TextField(
                    controller: descController,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.redAccent.withOpacity(0.85),
                      fontSize: 13,
                    ),
                    cursorColor: Colors.redAccent,
                    decoration: InputDecoration(
                      hintText: "Task description (optional)",
                      hintStyle: TextStyle(
                        color: Colors.redAccent.withOpacity(0.3),
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: addTodo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "ADD TO THE LIST",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 👁 EMPTY STATE
            if (todos.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    "Nothing is written… yet 👁",
                    style: TextStyle(
                      color: Colors.redAccent.withOpacity(0.6),
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: todo["done"]
                              ? Colors.greenAccent
                              : Colors.redAccent.withOpacity(0.6),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: todo["done"]
                                ? Colors.greenAccent.withOpacity(0.2)
                                : Colors.redAccent.withOpacity(0.2),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ☠️ CHECK
                          GestureDetector(
                            onTap: () => toggleTodo(index),
                            child: Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: todo["done"]
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                  width: 2,
                                ),
                              ),
                              child: todo["done"]
                                  ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.greenAccent,
                              )
                                  : null,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // 🩸 TITLE + DESCRIPTION
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todo["title"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 0.6,
                                    color: todo["done"]
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    decoration: todo["done"]
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                if (todo["description"].isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    todo["description"],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.redAccent.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // 🗡 DELETE
                          IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => deleteTodo(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
