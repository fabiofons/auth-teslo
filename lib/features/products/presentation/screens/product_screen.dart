import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductScreen({required this.productId, super.key});

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends ConsumerState<ProductScreen> {

  @override
  void initState() {
    ref.read(productProvider(widget.productId).notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit product'),),
      body: Center(child: Text(widget.productId),)
    );
  }
}
