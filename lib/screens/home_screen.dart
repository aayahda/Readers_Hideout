import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readers_hideout/screens/book_description.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readers_hideout/model/book_model.dart';

const apiKey = 'AIzaSyDnKQbu3g3EYyp-Ro-hQtHNB6Gd_Mq8Mcc';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  Future<List<Book>> _getBooks(String category) async {
    http.Response response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$category+inauthor:keyes&key=$apiKey'));
    var data = response.body;
    var decodedData = json.decode(data);
    List<Book> books = [];
    for (var b in decodedData["items"]) {
      Book book = Book(
          b["volumeInfo"]["title"],
          b["volumeInfo"]["averageRating"],
          b["volumeInfo"]["authors"][0],
          b["volumeInfo"]["imageLinks"]["thumbnail"],
          b["volumeInfo"]["description"]);
      books.add(book);
    }
    return books;
  }

  @override
  void initState() {
    super.initState();
    _getBooks('best');
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Center(
          child: Text(
            "Reader's Hideout",
            style: TextStyle(
              color: Colors.teal[700],
              fontSize: 25.0,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              'What are you reading today?',
              style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 25.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Hunt new books before other',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            Text(
              'bookworms do it',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Best Seller',
              style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 30.0),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: closeTopContainer ? 0 : 311.0,
              child: SizedBox(
                height: 311.0,
                child: FutureBuilder(
                    future: _getBooks('best'),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Center(
                          child: Text('loading...'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      BookDescription(snapshot.data[index])));
                            },
                            child: Container(
                              height: 100.0,
                              width: 150.0,
                              margin: EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 7,
                                              offset: Offset(
                                                  3, 5), // Shadow position
                                            ),
                                          ],
                                        ),
                                        width: 120,
                                        height: 180,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image(
                                            image: NetworkImage(
                                                snapshot.data[index].picture),
                                            width: 200,
                                            height: 200,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          snapshot.data[index].title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].author,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        '???' +
                                            snapshot.data[index].rating
                                                .toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Trending ',
              style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 30.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: FutureBuilder(
                  future: _getBooks('trending'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: Text('loading...'),
                      );
                    } else {
                      return ListView.builder(
                        controller: controller,
                        itemCount: 10,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ListTile(
                          title: Container(
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 7,
                                        offset: Offset(3, 5), // Shadow position
                                      ),
                                    ],
                                  ),
                                  width: 120,
                                  height: 180,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: FittedBox(
                                      fit: BoxFit.none,
                                      child: Image(
                                        image: NetworkImage(
                                            snapshot.data[index].picture),
                                        width: 200,
                                        height: 200,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].title,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data[index].author,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    Text(
                                      '???' +
                                          snapshot.data[index].rating
                                              .toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    BookDescription(snapshot.data[index])));
                          },
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
