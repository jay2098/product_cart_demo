import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled1/models/products_model.dart';

import '../../utils/app_state.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<GetProducts>(_getProducts);
    on<AddToCart>(_addToCart);
    on<RemoveFromCart>(_removeFromCart);
    on<CartProducts>(_cartProducts);
  }

  void _getProducts(GetProducts getProducts, Emitter<ProductsState> emit) {
    try {
      if(getProducts.refreshProducts){
        AppState().products = ProductsModel.fromJson(AppState().productData);
      }else{
        emit(UpdatingState());
      }

      emit(ProductsSuccess(productsModel: AppState().products));
    } catch (e) {
      emit(ProductsError());
    }
  }

  void _addToCart(AddToCart addToCart, Emitter<ProductsState> emit) {
    final ProductsState currentState = state;
    try {
      emit(UpdatingState());
      AppState().cartProducts.add(AppState().products.products[addToCart.index]);
      print(AppState().cartProducts);
      AppState().cartCount.value = AppState().cartProducts.length;

      AppState().products.products[addToCart.index].isAdded = true;

      if (currentState is ProductsSuccess) {
        emit(currentState.copyWith(
          productsModel: AppState().products,
        ));
      } else {
        emit(ProductsSuccess(productsModel: AppState().products));
      }
    } catch (e) {
      emit(ProductsError());
    }
  }

  void _removeFromCart(RemoveFromCart removeFromCart, Emitter<ProductsState> emit) {
    final ProductsState currentState = state;
    try {
      emit(UpdatingState());
      if (removeFromCart.fromCart) {
        AppState().cartProducts.removeAt(removeFromCart.index);
        AppState().cartCount.value = AppState().cartProducts.length;
        final productIndex = AppState().products.products.indexWhere((element) => element.id == removeFromCart.id);
        AppState().products.products[productIndex].isAdded = false;
        if(currentState is CartSuccess){
          emit(currentState.copyWith(
            productsModel: AppState().cartProducts,
          ));
        } else {
          emit(CartSuccess(cartProducts: AppState().cartProducts));
        }
      } else {
        AppState().cartProducts.remove(AppState().products.products[removeFromCart.index]);
        AppState().cartCount.value = AppState().cartProducts.length;

        final productIndex = AppState().products.products.indexWhere((element) => element.id == removeFromCart.id);
        AppState().products.products[productIndex].isAdded = false;

        if (currentState is ProductsSuccess) {
          emit(currentState.copyWith(
            productsModel: AppState().products,
          ));
        } else {
          emit(ProductsSuccess(productsModel: AppState().products));
        }
      }
    } catch (e) {
      emit(ProductsError());
    }
  }

  void _cartProducts(CartProducts cartProductsView, Emitter<ProductsState> emit) {
    final ProductsState currentState = state;
    try {
      print('readblc');
      print(AppState().cartProducts);
      emit(CartSuccess(cartProducts: AppState().cartProducts));
    } catch (e) {
      emit(ProductsError());
    }
  }
}
