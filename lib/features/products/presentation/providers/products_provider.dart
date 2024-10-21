import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'products_repository_provider.dart';

final productsProvider =
    StateNotifierProvider<ProductsProvider, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ProductsProvider(productsRepository: productsRepository);
});

class ProductsProvider extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;

  ProductsProvider({required this.productsRepository})
      : super(ProductsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductsByPage(
        limit: state.limit, offset: state.offset);

    if (products.isEmpty) {
      state = state.copyWith(isLastPage: true, isLoading: false);
    }

    state = state.copyWith(
      isLoading: false,
      isLastPage: false,
      offset: state.offset + 10,
      products: [...state.products, ...products],
    );
  }
}

class ProductsState {
  final bool isLastPage;
  final bool isLoading;
  final int limit;
  final int offset;
  final List<Product> products;

  ProductsState(
      {this.isLastPage = false,
      this.isLoading = false,
      this.limit = 10,
      this.offset = 0,
      this.products = const []});

  ProductsState copyWith(
          {bool? isLastPage,
          bool? isLoading,
          int? limit,
          int? offset,
          List<Product>? products}) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        isLoading: isLoading ?? this.isLoading,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        products: products ?? this.products,
      );
}
