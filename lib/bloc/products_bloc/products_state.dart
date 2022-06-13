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
  @override
  List<Object?> get props => [];
}

class ProductsError extends ProductsState {
  @override
  List<Object?> get props => [];
}
