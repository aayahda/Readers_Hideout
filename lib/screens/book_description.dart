import 'package:flutter/material.dart';
import 'package:readers_hideout/model/book_model.dart';

class BookDescription extends StatelessWidget {
  final Book bookmodel;
  BookDescription(this.bookmodel);
  Positioned myBook() {
    return Positioned(
      top: 90.0,
      left: 140.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(4, 5), // Shadow position
            ),
          ],
        ),
        width: 120,
        height: 190,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image(
            image: NetworkImage(bookmodel.picture),
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 180.0,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          offset: Offset(3.0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 120.0),
                        Text(
                          bookmodel.author,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          bookmodel.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),
                        Text(
                          '⭐ ' + bookmodel.rating.toString(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 17.0,
                          ),
                        ),
                        SizedBox(height: 35.0),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            myBook(),
          ],
        ),
      ),
    );
  }
}
