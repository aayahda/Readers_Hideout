import 'package:flutter/material.dart';

class BookDescription extends StatelessWidget {
  Positioned myBook() {
    return Positioned(
      top: 90.0,
      left: 130.0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(20.0)),
        width: 140,
        height: 180,
        child: Center(child: Text('hi')),
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
                        SizedBox(height: 100.0),
                        Text(
                          'Author',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          'Book Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),
                        Text(
                          'Rating',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 15.0,
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
