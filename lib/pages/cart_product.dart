import 'package:flutter/material.dart';

class Cart_product extends StatefulWidget {
  const Cart_product({Key? key}) : super(key: key);

  @override
  _Cart_productState createState() => _Cart_productState();
}

class _Cart_productState extends State<Cart_product> {
  var Product_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "assets/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1
    },
    {
      "name": "Shoes",
      "picture": "assets/hills1.jpeg",
      "price": 50,
      "size": "7",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Shoes",
      "picture": "assets/hills1.jpeg",
      "price": 50,
      "size": "7",
      "color": "Red",
      "quantity": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Product_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: Product_on_the_cart[index]["name"],
            cart_prod_color: Product_on_the_cart[index]["color"],
            cart_prod_qtv: Product_on_the_cart[index]['quantity'],
            cart_prod_price: Product_on_the_cart[index]["price"],
            cart_prod_size: Product_on_the_cart[index]['size'],
            cart_prod_pricture: Product_on_the_cart[index]['picture'],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_pricture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  late final cart_prod_qtv;

  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_pricture,
      this.cart_prod_price,
      this.cart_prod_size,
      this.cart_prod_color,
      this.cart_prod_qtv});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //===leading section====
        leading: new Image.asset(
          cart_prod_pricture,
          width: 80.0,
          height: 80.0,
        ),

        //==================TiTLE SECTION=====
        title: Text(cart_prod_name),
        ////////////// SUBTITLE SECTION ===============

        subtitle: new Column(
          children: [
            new Row(
              children: [
                //this section is for the size
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    cart_prod_size,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                //====this section  of for  the product color   ======
                new Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: new Text("Color:"),
                ),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: new Text(
                      cart_prod_color,
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ),

            ///this section for thr product proce
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                "\$${cart_prod_price}",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        trailing: Column(
          children: [
            Flexible(
                child: IconButton(
              padding: const EdgeInsets.only(bottom: 20),
              icon: const Icon(Icons.arrow_drop_up),
              onPressed: () {},
            )),
            Text("$cart_prod_qtv"),
            Flexible(
                child: IconButton(
                    padding: EdgeInsets.only(top: 14),
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {})),
          ],
        ),
      ),
    );
  }
}
