import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
           backgroundColor: const Color.fromARGB(255, 7, 96, 168),
          title: Text(
            'Water reminder',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top:50.0, bottom:58.0, left:21.0, right:21.0),
                // child: Image.asset('images/start page image.png'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('images/start page image.png',
                  fit: BoxFit.cover,
                  opacity:const AlwaysStoppedAnimation(.8),),
                ),
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 21.0,right: 115.0),
                    child: LoginSignUpBotton('Login'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 21.0),
                    child: LoginSignUpBotton('SignUp'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox LoginSignUpBotton(String text) {
    return SizedBox(
                    height: 41,
                    width: 117,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 7, 96, 168), // Background color
                      ),
                      onPressed: (){}, 
                      child: Text(text,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  );
  }
}