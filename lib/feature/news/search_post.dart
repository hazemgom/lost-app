import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:save_stone/helper/components/custom_components.dart';
import 'package:save_stone/helper/components/theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildCustomAppBar(
        text: '',
        action: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    name.text = value;
                  });
                },
                onSubmitted: (value) {
                  name.clear();
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: textTheme(
                    fontSize: 22,
                  ),
                  suffixIcon: const Icon(
                    IconlyBroken.search,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (name.text == '')
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        'https://img.freepik.com/free-vector/search-concept-illustration_114360-156.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais'
                      ),
                    )
                  ),
                ),
              ),
            if (name.text.isNotEmpty)
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .where('text', isGreaterThanOrEqualTo: name.text)
                      .snapshots(),
                  // : FirebaseFirestore.instance.collection('posts').snapshots(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.black54,
                                ),
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                              if (name.text.isNotEmpty) {
                                return Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              data['postImage'],
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                          child: Text(
                                            r'Name : ' + data['name'],
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Text(
                                          r'Caption : ' + data['text'],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }

                              if (data['text']
                                  .toString()
                                  .toUpperCase()
                                  .startsWith(
                                    name.text.toLowerCase(),
                                  )) {
                                return Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                data['postImage'],
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      height: 100,
                                      width: 100,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                          child: Text(
                                            r'Name : ' + data['name'],
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          r'Caption : ' + data['text'],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return const Text('null');
                            },
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
