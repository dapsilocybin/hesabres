import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MobileDashboardPage extends StatelessWidget {
  const MobileDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const _BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            const _DashboardHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 12),
                    _StoreOrdersSection(),

                    SizedBox(height: 24),
                    _SalesChartSection(),

                    SizedBox(height: 24),
                    _QuickActions(),

                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ───────────────────────────────── HEADER ─────────────────────────────────
//
class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "سلام مصطفی 👋",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "به داشبورد فروشگاه خوش اومدی",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          IconButton(
            onPressed: () => _openWarningsModal(context),
            icon: const Icon(Icons.notifications_active_outlined, size: 28),
          ),
        ],
      ),
    );
  }
}

//
// ───────────────────────────── STORE ORDER CARDS ─────────────────────────────
//
class _StoreOrdersSection extends StatelessWidget {
  const _StoreOrdersSection();

  @override
  Widget build(BuildContext context) {
    final sampleStores = [
      {"name": "فروشگاه مرکزی", "orders": 12},
      {"name": "شعبه ولیعصر", "orders": 23},
      {"name": "شعبه الهیه", "orders": 5},
      {"name": "شعبه پیروزی", "orders": 222},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "سفارش‌های امروز",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 120,

          /// 👉 Absolute FIX: Override default gesture behavior
          child: ScrollConfiguration(
            behavior: _HorizontalScrollBehavior(),
            child: ListView.separated(
              primary: false, // <-- IMPORTANT
              shrinkWrap: true, // <-- IMPORTANT
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: sampleStores.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final store = sampleStores[i];
                return _StoreOrderCard(
                  storeName: store["name"] as String,
                  orderCount: store["orders"] as int,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom scroll behavior that forces horizontal drag recognition
class _HorizontalScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class _StoreOrderCard extends StatelessWidget {
  final String storeName;
  final int orderCount;

  const _StoreOrderCard({required this.storeName, required this.orderCount});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // Handle card tap
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storeName,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              "$orderCount سفارش جدید",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ───────────────────────────── SALES LINE CHART ─────────────────────────────
//
class _SalesChartSection extends StatelessWidget {
  const _SalesChartSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "آمار فروش فروشگاه‌ها",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.05)),
            ],
          ),
          height: 250,
          child: const _SalesLineChart(),
        ),
      ],
    );
  }
}

class _SalesLineChart extends StatelessWidget {
  const _SalesLineChart();

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 50,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),

        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: const [
              FlSpot(0, 10),
              FlSpot(1, 12),
              FlSpot(2, 20),
              FlSpot(3, 25),
              FlSpot(4, 22),
              FlSpot(5, 33),
              FlSpot(6, 40),
            ],
            dotData: const FlDotData(show: false),
            color: Colors.blue,
            barWidth: 3,
          ),
          LineChartBarData(
            isCurved: true,
            spots: const [
              FlSpot(0, 8),
              FlSpot(1, 14),
              FlSpot(2, 15),
              FlSpot(3, 18),
              FlSpot(4, 30),
              FlSpot(5, 28),
              FlSpot(6, 35),
            ],
            dotData: const FlDotData(show: false),
            color: Colors.orange,
            barWidth: 3,
          ),
        ],
      ),
    );
  }
}

//
// ───────────────────────────── QUICK ACTIONS ─────────────────────────────
//
class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final actions = [
      {"label": "افزودن فروشگاه", "icon": Icons.store_mall_directory},
      {"label": "افزودن محصول", "icon": Icons.add_box_outlined},
      {"label": "گزارش‌ها", "icon": Icons.bar_chart},
      {"label": "سفارش‌ها", "icon": Icons.shopping_bag_outlined},
      {"label": "تنظیمات", "icon": Icons.settings},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "عملیات سریع",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: actions
              .map(
                (a) => _QuickActionItem(
                  icon: a["icon"] as IconData,
                  label: a["label"] as String,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickActionItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        // Handle quick action tap
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: cs.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: cs.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//
// ───────────────────────────── BOTTOM NAV BAR ─────────────────────────────
//
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "خانه"),
        NavigationDestination(icon: Icon(Icons.store), label: "فروشگاه‌ها"),
        NavigationDestination(icon: Icon(Icons.person), label: "پروفایل"),
        NavigationDestination(icon: Icon(Icons.bar_chart), label: "آمار"),
        NavigationDestination(icon: Icon(Icons.wallet), label: "کیف پول"),
      ],
      selectedIndex: 0,
    );
  }
}
