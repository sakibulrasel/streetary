import 'package:flutter/material.dart';

/**
 * Created by sakibul.haque on 01,July,2021
 */

getBottomNavigation({required IconData icon, required String label})
{
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}