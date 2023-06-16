import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchmate/channels.dart';
import 'colors.dart' as colors;

class Matches extends StatefulWidget {
  final String teamId1;
  final String teamId1Url;

  const Matches({
    required this.teamId1,
    required this.teamId1Url,
    Key? key,
  }) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> fireStore;
  late String id;

  void refreshData(String id) {
    setState(() {
      this.id = id;
      fireStore = FirebaseFirestore.instance
          .collection('Match')
          .where('team_id1', isEqualTo: id)
          .snapshots();
    });
  }

  @override
  void initState() {
    super.initState();
    id = widget.teamId1;
    print("ID PASSED" + id);
    fireStore = FirebaseFirestore.instance
        .collection('Match')
        .where('team_id1', isEqualTo: id)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 30),
          child: Center(child: Text('Match')),
        ),
        backgroundColor: colors.AppColor.homePageIcons,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: fireStore,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
              final id = team.id;
              final data = team.data();

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Channels(),
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
                  child: Wrap(
                    children: [
                      ClipOval(
                        child: FutureBuilder<String>(
                          future: getTeamUrl('${data['team_id1']}'),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError || snapshot.data == null) {
                              return Text('Error loading team image');
                            } else {
                              final teamUrl = snapshot.data;
                              return Image.network(
                                teamUrl!,
                                width: 200,
                                height: 220,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Failed to load team image: $error');
                                  return Text('Failed to load team image');
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipOval(
                        child: FutureBuilder<String>(
                          future: getTeamUrl('${data['team_id2']}'),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError || snapshot.data == null) {
                              return Text('Error loading team image');
                            } else {
                              final teamUrl = snapshot.data;
                              return Image.network(
                                teamUrl!,
                                width: 200,
                                height: 220,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Failed to load team image: $error');
                                  return Text('Failed to load team image');
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<String> getTeamUrl(String teamId) async {
    final teamsCollection = FirebaseFirestore.instance.collection('Teams');

    try {
      final teamSnapshot = await teamsCollection.doc(teamId).get();

      if (teamSnapshot.exists) {
        final teamData = teamSnapshot.data();

        if (teamData != null && teamData['team_url'] != null) {
          final teamUrl = teamData['team_url'] as String;
          print("TEAM URL: $teamUrl");
          return teamUrl;
        } else {
          print('Error: team_url is null');
          return 'default_image_url'; // Provide a default image URL or handle the error appropriately
        }
      } else {
        print('Error: Document does not exist');
        return 'default_image_url'; // Provide a default image URL or handle the error appropriately
      }
    } catch (error) {
      print('Error fetching teamUrl: $error');
      return 'default_image_url'; // Provide a default image URL or handle the error appropriately
    }
  }
}
