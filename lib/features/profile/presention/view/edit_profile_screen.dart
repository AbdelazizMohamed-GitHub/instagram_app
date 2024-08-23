
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/waring/waring.dart';
import 'package:instagram_app/core/widget/custom_button.dart';
import 'package:instagram_app/core/widget/custom_text_form.dart';
import 'package:instagram_app/features/profile/data/repo_impl/profile_repo_imp.dart';
import 'package:instagram_app/features/profile/presention/cubits/cubit/profile_cubit.dart';
import 'package:instagram_app/features/profile/presention/view/widget/custom_edit_profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.userName,
    required this.photoUrl,
    required this.bio,
  });

  final String userName;
  final String photoUrl;
  final String bio;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    usernameC.text = widget.userName;
    bioC.text = widget.bio;
    super.initState();
  }

  Uint8List? imageFile;
  TextEditingController usernameC = TextEditingController();
  TextEditingController bioC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    usernameC.dispose();
    bioC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(profileRepo: ProfileRepoImpl()),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileFailure) {
            snackbar(context, state.error);
          } else if (state is EditProfileSucess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomEditProfileImge(
                            photoUrl: widget.photoUrl,
                            onChanged: (Uint8List? value) {
                              imageFile = value;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextForm(
                              pIcon: Icons.person,
                              text: "userName",
                              textController: usernameC,
                              obscureText: false,
                              kTybe: TextInputType.name),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextForm(
                              pIcon: Icons.info,
                              text: "bio",
                              textController: bioC,
                              obscureText: false,
                              kTybe: TextInputType.name),
                          const SizedBox(
                            height: 15,
                          ),
                          state is EditProfileLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                  text: "Update",
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      if (imageFile == null) {
                                        await context
                                            .read<ProfileCubit>()
                                            .updateUserProfileWithoutImage(
                                              username: usernameC.text,
                                              bio: bioC.text,
                                            );
                                      } else {
                                        await context
                                            .read<ProfileCubit>()
                                            .updateUserProfileWithImage(
                                                imageFile: imageFile!,
                                                username: usernameC.text,
                                                bio: bioC.text);
                                      }
                                    }
                                  },
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                        ]),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
