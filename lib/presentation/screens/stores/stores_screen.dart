import 'package:flutter/material.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  // Mock store data (replace with Supabase later)
  List<Map<String, dynamic>> stores = [
    {'name': 'فروشگاه کفش پارسی', 'ordersToday': 14, 'icon': Icons.storefront},
    {'name': 'گالری پوشاک آریا', 'ordersToday': 7, 'icon': Icons.shopping_bag},
    {
      'name': 'فروشگاه لوازم خانگی کوثر',
      'ordersToday': 3,
      'icon': Icons.kitchen,
    },
    {
      'name': 'فروشگاه لوازم خانگی کوثر',
      'ordersToday': 3,
      'icon': Icons.kitchen,
    },
    {
      'name': 'فروشگاه لوازم خانگی کوثر',
      'ordersToday': 3,
      'icon': Icons.kitchen,
    },
    {
      'name': 'فروشگاه لوازم خانگی کوثر',
      'ordersToday': 3,
      'icon': Icons.kitchen,
    },
    {
      'name': 'فروشگاه لوازم خانگی کوثر',
      'ordersToday': 3,
      'icon': Icons.kitchen,
    },
  ];

  String query = "";

  @override
  Widget build(BuildContext context) {
    final filtered = stores
        .where((s) => s['name'].toString().contains(query))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --- Header title ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.storefront,
                    size: 26,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'فروشگاه‌های من',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    tooltip: 'ایجاد فروشگاه جدید',
                  ),
                ],
              ),
            ),

            // --- Search Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (v) => setState(() => query = v),
                decoration: InputDecoration(
                  hintText: 'جستجوی فروشگاه...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // --- List of Stores ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final s = filtered[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // TODO: Navigate to store details
                      },
                      child: Card(
                        elevation: 1.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                child: Icon(
                                  s['icon'],
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                                  size: 26,
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      s['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.right,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.shopping_cart_outlined,
                                          size: 18,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${s['ordersToday']} سفارش امروز',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // --- Bottom navigation ---
      bottomNavigationBar: _BottomNavBar(currentIndex: 1),
    );
  }
}

//
// ---------------- BOTTOM NAVBAR ------------------
//
class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const _BottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (i) {
        // TODO: add navigation switch logic
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'خانه'),
        NavigationDestination(
          icon: Icon(Icons.storefront_outlined),
          label: 'فروشگاه‌ها',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'پروفایل',
        ),
        NavigationDestination(icon: Icon(Icons.bar_chart), label: 'آمار'),
        NavigationDestination(icon: Icon(Icons.wallet), label: 'کیف پول'),
      ],
    );
  }
}
