import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Widgets.dart';

class NewItemContainer extends StatefulWidget {
  String name;
  String imageLink;
  String city;
  String category;
  String price;
  var id;
  NewItemContainer(
      {super.key,
      required this.id,
      required this.category,
      required this.city,
      required this.imageLink,
      required this.name,
      required this.price});

  @override
  State<NewItemContainer> createState() => _NewItemContainerState();
}

class _NewItemContainerState extends State<NewItemContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 170,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(widget.imageLink),
            width: 140,
            fit: BoxFit.cover,
            height: 140,
          ),
          const VerticalDivider(
            width: 10,
            thickness: 2,
            color: Color.fromARGB(255, 113, 143, 224),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Text(widget.category,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700)),
                Text(widget.city,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "BUY NOW",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green),
                    ),
                    Text(
                      "${widget.price} JOD",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                    ),
                    IconButton(
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Scaffold(
                            backgroundColor: Colors.black54,
                            body: Container(
                              color: Colors.white,
                              height: 610,
                              width: double.infinity,
                              child: SafeArea(
                                child: UpdatingButton(
                                  collection: 'items',
                                  price: widget.price,
                                  wantPrise: true,
                                  category: widget.category,
                                  city: widget.city,
                                  imageLink: widget.imageLink,
                                  id: widget.id,
                                  name: widget.name,
                                  Title: "item",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        final docUser = FirebaseFirestore.instance
                            .collection('items')
                            .doc(widget.id);
                        docUser.delete();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
