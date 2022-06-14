import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/products_bloc/products_bloc.dart';
import 'package:untitled1/screens/cart_screen.dart';
import 'package:untitled1/utils/app_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          InkWell(onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(
              create: (context) => ProductsBloc()
                ..add(const CartProducts()),
              child: const CartScreen(),
            )));
            context.read<ProductsBloc>().add(GetProducts());
          },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: Icon(Icons.shopping_cart),
                    ),
                    Positioned(
                      left: 15,
                      top: -10,
                      child: ValueListenableBuilder<int>(
                        valueListenable: AppState().cartCount,
                        builder: (context, value, child) {
                          return CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 10,
                            child: Text(
                              value.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        buildWhen: (previous, current) {
          if(current is UpdatingState){
            return false;
          }else{
            return true;
          }
        },
        builder: (context, state) {
          if (state is ProductsError) {
            return const Center(
              child: Text(
                'Something went wrong',
              ),
            );
          }
          if (state is ProductsSuccess) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 7 / 10, crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 0),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                itemCount: state.productsModel.products.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            state.productsModel.products[index].thumbnail.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$ ${state.productsModel.products[index].price.toString()}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          state.productsModel.products[index].isAdded
                              ? InkWell(
                                  onTap: () {
                                    context
                                        .read<ProductsBloc>()
                                        .add(RemoveFromCart(index: index, id: state.productsModel.products[index].id!));
                                  },
                                  child: SizedBox(
                                    child: Row(
                                      children: const [
                                        Text("REMOVE"),
                                        Icon(Icons.remove),
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    context
                                        .read<ProductsBloc>()
                                        .add(AddToCart(index: index, id: state.productsModel.products[index].id!));
                                  },
                                  child: SizedBox(
                                    child: Row(
                                      children: const [
                                        Text("ADD"),
                                        Icon(Icons.add),
                                      ],
                                    ),
                                  ),
                                )
                        ],
                      )
                    ],
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
