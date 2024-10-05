
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/service/storge_service.dart';
import 'package:instagram_app/core/utils/funcation.dart';
import 'package:instagram_app/core/utils/spaces.dart';
import 'package:instagram_app/core/waring/waring.dart';
import 'package:instagram_app/features/home/data/repo_impl/post_repo_impl.dart';
import 'package:instagram_app/features/home/presention/cubits/post_cubit/post_cubit.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController captionController = TextEditingController();
  Uint8List? imageFile;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(postRepo: getIt.get<PostRepoImpl>()),
      child: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is PostFailure) {
            snackbar(context, state.message);
          }
          if (state is PostSuccess) {
            captionController.clear();
            imageFile = null;
            snackbar(context, "Post created successfully");
          }
        },
        builder: (context, state) {
          return state is PostLoading
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          setState(() {
                            imageFile = null;
                          });
                        },
                        icon: const Icon(Icons.close)),
                    automaticallyImplyLeading: false,
                    actions: [
                      TextButton(
                          onPressed: () {
                            if (imageFile != null) {
                              context.read<PostCubit>().addPosts(
                                  caption: captionController.text,
                                  imageFile: imageFile!);
                            }
                          },
                          child: const Text(
                            "Post",
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  body: SafeArea(
                    child: imageFile == null
                        ? Center(
                            child: IconButton(
                                onPressed: () async {
                                  Uint8List? image = await StorgeService
                                      .pickImageFromGallery();
                                  setState(() {
                                    imageFile = image;
                                  });
                                },
                                icon: const Icon(
                                  Icons.upload,
                                  size: 40,
                                )),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                  height: getHeigt(context) * 0.4,
                                  width: double.infinity,
                                  child: Image.memory(
                                    imageFile!,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10.0),
                                child: TextFormField(
                                  controller: captionController,
                                  decoration: const InputDecoration(
                                      hintText: "Add caption",
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                  ),
                );
        },
      ),
    );
  }
}
