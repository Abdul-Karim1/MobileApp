import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchmate/channels.dart';
import 'colors.dart' as colors;
import 'Matches.dart';


class Teams extends StatefulWidget {
  final String LeagueId;
  const Teams({required this.LeagueId,Key? key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  late Stream<QuerySnapshot> fireStore;
  late String id;


  void refreshData(String id) {
    setState(() {
      this.id = id;
      fireStore = FirebaseFirestore.instance
          .collection('Teams')
          .where('league_refrence', isEqualTo: id)
          .snapshots();
    });
  }

  @override
  void initState() {
    super.initState();
    id = widget.LeagueId;
    fireStore = FirebaseFirestore.instance
        .collection('Teams')
        .where('league_id', isEqualTo: id)
        .snapshots();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Padding(
          padding: EdgeInsets.only(right: 30),
          child: Center(child: Text('Teams')),
        ),
        backgroundColor: colors.AppColor.homePageIcons,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final teams = snapshot.data!.docs;

          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (BuildContext context, int index) {
              final team = teams[index];


              final data = team.data() as Map<String, dynamic>;
              final id = data['team_id'];
              final url = data['team_url'];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  Matches(teamId1: id,teamId1Url: url),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: colors.AppColor.homePageContainerTextBig,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    title: Text('ID: ${data['league_id']}, Name: ${data['team_name']}',style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times New Roman',
                      fontSize: 14,
                    ),),
                    leading:  ClipOval(
                      child: Image.network(
                        '${data['team_url']}',
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
