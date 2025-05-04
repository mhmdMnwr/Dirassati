import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          AnnouncementCard(
            category: 'Important Notice',
            title: 'No Classes on Thursday',
            content:
                'Due to electrical maintenance, there will be no classes on Thursday, May 12th. We appreciate your understanding.',
            color: Colors.redAccent,
          ),
          AnnouncementCard(
            category: 'Discipline',
            title: 'Reminder to Respect Arrival Times',
            content:
                'Parents are kindly asked to ensure their children arrive on time in the morning. Frequent lateness will affect student behavior.',
            color: Colors.teal,
          ),
          AnnouncementCard(
            category: 'Activities',
            title: 'Open Day on Saturday',
            content:
                'We invite you to attend the open day on Saturday with participation from students and teachers. Your presence is appreciated.',
            color: Colors.deepPurpleAccent,
          ),
          AnnouncementCard(
            category: 'Health & Safety',
            title: 'COVID-19 Precautions Reminder',
            content:
                'Please remind students to wear masks and use sanitizer regularly to ensure everyone’s safety.',
            color: Colors.green,
          ),
          AnnouncementCard(
            category: 'Events',
            title: 'Science Fair Next Week',
            content:
                'The annual Science Fair will be held next Wednesday. All students are encouraged to participate.',
            color: Colors.indigoAccent,
          ),
        ],
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final String category;
  final String title;
  final String content;
  final Color color;

  const AnnouncementCard({
    Key? key,
    required this.category,
    required this.title,
    required this.content,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
