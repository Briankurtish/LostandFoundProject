import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  final String username;

  const CreatePostScreen({required this.username});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  String _errorMessage = '';
  bool _isLoading = false;

  void _uploadPost() async {
    if (_imageFile == null) {
      setState(() {
        _errorMessage = 'Please select an image';
      });
      return;
    }

    if (_addressController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please provide address and description';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Upload the image to Firebase Storage
        String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef =
            FirebaseStorage.instance.ref().child('images/$imageFileName');
        await storageRef.putFile(_imageFile!);

        // Get the download URL of the uploaded image
        String imageUrl = await storageRef.getDownloadURL();

        // Create a new document in the "posts" collection
        await FirebaseFirestore.instance.collection('posts').add({
          'username': widget.username,
          'imageUrl': imageUrl,
          'address': _addressController.text,
          'description': _descriptionController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Navigate back to the HomeScreen
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error uploading post';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _getImageFromGallery,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.image,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _uploadPost,
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Upload Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
