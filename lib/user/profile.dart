import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:caterfit/login.dart';
import 'package:caterfit/user/preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for text fields
  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  // State for gender dropdown
  String? _selectedGender;
  final List<String> _genders = ['Female', 'Male'];

  // State for profile image
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // State for tracking changes
  bool _isEditing = false;

  // State for alert
  bool _isAlertVisible = false;
  String _alertMessage = '';
  Timer? _alertTimer;

  // Original data to revert changes
  late Map<String, dynamic> _originalData;
  File? _originalImage;

  // FocusNode for the address field
  final FocusNode _addressFocusNode = FocusNode();
  bool _isAddressFieldInFocus = false;

  // FocusNode and state for gender dropdown
  final FocusNode _genderFocusNode = FocusNode();
  bool _isGenderDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _addListeners();
  }

  void _initializeData() {
    // Set initial data
    _originalData = {
      'username': 'cimcarmen',
      'name': 'Carmen Kim',
      'gender': 'Female',
      'email': 'carmenkim88@gmail.com',
      'phone': '0812345678910',
      'address':
          'Jalan Jalan Ke Pasar No 77, Cianjai, Jawa Barat, Indonesia 43282',
    };
    _originalImage = _image;

    // Initialize controllers with original data
    _usernameController =
        TextEditingController(text: _originalData['username']);
    _nameController = TextEditingController(text: _originalData['name']);
    _emailController = TextEditingController(text: _originalData['email']);
    _phoneController = TextEditingController(text: _originalData['phone']);
    _addressController = TextEditingController(text: _originalData['address']);
    _selectedGender = _originalData['gender'];
  }

  void _addListeners() {
    // Add listeners to detect changes
    _usernameController.addListener(_onFieldChanged);
    _nameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _addressController.addListener(_onFieldChanged);

    // Listener to detect focus on the address field
    _addressFocusNode.addListener(() {
      if (_addressFocusNode.hasFocus != _isAddressFieldInFocus) {
        setState(() {
          _isAddressFieldInFocus = _addressFocusNode.hasFocus;
          // When the address field is focused, move the cursor to the end of the text
          if (_isAddressFieldInFocus) {
            _addressController.selection = TextSelection.fromPosition(
              TextPosition(offset: _addressController.text.length),
            );
          }
        });
      }
    });

    // Listener to detect focus on the gender dropdown
    _genderFocusNode.addListener(() {
      setState(() {
        _isGenderDropdownOpen = _genderFocusNode.hasFocus;
      });
    });
  }

  void _onFieldChanged() {
    final hasTextChanged =
        _usernameController.text != _originalData['username'] ||
            _nameController.text != _originalData['name'] ||
            _emailController.text != _originalData['email'] ||
            _phoneController.text != _originalData['phone'] ||
            _addressController.text != _originalData['address'] ||
            _selectedGender != _originalData['gender'];

    if (hasTextChanged && !_isEditing) {
      setState(() {
        _isEditing = true;
      });
    }
  }

  void _onGenderChanged(String? newValue) {
    setState(() {
      // remove the focus from the dropdown
      _genderFocusNode.unfocus();
      _isGenderDropdownOpen = false; // Close the dropdown
    });
    if (newValue != null) {
      setState(() {
        _selectedGender = newValue;
        _onFieldChanged();
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _addressFocusNode.dispose();
    _genderFocusNode.dispose();
    _alertTimer?.cancel();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        if (!_isEditing) {
          _isEditing = true; // Picking an image is also considered an edit
        }
      });
    }
  }

  void _showAlert(String message) {
    if (_isAlertVisible) return;

    setState(() {
      _isAlertVisible = true;
      _alertMessage = message;
    });

    _alertTimer?.cancel();
    _alertTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isAlertVisible = false;
        });
      }
    });
  }

  void _saveChanges() {
    setState(() {
      // Update original data with new values
      _originalData = {
        'username': _usernameController.text,
        'name': _nameController.text,
        'gender': _selectedGender,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
      };
      // For image, you would typically upload it and save the new URL.
      _originalImage = _image;
      _isEditing = false;
    });
    _showAlert('Profile successfully updated!');
  }

  void _discardChanges() {
    setState(() {
      // Revert controllers and state to original data
      _usernameController.text = _originalData['username'];
      _nameController.text = _originalData['name'];
      _emailController.text = _originalData['email'];
      _phoneController.text = _originalData['phone'];
      _addressController.text = _originalData['address'];
      _selectedGender = _originalData['gender'];
      _image = _originalImage; // Discard image change by reverting to original
      _isEditing = false;
    });
    _showAlert('Changes have been discarded.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                floating: true,
                snap: true,
                title: Text(
                  'Profile',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF0D3011),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    _buildProfilePicture(),
                    const SizedBox(height: 30),
                    _buildProfileTextField(
                        label: 'Username',
                        controller: _usernameController,
                        isUsername: true),
                    _buildProfileTextField(
                        label: 'Name', controller: _nameController),
                    _buildGenderDropdown(),
                    _buildProfileTextField(
                        label: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress),
                    _buildProfileTextField(
                        label: 'Phone Number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone),
                    _buildAddressField(),
                    if (_isEditing) _buildActionButtons(),
                    const SizedBox(height: 40),
                    _buildPreferencesButton(),
                    const SizedBox(height: 20),
                    _buildLogoutButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
          // Alert Widget
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform:
                  Matrix4.translationValues(0, _isAlertVisible ? 0 : 120, 0),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFCDE38B),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Text(
                    _alertMessage,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xFF0D3011),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            // REVISED: Use a ClipOval to ensure the image is always circular
            child: ClipOval(
              child: Image(
                fit: BoxFit.cover,
                width: 120,
                height: 120,
                image: (_image != null
                    ? FileImage(_image!)
                    : const AssetImage('Assets/profile.png')) as ImageProvider,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -5,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D3011),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 8.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D3011),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Save',
                style: GoogleFonts.montserrat(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              onPressed: _discardChanges,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF0D3011), width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Discard',
                style: GoogleFonts.montserrat(
                    color: const Color(0xFF0D3011),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTextField({
    required String label,
    required TextEditingController controller,
    bool isUsername = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              color: const Color(0xFF0D3011),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: 1,
              style: GoogleFonts.nunitoSans(
                color: const Color(0xFF0D3011).withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                prefixText: isUsername ? '@' : null,
                prefixStyle: GoogleFonts.nunitoSans(
                  color: const Color(0xFF0D3011).withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                filled: true,
                fillColor: const Color(0xFFFEFFDE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField() {
    String displayText = _addressController.text;
    // Truncate text if longer than 40 characters for display
    if (displayText.length > 40 && !_isAddressFieldInFocus) {
      displayText = '${displayText.substring(0, 40)}...';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Address',
            style: GoogleFonts.montserrat(
              color: const Color(0xFF0D3011),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // Request focus when the container is tapped
              if (!_addressFocusNode.hasFocus) {
                FocusScope.of(context).requestFocus(_addressFocusNode);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: double.infinity,
              constraints: const BoxConstraints(
                  minHeight: 50), // Ensure consistent height
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: const Color(0xFFFEFFDE),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _isAddressFieldInFocus
                  ? TextFormField(
                      controller: _addressController,
                      focusNode: _addressFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: null, // Allow multi-line when editing
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xFF0D3011).withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: '',
                      ),
                    )
                  : Text(
                      displayText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xFF0D3011).withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // REVISED: Updated gender dropdown widget
  Widget _buildGenderDropdown() {
    final double dropdownWidth = MediaQuery.of(context).size.width - 48;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: GoogleFonts.montserrat(
              color: const Color(0xFF0D3011),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              // REVISED: Dynamic radius based on dropdown open/close state
              borderRadius: _isGenderDropdownOpen
                  ? BorderRadius.vertical(top: Radius.circular(10))
                  : BorderRadius.circular(10),
              color: const Color(0xFFFEFFDE),
            ),
            child: DropdownButton2<String>(
              focusNode: _genderFocusNode,
              value: _selectedGender,
              isExpanded: true,
              buttonStyleData: ButtonStyleData(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFFDE),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                width: dropdownWidth,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFEFFDE),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              // Hides the default underline
              underline: const SizedBox(),
              // Custom dropdown icon
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.arrow_drop_down, color: Color(0xFF0D3011)),
              ),
              // Style for the selected item
              style: GoogleFonts.nunitoSans(
                color: const Color(0xFF0D3011).withOpacity(0.7),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              // The callback function when an item is selected
              onChanged: _onGenderChanged,
              items: _genders.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to preferences page
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PreferencesPage()));
          print('Navigate to Preferences');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFFEFFDE),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Preferences',
                style: GoogleFonts.nunitoSans(
                  color: const Color(0xFF797979),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFF797979), size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // Navigate to login page
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
          print('Logout pressed, navigating to LoginPage');
        },
        icon: const Icon(Icons.logout, color: Colors.white, size: 20),
        label: Text(
          'Log Out',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D3011),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
      ),
    );
  }
}
