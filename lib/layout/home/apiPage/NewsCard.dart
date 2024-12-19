import 'package:flutter/material.dart';
import 'package:tugas3/layout/model/Getnews.dart';
import 'Detailnewspage.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, required this.getnews}) : super(key: key);

  final Getnews getnews;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detailnewspage(getnews: getnews),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getnews.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getnews.body,
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
