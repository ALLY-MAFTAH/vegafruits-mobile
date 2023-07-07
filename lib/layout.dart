// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vegafruits/screens/customers_page.dart';
import 'package:vegafruits/screens/home_page.dart';
import 'package:vegafruits/screens/orders_page.dart';
import 'package:vegafruits/screens/sales_page.dart';
import 'package:vegafruits/screens/stocks_page.dart';

import 'components/custom_drawer.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with TickerProviderStateMixin {
  late AnimationController _drawerAnimationController;
  late Animation<double> _drawerAnimation;

  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      if (_isDrawerOpen) {
        _drawerAnimationController.forward();
      } else {
        _drawerAnimationController.reverse();
      }
    });
  }

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _drawerAnimation = CurvedAnimation(
      parent: _drawerAnimationController,
      curve: Curves.easeInOut,
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _drawerAnimationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleDrawer,
        ),
        title: Text(_currentIndex == 0
            ? "Home"
            : _currentIndex == 1
                ? "Orders"
                : _currentIndex == 2
                    ? "Sales"
                : _currentIndex == 3
                    ? "Stock"
                    : "Customers"),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (_isDrawerOpen) {
                _toggleDrawer();
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              transform: Matrix4.translationValues(
                _isDrawerOpen ? MediaQuery.of(context).size.width * 0.6 : 0,
                0,
                0,
              ),
              child: Scaffold(
                body: IndexedStack(
                  index: _currentIndex,
                  children: [
                    HomePage(),
                    OrdersPage(),
                    SalesPage(),
                    StocksPage(),
                    CustomersPage(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: _isDrawerOpen ? 0 : -MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-1, 0),
                end: Offset(0, 0),
              ).animate(_drawerAnimation),
              child: GestureDetector(
                  onTap: () {
                    if (_isDrawerOpen) {
                      _toggleDrawer();
                    }
                  },
                  child: CustomDrawer()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizeTransition(
        sizeFactor: _animation,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Sales',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'Stock',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2 ),
              label: 'Customers',
            ),
          ],
        ),
      ),
    );
  }
}
