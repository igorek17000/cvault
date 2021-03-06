import 'package:cvault/Screens/settting.dart';
import 'package:cvault/Screens/quote/widgets/buy_sell_toggle.dart';
import 'package:cvault/Screens/quote/widgets/quantity.dart';
import 'package:cvault/Screens/quote/widgets/send_quote_box.dart';
import 'package:cvault/constants/theme.dart';
import 'package:cvault/models/home_state.dart';
import 'package:cvault/providers/home_provider.dart';
import 'package:cvault/providers/profile_provider.dart';
import 'package:cvault/providers/quote_provider.dart';
import 'package:cvault/widgets/usd_inr_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../drawer.dart';

class Quote extends StatefulWidget {
  const Quote({Key? key}) : super(key: key);

  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  bool price = true;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const MyDrawer(),
      backgroundColor: const Color(0xff1E2224),
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text("Quote"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(Icons.menu),
            color: Colors.white,
            iconSize: 30,
          ),
        ],
      ),
      body: Consumer<HomeStateNotifier>(
        builder: (context, homeStateNotifier, _) {
          final state = homeStateNotifier.state;
          if (state.loadStatus == LoadStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ThemeColors.lightGreenAccentColor,
              ),
            );
          }

          return state.loadStatus == LoadStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  key: UniqueKey(),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      price = true;
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    margin: const EdgeInsets.all(5),
                                    color: price ? Colors.white : Colors.black,
                                    child: Center(
                                      child: Text(
                                        "Price",
                                        style: TextStyle(
                                          color: price
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      price = false;
                                    });
                                  },
                                  child: Container(
                                    color: !price ? Colors.white : Colors.black,
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    margin: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        "Quantity",
                                        style: TextStyle(
                                          color: !price
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Settings(),
                                  ),
                                );
                              },
                              child: Consumer<HomeStateNotifier>(
                                builder: (context, notifier, _) {
                                  return Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.blue,
                                        backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoG97VgQYJGXN8kDJkOMvh79mgLvO5iEfVWA&usqp=CAU",
                                        ),
                                      ),
                                      Text(
                                        notifier.state.selectedCurrencyKey
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const USDToINRToggle(),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Cost Price",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Consumer<QuoteProvider>(
                                  builder: (context, quoteProvider, __) {
                                    return Flexible(
                                      child: Center(
                                        child: homeStateNotifier.state
                                                is HomeInitial
                                            ? const Text("Loading")
                                            : Text(
                                                state.cryptoCurrencies.isEmpty
                                                    ? ''
                                                    : '${homeStateNotifier.state.isUSD ? '\$' : '???'}${quoteProvider.transaction.costPrice.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const BuySellToggle(),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "Margin (%)",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    /// TODO: change margin
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    width: 120,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                          width: 1.5,
                                          color: const Color.fromARGB(
                                            255,
                                            165,
                                            231,
                                            243,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '5.00%',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Quantity(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SendQuoteBox(isPriceSelected: price),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
