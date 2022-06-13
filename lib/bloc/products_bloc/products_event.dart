part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class GetProducts extends Equatable {
  @override
  List<Object?> get props => [];
}
