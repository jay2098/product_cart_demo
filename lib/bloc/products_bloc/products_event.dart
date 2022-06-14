part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class GetProducts extends ProductsEvent {
  final bool refreshProducts;

  const GetProducts({this.refreshProducts = false});
  @override
  List<Object?> get props => [];
}

class AddToCart extends ProductsEvent {
  final int index;
  final int id;

  const AddToCart({required this.index, required this.id});

  @override
  List<Object?> get props => [];
}

class RemoveFromCart extends ProductsEvent {
  final int index;
  final int id;
  final bool fromCart;

  const RemoveFromCart({required this.index, required this.id,this.fromCart = false});

  @override
  List<Object?> get props => [];
}

class CartProducts extends ProductsEvent{

  const CartProducts();
  @override
  List<Object?> get props => [];
}