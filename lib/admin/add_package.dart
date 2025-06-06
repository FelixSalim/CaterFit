import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddPackage extends StatelessWidget {
  const AddPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddPackageTitle(),
            UploadImageField(),
          ],
        ),
      ),
    );
  }
}

class AddPackageTitle extends StatelessWidget {
  const AddPackageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 24, bottom: 20),
      child: Text(
        'Add Package',
        style: GoogleFonts.montserrat(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

class UploadImageField extends StatefulWidget {
  const UploadImageField({super.key});

  @override
  State<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends State<UploadImageField> {
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              "Assets/placeholder.png",
              fit: BoxFit.fill,
              width: 175,
              height: 200,
              color: Colors.grey[400],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) => const BottomUpload(),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(175, 20),
              backgroundColor: const Color(0xFF0D3011),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.upload_file,
                  color: Colors.white,
                  size: 20,
                ),
                Text(
                  "Upload Image",
                  style:
                      GoogleFonts.nunitoSans(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BottomUpload extends StatefulWidget {
  const BottomUpload({super.key});

  @override
  State<BottomUpload> createState() => _BottomUploadState();
}

class _BottomUploadState extends State<BottomUpload> {
  final GlobalKey<_UploadImageFieldState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Choose Package Image",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    // Implement camera functionality here
                    final pickedFile = await globalKey.currentState?.picker
                        .pickImage(source: ImageSource.gallery);
                    globalKey.currentState?.setState(() {
                      globalKey.currentState?.imageFile = pickedFile;
                    });
                  },
                  icon: const Icon(Icons.image),
                  label: Text(
                    "Gallery",
                    style: GoogleFonts.nunitoSans(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
