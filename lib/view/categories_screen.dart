import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd yyyy');
  String categories = 'general';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
      child:Column(
        children: [
         SizedBox(
           height: 50,
           child: ListView.builder(
             scrollDirection: Axis.horizontal,
             itemCount: categoriesList.length,
               itemBuilder: (context,index){
               return Container(
                 decoration: BoxDecoration(
                   color: Colors.blue
                 ),
                 child : Center(child: Text(
                     categoriesList[index].toString()
                 ),
                 ),
               );
           }
         )
         )
        ],
      ),
      ),

    );
  }
}
