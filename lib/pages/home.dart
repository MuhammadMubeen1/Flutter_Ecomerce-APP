 import 'package:ecomerceprojecr/pages/login.dart';
import 'package:ecomerceprojecr/pages/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'cart.dart';
import 'horizental_list.dart';
class emcomerce extends StatefulWidget {
  const emcomerce({Key? key}) : super(key: key);

  @override
  _emcomerceState createState() => _emcomerceState();
}

class _emcomerceState extends State<emcomerce> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = Container(
        height: 250.0,
        child: Carousel(
          boxFit: BoxFit.cover,
          images: const [
            AssetImage('assets/w3.jpeg'),
            AssetImage('assets/m1.jpeg'),
            AssetImage('assets/c1.jpg'),
            AssetImage('assets/w4.jpeg'),
            AssetImage('assets/m2.jpg'),
          ],
          autoplay: false,
          dotSize: 4.0,
          indicatorBgPadding: 2.0,
          dotBgColor: Colors.transparent,
        ));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: const Text("FashApp"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Muhammad Mubeen"),
              accountEmail: Text("uwork64@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home, color: Colors.red),
              ),
            ),
            InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text("My Account"),
                  leading: Icon(Icons.person, color: Colors.red),
                )),
            InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text("My Orders"),
                  leading: Icon(Icons.shopping_basket, color: Colors.red),
                )),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Cart()));
              },
              child: const ListTile(
                title: Text("Shopping cart"),
                leading: Icon(Icons.shopping_cart, color: Colors.red),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text("Favourites"),
                leading: Icon(Icons.favorite, color: Colors.red),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text("Setting"),
                leading: Icon(
                  Icons.settings,
                ),
              ),
            ),
            InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text("About"),
                  leading: Icon(
                    Icons.help,
                  ),
                )),
            InkWell(
                onTap: () {
                  _signOut();

                },
                child: const ListTile(
                  title: Text("Logout"),
                  leading: Icon(
                    Icons.help,
                  ),
                )),
          ],
        ),
      ),
      body: Column(
        children: [
          //image carousel begin here
          // image_carousel,

          ///Horizental List view begins here
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                alignment: Alignment.centerLeft, child: new Text('Categories')),
          ),
          HorizontalList(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text("Recent Product")),
          ),
          Flexible(
            child: Container(
              child: Products(),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    });
  }
}
