import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StorePage extends StatefulWidget {
  final String storeName;

  const StorePage({super.key, required this.storeName});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool showNotifications = false;

  void _openWarningsModal(BuildContext context) {
    final warnings = [
      "محصول X در حال اتمام است.",
      "سقف سفارشات امروز فروشگاه مرکزی پر شده.",
      "۷ سفارش نیاز به بررسی دارند.",
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                "هشدارها و پیام‌ها",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              ...warnings.map(
                (w) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          w,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'مدیریت فروشگاه',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => _openWarningsModal(context),
          ),
        ],
      ),

      body: Stack(
        children: [
          _buildMainContent(context),

          if (showNotifications) _buildNotificationsOverlay(context),
        ],
      ),

      bottomNavigationBar: _BottomNavBar(currentIndex: 1),
    );
  }

  // -------------------------------------------------------------
  // MAIN CONTENT
  // -------------------------------------------------------------
  Widget _buildMainContent(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store Summary Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Row: Icon + Name
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: cs.primaryContainer,
                          radius: 28,
                          child: Icon(
                            Icons.store,
                            size: 30,
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            widget.storeName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Stats Row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _StoreStat(
                            label: "تعداد محصولات",
                            value: "۴۸",
                            icon: Icons.inventory_2,
                          ),
                          _StoreStat(
                            label: "میانگین سفارش روزانه",
                            value: "۱۲",
                            icon: Icons.bar_chart,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _StoreStat(
                            label: "تاریخ ایجاد",
                            value: "۱۴۰۲/۱۰/۲۳",
                            icon: Icons.event,
                          ),
                          _StoreStat(
                            label: "فروش کل",
                            value: "۲۳٬۴۵۰٬۰۰۰ تومان",
                            icon: Icons.attach_money,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Real Chart Section
            const Text(
              'نمودار تعداد سفارشات محصولات',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildRealProductChart(),

            const SizedBox(height: 30),

            // Action Buttons
            const Text(
              "عملیات فروشگاه",
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildActionsGrid(context),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // TOP PRODUCTS MOCK SECTION
  // -------------------------------------------------------------
  Widget _buildTopProductsList() {
    final items = [
      {'name': 'ماست کم‌چرب', 'count': 120},
      {'name': 'نوشابه کوکاکولا', 'count': 98},
      {'name': 'برنج دم سیاه', 'count': 76},
    ];

    return Column(
      children: items.map((p) {
        return Card(
          child: ListTile(
            title: Text(p['name']! as String, textDirection: TextDirection.rtl),
            trailing: Text(
              "${p['count']} فروش",
              textDirection: TextDirection.rtl,
            ),
          ),
        );
      }).toList(),
    );
  }

  // -------------------------------------------------------------
  // REAL CHART (MOCK DATA)
  // -------------------------------------------------------------
  Widget _buildRealProductChart() {
    // Mock data: 3 products with different order counts over 7 days
    final List<FlSpot> productA = [
      const FlSpot(0, 5),
      const FlSpot(1, 8),
      const FlSpot(2, 4),
      const FlSpot(3, 10),
      const FlSpot(4, 7),
      const FlSpot(5, 12),
      const FlSpot(6, 9),
    ];

    final List<FlSpot> productB = [
      const FlSpot(0, 3),
      const FlSpot(1, 6),
      const FlSpot(2, 2),
      const FlSpot(3, 4),
      const FlSpot(4, 5),
      const FlSpot(5, 7),
      const FlSpot(6, 4),
    ];

    final List<FlSpot> productC = [
      const FlSpot(0, 10),
      const FlSpot(1, 12),
      const FlSpot(2, 9),
      const FlSpot(3, 14),
      const FlSpot(4, 13),
      const FlSpot(5, 16),
      const FlSpot(6, 15),
    ];

    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
      ),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 20,
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: productA,
              isCurved: true,
              barWidth: 3,
              color: Colors.blue,
            ),
            LineChartBarData(
              spots: productB,
              isCurved: true,
              barWidth: 3,
              color: Colors.green,
            ),
            LineChartBarData(
              spots: productC,
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // ACTION BUTTONS GRID
  // -------------------------------------------------------------
  Widget _buildActionsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 0.85,
      children: [
        _ActionButton(icon: Icons.inventory_2, label: "محصولات"),
        _ActionButton(icon: Icons.shopping_bag, label: "سفارش‌ها"),
        _ActionButton(icon: Icons.add_circle_outline, label: "افزودن محصول"),
      ],
    );
  }

  // -------------------------------------------------------------
  // NOTIFICATION OVERLAY
  // -------------------------------------------------------------
  Widget _buildNotificationsOverlay(BuildContext context) {
    final notifications = [
      "محصول نوشابه در حال اتمام است.",
      "به سقف سفارش روز نزدیک می‌شوید.",
      "کیف پول شما کمتر از ۱۰۰ هزار تومان است.",
    ];

    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => showNotifications = false),
        child: Container(
          color: Colors.black.withOpacity(0.45),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "اعلان‌ها",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 14),
                  ...notifications.map((n) {
                    return ListTile(
                      title: Text(n, textDirection: TextDirection.rtl),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StoreStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StoreStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: cs.primary),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}

// -------------------------------------------------------------
// Bottom Navbar
// -------------------------------------------------------------
class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const _BottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "خانه"),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: "فروشگاه"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "پروفایل"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "آمار"),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: "کیف پول",
        ),
      ],
    );
  }
}

// -------------------------------------------------------------
// Action Button Component
// -------------------------------------------------------------
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: cs.primaryContainer,
            child: Icon(icon, color: cs.onPrimaryContainer),
          ),
          const SizedBox(height: 8),
          Text(label, textDirection: TextDirection.rtl),
        ],
      ),
    );
  }
}
