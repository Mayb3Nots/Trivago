import 'package:flutter/material.dart';

class BookedList extends StatelessWidget {
  const BookedList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(children: [
            const Text(
              'John Xina 5',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.people),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                padding: const EdgeInsets.all(3),
                child: const Text(
                  'Jan 17,2024',
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const Icon(Icons.arrow_right_alt),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                padding: const EdgeInsets.all(3),
                child: const Text(
                  'Jan 27,2024',
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
