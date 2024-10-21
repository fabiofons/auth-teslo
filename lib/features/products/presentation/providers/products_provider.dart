import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductState {
  final bool isLastPage;
  final bool isLoading;
  final int limit;
  final int offset;
  final List<Product> products;

  ProductState(
      {this.isLastPage = false,
      this.isLoading = false,
      this.limit = 10,
      this.offset = 0,
      this.products = const []});

  ProductState copyWith(bool? isLastPage, bool? isLoading, int? limit,
          int? offset, List<Product>? products) =>
      ProductState(
        isLastPage: isLastPage ?? this.isLastPage,
        isLoading: isLoading ?? this.isLoading,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        products: products ?? this.products,
      );
}
