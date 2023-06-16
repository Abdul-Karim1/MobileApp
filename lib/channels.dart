import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchmate/home_page.dart';
import 'colors.dart' as colors;

class Channels extends StatefulWidget {
  const Channels({Key? key}) : super(key: key);

  @override
  State<Channels> createState() => _ChannelsState();
}

class _ChannelsState extends State<Channels> {
  final CollectionReference _channels = FirebaseFirestore.instance.collection('channels');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Padding(
          padding: EdgeInsets.only(right: 30),
          child: Center(child: Text('Channels')),
        ),
        backgroundColor: colors.AppColor.homePageIcons,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _channels.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final channels = snapshot.data!.docs;

          return ListView.builder(
            itemCount: channels.length,
            itemBuilder: (BuildContext context, int index) {
              final channel = channels[index];
              final id = channel.id;
              final data = channel.data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: colors.AppColor.homePageContainerTextBig,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    title: Text('ID: ${data['channel_id']}, Name: ${data['channel_name']}',style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times New Roman',
                      fontSize: 14,
                    ),),
                    leading:  ClipOval(
                      child: Image.network(
                        '${data['channel_url']}',
                        width: 200,
                        height: 220,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },

      ),
    );
  }
}
