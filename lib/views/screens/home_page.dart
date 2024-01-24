import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_demo/controllers/db_controller.dart';
import 'package:sql_demo/modals/hotel_modal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQL Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<DbController>(
          builder: (context, pro, _) {
            return pro.allHotels.isNotEmpty
                ? ListView.builder(
                    itemCount: pro.allHotels.length,
                    itemBuilder: (context, index) {
                      Hotel hotel = pro.allHotels[index];

                      return Card(
                        child: ExpansionTile(
                          leading: Text("${hotel.id}"),
                          title: Text(hotel.name),
                          trailing: Text("${hotel.star}"),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    pro.delete(hotel: hotel);
                                  },
                                  child: Text("Delete"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    hotel.name = "New Name";
                                    pro.update(hotel: hotel);
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Provider.of<DbController>(context, listen: false).insert(
            hotel: Hotel(
              101,
              "Padmavati Bhojnalay",
              3,
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}
