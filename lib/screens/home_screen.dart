import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'AIzaSyA6bTNrZKQxYWT_o0YL58DqKR12H7mfjRw';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Book>> _getBooks() async {
    http.Response response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=best+inauthor:keyes&key=$apiKey'));
    String data = response.body;
    var decodedData = jsonDecode(data);
    print(decodedData);
    List<Book> books = [];
    for (var b in decodedData["items"]) {
      Book book = Book(
          b["volumeInfo"]["title"],
          b["volumeInfo"]["averageRating"],
          b["volumeInfo"]["authors"],
          b["volumeInfo"]["imageLinks"]["thumbnail"]);
      books.add(book);
    }
    print(books.length);
    print("call");
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
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
            SizedBox(
                height: 200.0,
                child: FutureBuilder(
                    future: _getBooks(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot.data);
                      return ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          height: 100.0,
                          width: 150.0,
                          margin: EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Column(
                              children: [
                                // Image(
                                //   image: NetworkImage(
                                //       snapshot.data[index].picture),
                                // ),
                                Text('Image'),
                                Text('Name'),
                                Text('Author'),
                                Text('Rating')
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
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
            Flexible(
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Book'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Book {
  final String title;
  final int rating;
  final String author;
  final String picture;

  Book(this.title, this.rating, this.author, this.picture);
}
