import 'package:flutter/material.dart';

class EmailPassword extends StatelessWidget {
  const EmailPassword({super.key, 
    required this.email,
    required this.hint,
  });

  final String email;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              email,
              style: const TextStyle(
                  color: Color.fromARGB(255, 7, 96, 168), fontSize: 15),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 7, 96, 168),
                      width: 2,
                    )),
                hintText: hint),
          ),
        ),
      ],
    );
  }
}
