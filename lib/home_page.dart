import 'package:flutter/material.dart';
import 'package:matchmate/leagues.dart';
import 'colors.dart' as color;
import 'leagues.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 80,left: 30,right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text('Match Mate',
                  style:TextStyle(
                      fontSize: 30,
                      color: color.AppColor.homePageTitle,
                      fontWeight: FontWeight.w700
                  ),),
                Expanded(child: Container()),
                Icon(Icons.sports_football,
                  size: 40,
                  color: color.AppColor.homePageIcons,
                )

              ],
            ),
            const SizedBox(height: 30,),
            Row(
                children:[
                  Text('Leagues',
                    style:TextStyle(
                        fontSize: 20,
                        color: color.AppColor.homePageSubtitle,
                        fontWeight: FontWeight.w700
                    ),),
                  Expanded(child: Container()),
                  Text('Details',
                    style:TextStyle(
                        fontSize: 20,
                        color: color.AppColor.homePageDetail,
                        fontWeight: FontWeight.w700
                    ),),
                  const SizedBox(width: 5,),
                  Icon(Icons.arrow_forward_outlined,
                    size: 20,
                    color: color.AppColor.homePageDetail,
                  )
                ]
            ),
            const SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        color.AppColor.gradientFirst.withOpacity(0.7),
                        color.AppColor.gradientSecond.withOpacity(0.9),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(60),

                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5,10),
                      blurRadius: 10,
                      color: color.AppColor.gradientSecond.withOpacity(0.2),

                    )
                  ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Image.asset('assets/main.png',width: 200,height: 100,color: Colors.white,),
                  const SizedBox(height: 5,),
                  Text('Get in the game and stay on top',style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.homePageContainerTextBig
                  ),),

                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.withOpacity(0.7),
                        Colors.white60.withOpacity(0.9),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),

                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5,10),
                      blurRadius: 10,
                      color: color.AppColor.gradientSecond.withOpacity(0.2),

                    )
                  ]
              ),
              child: Row(
                children: [
                  Image.asset('assets/football-player.png',width: 100,height: 70,color: Colors.white,),
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      SizedBox(height: 20),
                      Text('Find the best leagues',style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,

                      ),),
                      SizedBox(height: 5,),
                      Text('Never miss a single match',style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,

                      ),),
                      SizedBox(height: 5,),
                      Text('From every corner of the world',style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,

                      ),)
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 50,),
            IconButton(onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Leagues(),

                ),
              );
            }, icon: const Icon(Icons.leaderboard_outlined)),
            const Text('Fetch Leagues'),


          ],
        ),
      ),
    );
  }
}