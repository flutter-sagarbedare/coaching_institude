import 'package:flutter/material.dart';

class LacturePage extends StatelessWidget {
  const LacturePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = List.generate(
      10,
      (index) => {
        'title': 'Item ${index + 1}',
        'subtitle': 'This is the description for item ${index + 1}.',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lacture Page'),
              backgroundColor: Colors.deepPurple,

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicked on ${items[index]['title']}')),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.touch_app, size: 30, color: Colors.deepPurple),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index]['title']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                items[index]['subtitle']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
