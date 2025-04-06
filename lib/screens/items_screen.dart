import 'package:floxi/models/dasboard_model.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  static const String routeName = '/itemsScreen';

  static Route route(ItemsScreen itemsScreen) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ItemsScreen(itemModelList: itemsScreen.itemModelList),
    );
  }
  final List<ItemModel> itemModelList;

  const ItemsScreen({super.key, required this.itemModelList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Items")),
      body: ListView.builder(
        itemCount: itemModelList.length,
        itemBuilder: (context, index) {
          final ItemModel itemModel = itemModelList[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemModel.itemName??"",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "Co2: ${itemModel.emissions?.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "+${itemModel.points}",
                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: getGradeColor(itemModel.grade ?? ""),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    '${itemModel.grade?.toUpperCase()}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                          ],
                        )
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Alternatives: ${itemModel.suggestedAlternative}",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.grey[400]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
