import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/features/cart/presentation/views/cart_view.dart';
import 'package:training_book_store/features/profile/presentation/views/profile_view.dart';
import 'package:training_book_store/features/search/presentation/views/search_view.dart';
import 'package:training_book_store/features/wishlist/presentation/views/wishlist_view.dart';
import 'package:training_book_store/features/home/presentation/views/Home_view.dart';

class NavigationBarView extends StatefulWidget {
  const NavigationBarView({super.key, this.page});
  final int? page;
  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.page ?? 0;
  }

  int selectedIndex = 0;
  List<Widget> pages = [
    const HomeView(),
    const SearchView(),
    const WishlistView(),
    CartView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        itemPadding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        selectedColorOpacity: 0.25,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.home_filled,
              size: 28,
            ),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 20),
            ),
            selectedColor: AppColors.purple,
          ),
      
          /// search
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.search,
              size: 28,
            ),
            title: const Text(
              "Search",
              style: TextStyle(fontSize: 20),
            ),
            selectedColor: AppColors.purple,
          ),
      
          /// wishlist
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.favorite_border,
              size: 28,
            ),
            title: const Text(
              "Wishlist",
              style: TextStyle(fontSize: 20),
            ),
            selectedColor: AppColors.purple,
          ),
      
          /// cart
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.shopping_cart_rounded,
              size: 28,
            ),
            title: const Text(
              "Cart",
              style: TextStyle(fontSize: 20),
            ),
            selectedColor: AppColors.purple,
          ),
      
          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.person_2_sharp,
              size: 28,
            ),
            title: const Text(
              "Profile",
              style: TextStyle(fontSize: 20),
            ),
            selectedColor: AppColors.purple,
          ),
        ],
      ),
    );
  }
}
