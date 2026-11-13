import 'package:flutter/material.dart';
import '../models/cruise_destination.dart';

class CruiseBookingViewModel extends ChangeNotifier {
  final CruiseDestination _destination = CruiseDestination(
    name: 'Rajang River Express Cruise',
    location: 'Sibu Waterfront, Sarawak',
    landmarkLabel: 'Sibu Esplanade Landmark',
    description:
    'Experience the heart of Sibu along Malaysia\'s longest river, the Rajang. '
        'Cruise past historic temples, timber hubs, and traditional waterfront settlements '
        'while experiencing authentic Sarawakian hospitality.',
    imageUrl:
    'https://images.unsplash.com/photo-1544644181-1484b3fdfc62?w=800',
    starCount: 43,
  );

  DateTime _selectedDate = DateTime(2026, 11, 15);
  String _selectedPackage = 'Sunset Cruise';
  bool _isDarkMode = false;

  // 手册第 4 页指定的 5 个游船套餐
  final List<String> _packages = [
    'Private River Cruise',
    'Sunset Cruise',
    'Sunrise Cruise',
    'Rural Cruise',
    'SMI Park Cruise',
  ];

  // Getters
  CruiseDestination get destination => _destination;
  DateTime get selectedDate => _selectedDate;
  String get selectedPackage => _selectedPackage;
  List<String> get packages => _packages;
  bool get isDarkMode => _isDarkMode;

  // 动态点击星星数 (Before & After)
  void toggleFavorite() {
    if (_destination.isFavorite) {
      _destination.starCount -= 1;
      _destination.isFavorite = false;
    } else {
      _destination.starCount += 1;
      _destination.isFavorite = true;
    }
    notifyListeners();
  }

  // 更新预订日期
  void setBookingDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  // 更新套餐选择
  void setPackage(String newPackage) {
    _selectedPackage = newPackage;
    notifyListeners();
  }

  // 切换深浅色主题
  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}