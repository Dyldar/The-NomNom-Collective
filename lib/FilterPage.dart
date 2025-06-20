import 'package:flutter/material.dart';
import 'package:the_nomnom_collective/HomePage.dart';
import 'datastorage.dart'; // DatabaseHelper sınıfını import ediyoruz

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key});

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  bool isBreakfastSelected = false;
  bool isLunchDinnerSelected = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allFoodItems = [];
  List<Map<String, dynamic>> _filteredFoodItems = [];
  List<String> restrictedFoods = [];
  List<Map<String, dynamic>> diseases = [];
  List<int> selectedDiseaseIds = [];
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _loadFoodItems();
    _loadDiseases();
  }

  Future<void> _loadFoodItems() async {
    final db = await DatabaseHelper
        .instance.database; // Veritabanı bağlantısını bekleyin
    final result = await db.query('food');
    setState(() {
      _allFoodItems = result;
      _filteredFoodItems = result;
    });
  }

  Future<void> _loadDiseases() async {
    final db = await DatabaseHelper
        .instance.database; // Veritabanı bağlantısını bekleyin
    final result = await db.query('diseases');
    setState(() {
      diseases = result;
    });
  }

  Future<void> _loadRestrictedFoods() async {
    final db = await DatabaseHelper
        .instance.database; // Veritabanı bağlantısını bekleyin
    restrictedFoods.clear();

    for (var diseaseId in selectedDiseaseIds) {
      final result = await db.query(
        'disease_restricted_foods',
        where: 'disease_id = ?',
        whereArgs: [diseaseId],
      );
      restrictedFoods
          .addAll(result.map((item) => item['food_name'] as String).toList());
    }

    setState(() {
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredFoodItems = _allFoodItems.where((item) {
        final isInCategory =
            selectedCategory.isEmpty || item['category'] == selectedCategory;
        final isNotRestricted = !restrictedFoods.contains(item['name']);
        return isInCategory && isNotRestricted;
      }).toList();
    });
  }

  void _filterFoodItems(String query) {
    final lowerCaseQuery = query.toLowerCase();

    setState(() {
      _filteredFoodItems = _allFoodItems.where((item) {
        final isInCategory =
            selectedCategory.isEmpty || item['category'] == selectedCategory;
        final isNotRestricted = !restrictedFoods.contains(item['name']);
        final matchesQuery =
            (item['name'] as String?)?.toLowerCase().contains(lowerCaseQuery) ??
                false;
        return isInCategory && isNotRestricted && matchesQuery;
      }).toList();
    });
  }

  void _updateCategoryFilter(String category) {
    setState(() {
      selectedCategory = category;
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Homepage())
          ),
        ),
        title: const Text('Food Search!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for Food...',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterFoodItems,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isBreakfastSelected = !isBreakfastSelected;
                      if (isBreakfastSelected) {
                        isLunchDinnerSelected = false;
                        _updateCategoryFilter('Breakfast');
                      } else {
                        selectedCategory = '';
                        _applyFilters();
                      }
                    });
                  },
                  child: Text(
                    'Breakfast',
                    style: TextStyle(
                      color: isBreakfastSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isBreakfastSelected ? Colors.blue : Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLunchDinnerSelected = !isLunchDinnerSelected;
                      if (isLunchDinnerSelected) {
                        isBreakfastSelected = false;
                        _updateCategoryFilter('Lunch/Dinner');
                      } else {
                        selectedCategory = '';
                        _applyFilters();
                      }
                    });
                  },
                  child: Text(
                    'Lunch/Dinner',
                    style: TextStyle(
                      color:
                          isLunchDinnerSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isLunchDinnerSelected ? Colors.blue : Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Select Diseases'),
                        content: SizedBox(
                          width: double.minPositive,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: diseases.length,
                            itemBuilder: (context, index) {
                              final disease = diseases[index];
                              final isSelected =
                                  selectedDiseaseIds.contains(disease['id']);
                              return CheckboxListTile(
                                title: Text(disease['name']),
                                value: isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedDiseaseIds.add(disease['id']);
                                    } else {
                                      selectedDiseaseIds.remove(disease['id']);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _loadRestrictedFoods(); // restricted foods'ı yükleyin
                            },
                            child: const Text('Apply'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Disease'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedDiseaseIds.isNotEmpty
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredFoodItems.length,
                itemBuilder: (context, index) {
                  final foodItem = _filteredFoodItems[index];
                  return ListTile(
                    title: Text(foodItem['name'] ?? 'No Name'),
                    subtitle: Text(foodItem['ingredients'] ?? 'No Ingredients'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
