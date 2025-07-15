import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class TodaysOrderDetail extends StatefulWidget {
  const TodaysOrderDetail({super.key});
  @override
  State<TodaysOrderDetail> createState() => TodaysOrderDetailState();
}

class PackageManagementTitle extends StatelessWidget {
  const PackageManagementTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 24, bottom: 20),
      child: Text(
        "Today's Order",
        style: GoogleFonts.montserrat(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0D3011),
        ),
      ),
    );
  }
}

class TodaysOrderDetailState extends State<TodaysOrderDetail> {
  // --- CONTROL TAB ---
  final List<String> _Packagecategories = [
    'All',
    'Bulking',
    'Cutting',
    'Back 2 School'
  ];

  String _selectedPackageCategories = 'All';

  // --- Data ---
  final List<PackageItem> _allPackages = [
    PackageItem(
      imageUrl: 'Assets/musclemeal.jpg',
      Pname: 'Muscle Meal - Breakfast',
      Cname: 'Carmen',
      address: 'Kwangya Street No. 18',
      time: '11.30 - 12.00',
      status: 'Arrived',
      categories: ['All', 'Bulking'],
    ),
    PackageItem(
      imageUrl: 'Assets/easterndelights.jpg',
      Pname: 'Eastern Delights - Dinner',
      Cname: 'Jeno',
      address: 'Earth Street No. 8',
      time: '17.30 - 18.00',
      status: 'Cooked',
      categories: ['All', 'Cutting'],
    ),
  ];

  List<PackageItem> _filteredPackages = [];

  @override
  void initState() {
    super.initState();
    _filterPackages();
  }

  // --- LOGIC ---
  void _filterPackages() {
    setState(() {
      if (_selectedPackageCategories == 'All') {
        _filteredPackages = _allPackages;
      } else {
        _filteredPackages = _allPackages
            .where((package) =>
                package.categories.contains(_selectedPackageCategories))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PackageManagementTitle(),

          // --- TAB MENU ----
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            height: 64,
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 12, bottom: 12),
              itemCount: _Packagecategories.length,
              itemBuilder: (context, index) {
                final category = _Packagecategories[index];
                final bool isSelected = category == _selectedPackageCategories;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPackageCategories = category;
                      _filterPackages();
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 18.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFCDE38B) : Color(0xFFFEFFDE),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(2, 4), // Posisi bayangan
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      category,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D3011),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // --- Filtered List ---
          Expanded(
            child: _filteredPackages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No orders in this category',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredPackages.length,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (context, index) {
                      final item = _filteredPackages[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Color(0xFFCCE48D)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- IMAGE ---

                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              child: Image.asset(
                                item.imageUrl,
                                width: 130,
                                height: 153,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // --- ORDER DETAIL ---
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // --- NAME ---
                                  Text(
                                    item.Pname,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Color(0xFF0D3011)),
                                  ),

                                  const SizedBox(height: 6),

                                  // --- CUSTOMER NAME ---
                                  Row(
                                    children: [
                                      const Icon(Icons.person,
                                          size: 12, color: Color(0xFF0D3011)),
                                      const SizedBox(width: 4),
                                      Text(item.Cname,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ))
                                    ],
                                  ),

                                  const SizedBox(height: 4),

                                  // --- ADDRESS ---
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 12, color: Color(0xFF0D3011)),
                                      const SizedBox(width: 4),
                                      Text(item.address,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 4),

                                  // -- TIME --
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_outlined,
                                          size: 12, color: Color(0xFF0D3011)),
                                      const SizedBox(width: 4),
                                      Text(item.time,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),

                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // -- STATUS --
                                          Row(
                                            children: [
                                              if (item.status.toLowerCase() ==
                                                  'cooked') ...[
                                                const Icon(
                                                    Icons.kitchen_outlined,
                                                    size: 12,
                                                    color: Color(
                                                        0xFF0D3011)), // panci
                                              ] else if (item.status
                                                      .toLowerCase() ==
                                                  'shipped') ...[
                                                const Icon(
                                                    Icons
                                                        .local_shipping_outlined,
                                                    size: 12,
                                                    color: Color(
                                                        0xFF0D3011)), // kendaraan
                                              ] else if (item.status
                                                      .toLowerCase() ==
                                                  'arrived') ...[
                                                const Icon(
                                                    Icons.check_circle_outline,
                                                    size: 12,
                                                    color: Color(
                                                        0xFF0D3011)), // centang
                                              ] else if (item.status
                                                      .toLowerCase() ==
                                                  'received') ...[
                                                const Icon(Icons.inbox_rounded,
                                                    size: 12,
                                                    color: Color(0xFF0D3011))
                                              ],
                                              const SizedBox(width: 4),
                                              Text(item.status,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 35,
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  UpdateOrderStatusDialog(
                                                    currentStatus: item.status,
                                                    onStatusUpdated:
                                                        (newStatus) {
                                                      setState(() {
                                                        item.status = newStatus;
                                                      });
                                                    },
                                                  ));
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: Color(0xFFCDE38B),
                                            width: 2,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          backgroundColor: Colors.white,
                                        ),
                                        child: const Text(
                                          'Edit Status',
                                          style: TextStyle(
                                            color: Color(0xFF0D3011),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class UpdateOrderStatusDialog extends StatefulWidget {
  final String currentStatus;
  final Function(String) onStatusUpdated;

  const UpdateOrderStatusDialog({
    super.key,
    required this.currentStatus,
    required this.onStatusUpdated,
  });

  @override
  State<UpdateOrderStatusDialog> createState() =>
      _UpdateOrderStatusDialogState();
}

class _UpdateOrderStatusDialogState extends State<UpdateOrderStatusDialog> {
  late String selectedStatus;

  final List<Map<String, String>> statusList = [
    {'status': 'received', 'desc': 'You have received the order request.'},
    {'status': 'cooked', 'desc': 'The chef is preparing the meal.'},
    {'status': 'shipped', 'desc': 'The meal is shipped to the customer.'},
    {
      'status': 'arrived',
      'desc': 'The package has been successfully shipped to the customer.'
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFEFFDE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Update Order Status",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0D3011),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Color(0xFF0D3011)),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Status List
            ...statusList.map((statusItem) {
              String value = statusItem['status']!;
              String desc = statusItem['desc']!;
              return ListTile(
                leading: Icon(
                  selectedStatus == value
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: const Color(0xFF0D3011),
                ),
                title: Text(
                  value[0].toUpperCase() + value.substring(1),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF0D3011),
                  ),
                ),
                subtitle: Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              );
            }),

            const SizedBox(height: 16),

            // Done Button
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  widget.onStatusUpdated(selectedStatus);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D3011),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Color(0xFFFEFFDE),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// --- Model for Package Item ---
class PackageItem {
  final String imageUrl;
  final String Pname;
  final String Cname;
  final String address;
  final String time;
  String status;
  final List<String> categories;

  PackageItem({
    required this.imageUrl,
    required this.Pname,
    required this.Cname,
    required this.address,
    required this.time,
    required this.status,
    required this.categories,
  });
}
