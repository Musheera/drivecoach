import 'package:flutter/material.dart';
import 'register_tabs/trainee_register.dart';
import 'register_tabs/trainer_register.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Screen"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "AS TRAINEE",
            ),
            Tab(
              text: "AS TRAINER",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          TraineeRegister(),
          TrainerRegister(),
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }
}
