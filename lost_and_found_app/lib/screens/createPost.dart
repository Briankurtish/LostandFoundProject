import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/remote_data_source/firestore_helper.dart';

import '../models/post_model.dart';
import '../widgets/long_button.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    itemNameController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: itemNameController,
                decoration: InputDecoration(
                  hintText: "Enter Item name",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Enter Location",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Enter description",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomLongButton(
                text: "Upload Post",
                onPressed: () {
                  FirestoreHelper.upload(PostModel(
                    itemNameController.text,
                    locationController.text,
                    descriptionController.text,
                  ));
                },
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<List<PostModel>>(
              stream: FirestoreHelper.read(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("some error Occurred"),
                  );
                }

                if (snapshot.hasData) {
                  final postData = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: postData!.length,
                      itemBuilder: (context, index) {
                        final singlePost = postData[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                shape: BoxShape.circle,
                              ),
                            ),
                            title: Text("${singlePost.itemName}"),
                            subtitle: Text("${singlePost.location}"),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
