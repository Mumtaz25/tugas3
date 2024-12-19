import 'package:flutter/material.dart';
import 'package:tugas3/layout/model/Getnews.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; // Corrected import

import 'apiPage/NewsCard.dart';

class Newspage extends StatefulWidget {
  const Newspage({Key? key}) : super(key: key); // Changed to StatefulWidget

  @override
  State<Newspage> createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  Future<List<Getnews>> fetchPosts() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body) as List;
      var listPosts = getPostsData.map((i) => Getnews.fromJson(i)).toList(); // Fixed fromJson usage
      return listPosts;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  late Future<List<Getnews>> futurePosts;

  @override
  void initState() {
    super.initState(); // Added super.initState()
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Fixed EdgeInsets syntax
          child: FutureBuilder<List<Getnews>>(
            future: futurePosts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                var posts = snapshot.data!;
                return ListView.separated(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return Column(
                      children: [
                        NewsCard(
                          getnews: Getnews(
                            id: post.id,
                            title: post.title,
                            body: post.body,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
