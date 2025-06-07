// based of add_package.dart please create edit_package.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:caterfit/admin/package_management.dart';
import 'package:caterfit/models/package_model.dart';
import 'package:image_picker/image_picker.dart';

class EditPackage extends StatefulWidget {
  final Package packageData;

  const EditPackage({Key? key, required this.packageData}) : super(key: key);

  @override
  _EditPackageState createState() => _EditPackageState();
}

class _EditPackageState extends State<EditPackage> {
  late TextEditingController packageNameController;
  late TextEditingController packageDescriptionController;
  late TextEditingController packageCategoryController;
  late List<TextEditingController> mealPlanControllers;
  late List<TextEditingController> customControllers;
  late List<List<TextEditingController>> customListControllers;
  late TextEditingController priceController;
  late TextEditingController stockController;

  File? image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    packageNameController =
        TextEditingController(text: widget.packageData.name);
    packageDescriptionController =
        TextEditingController(text: widget.packageData.description);
    packageCategoryController =
        TextEditingController(text: widget.packageData.category);
    mealPlanControllers = List.generate(
      7,
      (index) =>
          TextEditingController(text: widget.packageData.mealPlans[index]),
    );
    customControllers = List.generate(
      widget.packageData.customizationTitles.length,
      (index) => TextEditingController(
          text: widget.packageData.customizationTitles[index]),
    );
    customListControllers = List.generate(
      widget.packageData.customizationOptions.length,
      (index) => widget.packageData.customizationOptions[index]
          .map((option) => TextEditingController(text: option))
          .toList(),
    );
    priceController =
        TextEditingController(text: widget.packageData.price.toString());
    stockController =
        TextEditingController(text: widget.packageData.stock.toString());
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        print("Picked image path: ${image!.absolute.path}");
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No image selected.',
            style: GoogleFonts.nunitoSans(fontSize: 14),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void addCustomField() {
    setState(() {
      customControllers.add(TextEditingController());
      customListControllers.add([]);
    });
  }

  void removeCustomField(int index) {
    setState(() {
      customControllers.removeAt(index);
      customListControllers.removeAt(index);
    });
  }

  void addCustomListField(int index) {
    setState(() {
      customListControllers[index].add(TextEditingController());
    });
  }

  void removeCustomListField(int listIndex, int fieldIndex) {
    setState(() {
      customListControllers[listIndex].removeAt(fieldIndex);
    });
  }

  @override
  void dispose() {
    packageNameController.dispose();
    packageDescriptionController.dispose();
    packageCategoryController.dispose();
    for (var controller in mealPlanControllers) {
      controller.dispose();
    }
    for (var controller in customControllers) {
      controller.dispose();
    }
    for (var list in customListControllers) {
      for (var controller in list) {
        controller.dispose();
      }
    }
    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  void submitForm() {
    bool fieldsFilled = packageNameController.text.isNotEmpty &&
        packageDescriptionController.text.isNotEmpty &&
        packageCategoryController.text.isNotEmpty &&
        mealPlanControllers.every((controller) => controller.text.isNotEmpty) &&
        customControllers.every((controller) => controller.text.isNotEmpty) &&
        customListControllers.every(
            (list) => list.every((controller) => controller.text.isNotEmpty)) &&
        priceController.text.isNotEmpty &&
        stockController.text.isNotEmpty;

    if (fieldsFilled) {
      // Update the existing package object
      Package updatedPackage = Package(
        id: widget.packageData.id,
        name: packageNameController.text,
        description: packageDescriptionController.text,
        category: packageCategoryController.text,
        mealPlans:
            mealPlanControllers.map((controller) => controller.text).toList(),
        customizationTitles:
            customControllers.map((controller) => controller.text).toList(),
        customizationOptions: customListControllers
            .map((list) => list.map((controller) => controller.text).toList())
            .toList(),
        imageUrl: image ??
            widget.packageData.imageUrl, // Use existing image if not updated
        price: double.tryParse(priceController.text) ?? 0.0,
        stock: int.tryParse(stockController.text) ?? 0,
      );

      // Update the package in the management list
      int index = PackageManagement.onGoingPackages
          .indexWhere((pkg) => pkg.id == widget.packageData.id);
      if (index != -1) {
        PackageManagement.onGoingPackages[index] = updatedPackage;
      }

      // Close the form and navigate back to the package management screen
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PackageManagement(),
          ));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Package updated successfully!',
            style: GoogleFonts.nunitoSans(fontSize: 14),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields before submitting.',
            style: GoogleFonts.nunitoSans(fontSize: 14),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 24, bottom: 20),
              child: Text(
                'Edit Package',
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(2, 4), // changes position of shadow
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: image != null
                    ? Image.file(
                        image!.absolute,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 175,
                      )
                    : Image.file(
                        widget.packageData.imageUrl.absolute,
                        height: 200,
                        width: 175,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: () {
                  pickImage();
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
                      style: GoogleFonts.nunitoSans(
                          color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            // ... (rest of the form fields similar to AddPackage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Package Name",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset:
                              const Offset(2, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    height: 45,
                    child: TextFormField(
                      controller: packageNameController,
                      decoration: InputDecoration(
                        hintText: "Enter Package Name",
                        hintStyle: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        fillColor: const Color(0xFFFEFFDE),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Package Description",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset:
                              const Offset(2, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: TextFormField(
                      maxLines: 5,
                      controller: packageDescriptionController,
                      decoration: InputDecoration(
                        hintText: "Enter Package Description",
                        hintStyle: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color(0xFFFEFFDE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Package Category",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset:
                              const Offset(2, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    height: 45,
                    child: TextFormField(
                      controller: packageCategoryController,
                      decoration: InputDecoration(
                        hintText: "Enter Package Category",
                        hintStyle: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        fillColor: const Color(0xFFFEFFDE),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Meal Plan",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 5,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: List.generate(
                      7,
                      (index) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: mealPlanControllers[index],
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: "Enter Meal Plan ${index + 1}",
                              hintStyle: GoogleFonts.nunitoSans(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              fillColor: const Color(0xFFFEFFDE),
                              filled: true,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Custom",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(24, 24),
                      maximumSize: const Size(24, 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: const Color(0xFF0D3011),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      addCustomField();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
              child: Column(
                children: customControllers.map((controller) {
                  int index = customControllers.indexOf(controller);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(
                          children: [
                            Text("Customization ${index + 1}",
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText:
                                      "Enter Customization Title ${index + 1}",
                                  hintStyle: GoogleFonts.nunitoSans(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  border: InputBorder.none,
                                  fillColor: const Color(0xFFFEFFDE),
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => removeCustomField(index),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Column(
                          children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Customization Value ${index + 1}",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    IconButton(
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      onPressed: () =>
                                          addCustomListField(index),
                                    ),
                                  ],
                                )
                              ] +
                              customListControllers[index].map(
                                (listController) {
                                  int listIndex = customListControllers[index]
                                      .indexOf(listController);
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                blurRadius: 5,
                                                offset: const Offset(0,
                                                    0), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: TextFormField(
                                            controller: listController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Enter Customization Value ${listIndex + 1}",
                                              hintStyle: GoogleFonts.nunitoSans(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                              border: InputBorder.none,
                                              fillColor:
                                                  const Color(0xFFFEFFDE),
                                              filled: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.remove_circle_outline),
                                        onPressed: () => removeCustomListField(
                                            index, listIndex),
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Price",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(
                                      2, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            height: 45,
                            child: TextFormField(
                              controller: priceController,
                              decoration: InputDecoration(
                                hintText: "Enter Price",
                                hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                fillColor: const Color(0xFFFEFFDE),
                                filled: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Stock",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(
                                      2, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            height: 45,
                            child: TextFormField(
                              controller: stockController,
                              decoration: InputDecoration(
                                hintText: "Enter Stock",
                                hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                fillColor: const Color(0xFFFEFFDE),
                                filled: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      submitForm();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(202, 50),
                      backgroundColor: const Color(0xFF0D3011),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Edit Package",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
