import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/utils/app_state.dart';

import '../bloc/products_bloc/products_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<ProductsBloc>().add(const CartProducts());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart'
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        buildWhen: (previous, current) {
          if (current is UpdatingState) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state is CartSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //     childAspectRatio: 7 / 10, crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 0),
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      itemCount: state.cartProducts.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  state.cartProducts[index].thumbnail.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.cartProducts[index].title.toString()),
                                  Text(
                                    "\$ ${state.cartProducts[index].price.toString()}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                context.read<ProductsBloc>().add(
                                    RemoveFromCart(id: state.cartProducts[index].id!, index: index, fromCart: true));
                              },
                              child: const Text("Delete"),
                            )
                          ],
                        );
                      }),
                ),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: "Payment Successful",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    height: kToolbarHeight,
                    color: Colors.indigo,
                    child: const Center(
                      child: Text(
                        "PAY",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
