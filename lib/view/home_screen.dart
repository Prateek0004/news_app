import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/News_channels_headlines_models.dart';
import 'package:news_app/view/categories_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  independent,
  reuters,
  cnn,
  alJazeera,
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd yyyy');
  FilterList? selectedMenu;
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Image.asset(
            "images/category_icon.png",
            width: 30,
            height: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              onSelected: (FilterList item) {
                setState(() {
                  selectedMenu = item;
                  if (item == FilterList.bbcNews) {
                    name = 'bbc-news';
                  } else if (item == FilterList.aryNews) {
                    name = 'ary-news';
                  } else if (item == FilterList.independent) {
                    name = 'independent';
                  } else if (item == FilterList.reuters) {
                    name = 'reuters';
                  } else if (item == FilterList.cnn) {
                    name = 'cnn';
                  } else if (item == FilterList.alJazeera) {
                    name = 'al-jazeera-english';
                  }
                });
              },
              icon: Icon(Icons.more_vert, color: Colors.black),
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<FilterList>>[
                PopupMenuItem(
                  value: FilterList.bbcNews,
                  child: Text('BBC News'),
                ),
                PopupMenuItem(
                  value: FilterList.aryNews,
                  child: Text('Ary News'),
                ),
                PopupMenuItem(
                  value: FilterList.independent,
                  child: Text('Independent'),
                ),
                PopupMenuItem(
                  value: FilterList.reuters,
                  child: Text('Reuters'),
                ),
                PopupMenuItem(
                  value: FilterList.cnn,
                  child: Text('CNN'),
                ),
                PopupMenuItem(
                  value: FilterList.alJazeera,
                  child: Text('Al Jazeera'),
                ),
              ]),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModels>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                            snapshot.data!.articles![index].publishedAt
                                .toString());

                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index]
                                        .urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(
                                          child: spinKit2,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    height: height * .22,
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot.data!.articles![index]
                                                .title
                                                .toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight
                                                          .w600),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 3,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .w500),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
