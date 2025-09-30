import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/product_details/bloc/order_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});
  final largeText =
      "In today’s fast-paced world, technology has become an inseparable part of our daily lives, shaping the way we communicate, work, and even think. From the moment we wake up, we are surrounded by digital tools—smartphones that serve as alarm clocks, calendars, and sources of news, laptops that connect us to work and education, and countless online services that simplify everything from banking to shopping. This constant integration of technology into human activity has not only increased convenience but also introduced new challenges related to privacy, security, and over-reliance on machines. While automation and artificial intelligence continue to create opportunities for innovation, they also raise important questions about employment, ethics, and the future of human interaction. Despite these concerns, technology remains a double-edged sword: it empowers individuals to achieve more, learn faster, and connect globally, while at the same time demanding that societies adapt quickly to its ever-evolving nature. Ultimately, how we choose to use these tools determines whether technology becomes a driving force for progress or a potential barrier to authentic human connection.In today’s fast-paced world, technology has become an inseparable part of our daily lives, shaping the way we communicate, work, and even think. From the moment we wake up, we are surrounded by digital tools—smartphones that serve as alarm clocks, calendars, and sources of news, laptops that connect us to work and education, and countless online services that simplify everything from banking to shopping. This constant integration of technology into human activity has not only increased convenience but also introduced new challenges related to privacy, security, and over-reliance on machines. While automation and artificial intelligence continue to create opportunities for innovation, they also raise important questions about employment, ethics, and the future of human interaction. Despite these concerns, technology remains a double-edged sword: it empowers individuals to achieve more, learn faster, and connect globally, while at the same time demanding that societies adapt quickly to its ever-evolving nature. Ultimately, how we choose to use these tools determines whether technology becomes a driving force for progress or a potential barrier to authentic human connection.";

  final OrderBloc orderBloc = OrderBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 300, child: Placeholder()),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("4.5 ✨"),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 280,

              child: BlocConsumer<OrderBloc, OrderState>(
                bloc: orderBloc,
                listener: (context, state) {},
                builder: (context, state) {
                  // log(
                  //   (state is DescriptionSeeState && state.isSeeMore)
                  //       .toString(),
                  // );
                  return SingleChildScrollView(
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: largeText.length > 400
                                ? largeText.substring(0, 400) +
                                      (state is DescriptionSeeState &&
                                              state.isSeeMore
                                          ? largeText.substring(400)
                                          : "...see more")
                                : largeText +
                                      (state is DescriptionSeeState &&
                                              state.isSeeMore == true
                                          ? "...see less"
                                          : largeText.substring(400)),
                            style: TextStyle(color: Colors.black),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                state is DescriptionSeeState &&
                                        state.isSeeMore == false
                                    ? orderBloc.add(SeeMoreEvent())
                                    : orderBloc.add(SeeLessEvent());
                              },
                          ),
                        ],
                      ),

                      // maxLines: 4,
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            Text("Price: \$XX.XX"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.lightGreen, Colors.limeAccent],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: 32,
                    width: 150,
                    child: Center(
                      child: Text(
                        "Place Order",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
