import 'package:flutter/material.dart';
import 'package:final_todo_app/constants.dart';

class TodoCard extends StatefulWidget {
  final String name;
  final bool isChecked;
  final ValueChanged onChanged;
  final GestureTapCallback deletePress;
  final Function updatePress;
  final TextEditingController controller;
  final String currentText;
  TodoCard({
    required this.name,
    required this.isChecked,
    required this.onChanged,
    required this.deletePress,
    required this.updatePress,
    required this.controller,
    required this.currentText,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.currentText;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isEditing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, bottom: 5),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                          controller: widget.controller,
                          style: const TextStyle(
                            fontSize: 24.0,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: widget.isChecked,
                      onChanged: widget.onChanged,
                      activeColor: componentColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                          decoration: widget.isChecked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    )
                  ],
                ),
          isEditing
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditing = !isEditing;
                      widget.updatePress();
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.check,
                      size: 25,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: widget.deletePress,
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete_outline,
                      size: 25,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}