import 'package:flutter/material.dart';
class my_account_screen extends StatefulWidget {
  const my_account_screen({Key? key}) : super(key: key);

  @override
  State<my_account_screen> createState() => _my_account_screenState();
}

class _my_account_screenState extends State<my_account_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  size: 25,),
              ),
            ),
            //SizedBox(height: 40),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('MY Account',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),),
              ),
            ),
            SizedBox(height: 20,),
            Row(

              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 40,right: 16),
                  child: Container(
                    //height: 80,
                    child: CircleAvatar(
                        radius: 30,
                        child:
                        Image.asset('assets/images/vbt.PNG')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      Text('Fazan Anasari',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(left: 1),

                        child:Text('fazanansari@gmail.com',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),),
                      ),

                    ],
                  ),
                ),

              ],

            ),

            SizedBox(height: 40),

            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text('Wishlist',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 235.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.navigate_next,
                      size: 25,
                      color: Colors.grey,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width/1.1,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text('My Order',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 220.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.navigate_next,
                      size: 25,
                      color: Colors.grey,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width/1.1,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text('Payment Method',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 165.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.navigate_next,
                      size: 25,
                      color: Colors.grey,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width/1.1,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text('Delivery Address',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 165.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.navigate_next,
                      size: 25,
                      color: Colors.grey,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width/1.1,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text('Gift card & voucher',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 145.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.navigate_next,
                      size: 25,
                      color: Colors.grey,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width/1.1,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text('Contact Preference',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 145.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.navigate_next,
                      size: 25,
                      color: Colors.grey,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ),



          ],
        ),
      ),
    );
  }
}
