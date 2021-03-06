import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cvault/Screens/settting.dart';
import 'package:cvault/providers/home_provider.dart';
import 'package:cvault/models/home_state.dart';
import 'package:cvault/Screens/home/widgets/margin_selector.dart';
import 'package:cvault/providers/profile_provider.dart';
import 'package:cvault/Screens/profile/widgets/profile_page.dart';
import 'package:cvault/constants/user_types.dart';
import 'package:cvault/widgets/usd_inr_toggle.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../drawer.dart';

/// Page to view crypto tickers, user details and Ads
class DashboardPage extends StatefulWidget {
  ///
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

/// @suraj96506 document this
late http.Response res;

///
dynamic add;

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    getadds();
  }

  getadds() async {
    res = await http.get(
      Uri.parse(
        "https://cvault-backend.herokuapp.com/advertisment/get-link",
      ),
    );

    setState(() {
      add = jsonDecode(res.body);
      log(add[0]['link'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: scaffoldKey,
      endDrawer: const MyDrawer(),
      backgroundColor: const Color(0xff1E2224),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: Consumer<ProfileChangeNotifier>(
          builder: (context, profileNotifier, _) {
            var userType = profileNotifier.profile.userType;
            if (userType.isEmpty) {
              return const Text('');
            }

            return Text(
              "Hello, ${profileNotifier.profile.firstName.isEmpty ? 'User' : profileNotifier.profile.firstName}.\n Welcome to ${userType[0].toUpperCase() + userType.substring(1)} Dashboard",
              textAlign: TextAlign.center,
              maxLines: 3,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 20,
              ),
            );
          },
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => ProfilePage()),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.transparent,
              foregroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2020/06/01/22/23/eye-5248678__340.jpg",
              ),
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.menu),
                color: Colors.white,
                iconSize: 30,
              );
            },
          ),
        ],
      ),
      body: Consumer<ProfileChangeNotifier>(
        builder: (context, profileNotifier, _) {
          var userType = profileNotifier.profile.userType;

          return Consumer<HomeStateNotifier>(
            builder: (context, homeStateNotifier, _) {
              final state = homeStateNotifier.state;

              return state.loadStatus == LoadStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      key: UniqueKey(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            width: 0.5,
                            color: const Color.fromARGB(255, 165, 231, 243),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoG97VgQYJGXN8kDJkOMvh79mgLvO5iEfVWA&usqp=CAU",
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Settings(),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                          5,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          '1 ${state.selectedCurrencyKey.toUpperCase()}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const USDToINRToggle(),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              userType == UserTypes.admin
                                  ? 'Local price (Wazirx)'
                                  : 'Buy Price',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            homeStateNotifier.state is HomeInitial
                                ? const Text("Loading")
                                : Text(
                                    state.cryptoCurrencies.isEmpty
                                        ? ''
                                        : (state.isUSD
                                            ? '\$${homeStateNotifier.currentCryptoCurrency().wazirxPrice.toStringAsFixed(2)}'
                                            : '???${homeStateNotifier.currentCryptoCurrency().wazirxPrice.toStringAsFixed(2)}'),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 32,
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userType == UserTypes.admin
                                          ? 'Global price (Kraken)'
                                          : 'Sell Price',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    homeStateNotifier.state is HomeInitial
                                        ? const Text("Loading")
                                        : Text(
                                            state.cryptoCurrencies.isEmpty
                                                ? ''
                                                : (state.isUSD ? '\$' : '???') +
                                                    homeStateNotifier
                                                        .currentCryptoCurrency()
                                                        .krakenPrice
                                                        .toStringAsFixed(2),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 32,
                                            ),
                                          ),
                                  ],
                                ),
                                userType == UserTypes.admin
                                    ? Column(
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const Text(
                                                'Difference',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                homeStateNotifier
                                                    .state.difference
                                                    .toStringAsFixed(2),
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            userType == UserTypes.admin
                                ? const MarginSelector()
                                : Container(),
                            const SizedBox(
                              height: 10,
                            ),
                            userType == UserTypes.admin
                                ? Container()
                                : Visibility(
                                    visible: add == null ? false : true,
                                    child: Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text('AD'),
                                            Center(
                                              child: add == null
                                                  ? Image.asset(
                                                      "assets/test_ad.gif",
                                                    )
                                                  : Image.network(
                                                      add[0]["link"],
                                                    ),
                                            ),
                                            const Text('AD'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
