import 'package:flutter/material.dart';

void main() {
  runApp(ProductCatalogApp());
}

class ProductCatalogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductCatalogScreen(),
      debugShowCheckedModeBanner: false, // Set this to false
    );
  }
}

class ProductCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag',
          style: TextStyle(
            color: Colors.black, // Change this color to your desired text color
            fontSize: 24, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Set the text to be bold
          ),
        ),
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100], // Set the background color
      body: ProductList(),
      bottomNavigationBar: CheckoutButton(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(
      name: 'Pullover',
      price: 50.0,
      imageUrl: 'https://m.media-amazon.com/images/I/81CZWlad4cL._AC_UL320_.jpg',
      size: 'M', // Specify the size for this product
      color: 'Orange & white', // Specify the color for this product
    ),
    Product(
      name: 'T-Shirt',
      price: 30.0,
      imageUrl: 'https://m.media-amazon.com/images/I/718oQJkI06L._AC_UL320_.jpg',
      size: 'L', // Specify a different size for this product
      color: 'White', // Specify a different color for this product
    ),
    Product(
      name: 'Casual',
      price: 40.0,
      imageUrl: 'https://m.media-amazon.com/images/I/91s8OhaIpCL._AC_UL320_.jpg',
      size: 'L', // Specify a different size for this product
      color: 'Greywhite', // Specify a different color for this product
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10); // Add 10 units of separation between cards
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Stack(
            children: [
              ListTile(
                leading: Image.network(widget.product.imageUrl),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.name),
                        Text('Size: ${widget.product.size} | Color: ${widget.product.color}'), // Modify this line
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 0) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                        ),
                        Text('$quantity'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 32.0), // Add some space
                    Text('\$${widget.product.price.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Icon(Icons.more_vert), // Star icon in top right corner
              ),
            ],
          ),
        ),
      ),
    );
  }
}






class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String size; // Add size property
  final String color; // Add color property

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.size,
    required this.color,
  });
}

class CheckoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalCost = 0.0;
    for (var product in _ProductListState().products) {
      totalCost += product.price * _ProductCardState().quantity;
    }

    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total Amount: \$${totalCost.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity, // Make the button take full width
            child: ElevatedButton(
              onPressed: () {
                // Show a dialog with a congratulatory message
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Congratulations!'),
                      content: Text('Your order has been placed.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'CHECK OUT',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 18.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Button background color
                padding: EdgeInsets.all(16.0), // Add padding to the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Adjust the value for roundness
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}