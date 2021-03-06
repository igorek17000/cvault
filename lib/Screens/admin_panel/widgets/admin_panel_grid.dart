import 'package:cvault/Screens/admin_panel/pages/customer_management/customer_management.dart';
import 'package:cvault/Screens/admin_panel/pages/dealer_management/dealer_management_page.dart';
import 'package:cvault/Screens/reporting_screen.dart';
import 'package:cvault/Screens/advertisment.dart';

import 'package:flutter/material.dart';

class AdminPanelGrid extends StatelessWidget {
  const AdminPanelGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DealerManagementPage(),
                  ),
                );
              },
              child: Column(
                children: [
                  const Text(
                    "Dealer\n Management",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(25),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 165, 231, 243),
                      ),
                    ),
                    child: Image.asset(
                      "assets/handshake(1).png",
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomerManagementPage(),
                  ),
                );
              },
              child: Column(
                children: [
                  const Text(
                    "Customer\nManagement",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(25),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 165, 231, 243),
                      ),
                    ),
                    child: Image.asset("assets/user.png", color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Advertisment(),
                  ),
                );
              },
              child: Column(
                children: [
                  const Text(
                    "Advertising \n Management",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 165, 231, 243),
                      ),
                    ),
                    child: Image.asset(
                      "assets/newspaper.png",
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Reporting(),
                  ),
                );
              },
              child: Column(
                children: [
                  const Text(
                    "Reporting",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(25),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 165, 231, 243),
                      ),
                    ),
                    child: Image.asset(
                      "assets/line-chart.png",
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
