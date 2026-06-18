import 'package:flutter/material.dart';
import 'package:untitled/home_page.dart';
import 'package:untitled/main.dart';

class LearnFlutterPage extends StatefulWidget {
  const LearnFlutterPage({super.key});

  @override
  State<LearnFlutterPage> createState() => _LearnFlutterPageState();
}

class _LearnFlutterPageState extends State<LearnFlutterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "The Short Lived Dream:",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Image.asset("images/blocky.png", scale: 2),

              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "Blocky's Bad Day",
                      style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 2, child: Container(color: Colors.black)),
                    Text(
                      "This was the first ever game i had ever produced and ironically my final one too.This is the story "
                      "of the developer who learnt it the hard way.\n\n First i started learning c# from class 8 at the time"
                      " i didnt have my own pc so i used to go to my mother's sister's house cause she had one and i learnt "
                      "unity there. after some hardships from my side when i got into 9th class my parents agreed to get me "
                      "a pc and it wasnt anything special too just an average pc with lpddr2x ram and it could barely handle "
                      " unity.\n\nAfter i started bachelors my sister bought me an acer nitro 16 and i could finally learn my interest in my"
                      " own way.After a lot of incomplete projects i decided to create my first complete project which would later"
                      " be called blockys bad day....after that i created Birds!!(a flappy bird's replica),cannon capital(an in"
                      "cremental type game with shop,coins to spend for upgrades,boosts etc hoping with this much logic i would "
                      "surely land an internship and even if i couldn't who cares i love what i do and i will earn from my games"
                      " after i upload on playstore but.....\n\n Everything would come crashing down when i learnt the terms and conditions"
                      " of google play console account which stated that the account creation and payment country must be same,"
                      " in nepal international payment isnt possible and my sister living in foreign country couldnt even help me"
                      " even tho she wanted me to be what i wanted to become so badly....before i knew about all these i kept on"
                      " going and implemented ads,debugged day and night,eradicated logic loopholes,implemented leaderboards,created"
                      " player auth system,i was naive and didnt realize the country i was struggling in....There aren't a lot of game"
                      " development studios in nepal and my chances were slim to begin with.\n\n So after a lot of thinking i decided"
                      " to change the career path even though i decided to get into csit in hopes of becoming a game developer,heck that"
                      " was the plan ever since i knew about games,i wanted to create my own...."
                      " and here i am learning flutter and creating softwares that make peoples' life a little"
                      "bit easier.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
