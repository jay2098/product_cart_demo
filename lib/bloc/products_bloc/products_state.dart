part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductsState {
  @override
  List<Object?> get props => [];
}

class ProductsSuccess extends ProductsState {
  final ProductsModel productsModel;

  const ProductsSuccess({required this.productsModel});

  ProductsSuccess copyWith({
    ProductsModel? productsModel,
  }) {
    return ProductsSuccess(productsModel: productsModel ?? this.productsModel);
  }

  @override
  List<Object?> get props => [productsModel];
}

class CartSuccess extends ProductsState {
  final List<Product> cartProducts;

  const CartSuccess({required this.cartProducts});

  CartSuccess copyWith({
    List<Product>? productsModel,
  }) {
    return CartSuccess(cartProducts: productsModel ?? cartProducts);
  }

  @override
  List<Object?> get props => [cartProducts];
}

class ProductsError extends ProductsState {
  @override
  List<Object?> get props => [];
}

class UpdatingState extends ProductsState {
  @override
  List<Object?> get props => [];
}
