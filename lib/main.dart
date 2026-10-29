import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const Lab02HomePage(),
    );
  }
}

class Lab02HomePage extends StatefulWidget {
  const Lab02HomePage({super.key});

  @override
  State<Lab02HomePage> createState() => _Lab02HomePageState();
}

class _Lab02HomePageState extends State<Lab02HomePage> {
  DateTime _selectedDate = DateTime(2026, 10, 28);
  String _selectedRole = 'Slytherin';
  final List<String> _roles = ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff'];

  // 1. Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // 2. Cupertino Date Picker (Modal Sheet)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('Done'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Cupertino Picker (Wheel)
  void _showCupertinoRolePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('Done'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 36,
                scrollController: FixedExtentScrollController(
                  initialItem: _roles.indexOf(_selectedRole),
                ),
                onSelectedItemChanged: (int index) {
                  setState(() => _selectedRole = _roles[index]);
                },
                children: _roles.map((role) => Center(child: Text(role))).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  // 竖屏布局：所有组件向下依次垂直滚动
  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const StudentDetailsSection(),
        const SizedBox(height: 16),
        const TitleSection(
          name: 'Hogwarts School of Witchcraft and Wizardry',
          location: 'Hogsmeade, Scotland',
          starCount: 41,
        ),
        const SizedBox(height: 16),
        const ImageSection(),
        const SizedBox(height: 16),
        _buildPickersSection(),
      ],
    );
  }

  // 横屏布局：左右分栏排列，防止内容溢出
  Widget _buildLandscapeView() {
    return Row(
      children: [
        const Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                StudentDetailsSection(),
                SizedBox(height: 16),
                ImageSection(),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const TitleSection(
                name: 'Hogwarts School of Witchcraft and Wizardry',
                location: 'Hogsmeade, Scotland',
                starCount: 41,
              ),
              const SizedBox(height: 16),
              _buildPickersSection(),
            ],
          ),
        ),
      ],
    );
  }

  // 交互选择器卡片 (Exercise 2.2 Pickers)
  Widget _buildPickersSection() {
    final String formattedDate =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text('Selected Date: $formattedDate', style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('Selected House: $_selectedRole', style: const TextStyle(fontWeight: FontWeight.w500)),
            const Divider(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_month),
              label: const Text('Material Date Picker'),
              onPressed: () => _selectMaterialDate(context),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.date_range),
              label: const Text('Cupertino Date Picker (Modal Sheet)'),
              onPressed: () => _showCupertinoDatePicker(context),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Material Dropdown:'),
                DropdownButton<String>(
                  value: _selectedRole,
                  items: _roles.map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedRole = newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text('Cupertino House Wheel Picker'),
              onPressed: () => _showCupertinoRolePicker(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== 子组件拆分 (Exercise 2.1) ====================

// 1. Lab 01 的个人信息卡片
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/photo.jpg'),
            ),
            SizedBox(height: 12),
            Text(
              'CHIU SIEW SENG',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Student ID: BCS24020043',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Divider(height: 24),
            Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              '"To become an successful person"',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.indigo),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. 实验手册 Exercise 2.1 要求的 TitleSection
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.red[500]),
            const SizedBox(width: 4),
            Text('$starCount'),
          ],
        ),
      ),
    );
  }
}

// 3. 湖泊/风景展示图
class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        'https://raw.githubusercontent.com/flutter/website/main/examples/layout/lakes/step5/images/lake.jpg',
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 180,
          color: Colors.grey[300],
          child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
        ),
      ),
    );
  }
}