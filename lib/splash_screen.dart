import 'package:flutter/material.dart';
import 'package:matchmate/home_page.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 20),(){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      ); // Prints after 1 second.
    });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFF3b3c5c),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Center(child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 120,
              child: CircleAvatar(
                radius: 110,
                backgroundImage: NetworkImage('https://img.freepik.com/free-vector/soccer-concept-illustration_114360-2020.jpg?w=740&t=st=1685961673~exp=1685962273~hmac=0c35fdce304e50ec0341701b5bb0fa0e9edeb5aa0a757e45d2602023502583b9'),
              ),
            )),
            SizedBox(height: 50,),
            Text('Welcome to Match Mate',textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Britanic Bold',fontSize: 25,color: Colors.white),),
            SizedBox(height: 100,),
            CircularProgressIndicator(color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
