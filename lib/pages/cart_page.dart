import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    //print(cart);
     final total = cart.fold<num>(0, (previousValue, element) => previousValue + element['price'] as num);
     print(total);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart[index];
            
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                    radius: 30,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Delete Product',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: const Text(
                              'Are you sure you want to remove the product from your cart?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<CartProvider>()
                                      .removeProduct(cartItem);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  title: Text(
                    cartItem['title'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text('Size: ${cartItem['size']}'),
                );
              },
            ),
          ),
        if(cart.isNotEmpty)  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total'),
                    Text('$total'),
                  ],
                ),
                ElevatedButton(
                    onPressed: (){
                    },
                      child:
                   Text('CheckOut')
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
