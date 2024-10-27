
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

class ProductScreen extends ConsumerWidget {
  final String productId;

  const ProductScreen({
    required this.productId, 
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final productState = ref.watch(productProvider(productId));
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.camera_alt_outlined))
        ],
      ),
      body: Center(
        child: Text(productState.product?.title ?? 'Loading'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.save_as_outlined),        
      ),
    );
  }
}