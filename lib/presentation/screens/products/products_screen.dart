// products_screen.dart
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // --- Mock product data ---
  final List<Map<String, dynamic>> _allProducts = List.generate(53, (i) {
    return {
      'id': i,
      'name': 'محصول شماره ${i + 1}',
      'stock': (i * 7 + 3) % 50,
      'isActive': i % 3 != 0,
      'hasVariants': i % 4 == 0,
    };
  });

  // --- state: search / filter / sort / pagination ---
  String _query = '';
  bool? _filterActive; // null = all, true = active only, false = inactive only
  bool? _filterHasVariants; // null = all
  String _sortBy = 'name'; // 'name' | 'stock' | 'active'
  bool _sortDesc = false;

  // pagination
  int _page = 1;
  final int _pageSize = 10;

  // notifications (bottom sheet content)
  final List<String> _notifications = [
    'محصول «کفش ورزشی» در حال اتمام است.',
    '۳ سفارش منتظر تأیید هستند.',
    'سقف سفارش روزانه فروشگاه پر شده.',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filtered = _applySearchFilterSort(_allProducts);

    final totalPages = (filtered.length / _pageSize).ceil().clamp(1, 999);
    final page = _page.clamp(1, totalPages);
    final pageItems = filtered.skip((page - 1) * _pageSize).take(_pageSize).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('محصولات', textDirection: TextDirection.rtl),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            tooltip: 'افزودن محصول',
            onPressed: _onAddProduct,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            tooltip: 'هشدارها',
            onPressed: () => _openNotificationsSheet(context),
          ),
        ],
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onAddProduct,
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // --- fixed header: search + sort + filter ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: _buildHeaderControls(),
            ),

            // --- product list / grid ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: LayoutBuilder(builder: (context, bc) {
                  // simple grid with 2 columns on narrow mobile
                  return GridView.builder(
                    itemCount: pageItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final p = pageItems[index];
                      return _ProductCard(
                        id: p['id'] as int,
                        name: p['name'] as String,
                        stock: p['stock'] as int,
                        isActive: p['isActive'] as bool,
                        hasVariants: p['hasVariants'] as bool,
                        onDelete: () => _onDeleteProduct(p['id'] as int),
                        onEdit: () => _onEditProduct(p['id'] as int),
                        onToggleActive: (val) => _onToggleActive(p['id'] as int, val),
                      );
                    },
                  );
                }),
              ),
            ),

            // --- pagination controls ---
            _buildPaginationControls(totalPages),
          ],
        ),
      ),

      bottomNavigationBar: const _BottomNavBar(selectedIndex: 1),
    );
  }

  // ---------------- header controls ----------------
  Widget _buildHeaderControls() {
    return Column(
      children: [
        // search field
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'جستجوی محصولات...',
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (v) => setState(() {
                  _query = v;
                  _page = 1;
                }),
              ),
            ),
            const SizedBox(width: 10),
            // filter button
            ElevatedButton.icon(
              onPressed: () async {
                final result = await _openFilterDialog();
                if (result != null) {
                  setState(() {
                    _filterActive = result['active'];
                    _filterHasVariants = result['hasVariants'];
                    _page = 1;
                  });
                }
              },
              icon: const Icon(Icons.filter_list),
              label: const Text('فیلتر'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // sort dropdown + order
        Row(
          children: [
            const Text('مرتب‌سازی:'),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: _sortBy,
              items: const [
                DropdownMenuItem(value: 'name', child: Text('نام')),
                DropdownMenuItem(value: 'stock', child: Text('موجودی')),
                DropdownMenuItem(value: 'active', child: Text('وضعیت فعال')),
              ],
              onChanged: (v) => setState(() {
                _sortBy = v ?? 'name';
                _page = 1;
              }),
            ),
            IconButton(
              onPressed: () => setState(() {
                _sortDesc = !_sortDesc;
                _page = 1;
              }),
              icon: Icon(_sortDesc ? Icons.arrow_downward : Icons.arrow_upward),
            ),
            const Spacer(),
            // quick summary
            Text(
              _buildSummaryLine(),
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  String _buildSummaryLine() {
    final totalFiltered = _applySearchFilterSort(_allProducts).length;
    return 'نمایش $totalFiltered محصول';
  }

  // ---------------- apply search/filter/sort ----------------
  List<Map<String, dynamic>> _applySearchFilterSort(List<Map<String, dynamic>> list) {
    var out = list.where((p) {
      final name = (p['name'] as String).toLowerCase();
      final q = _query.trim().toLowerCase();
      if (q.isNotEmpty && !name.contains(q)) return false;
      if (_filterActive != null && p['isActive'] != _filterActive) return false;
      if (_filterHasVariants != null && p['hasVariants'] != _filterHasVariants) return false;
      return true;
    }).toList();

    out.sort((a, b) {
      int cmp = 0;
      if (_sortBy == 'name') {
        cmp = (a['name'] as String).compareTo(b['name'] as String);
      } else if (_sortBy == 'stock') {
        cmp = (a['stock'] as int).compareTo(b['stock'] as int);
      } else if (_sortBy == 'active') {
        cmp = (a['isActive'] as bool ? 1 : 0).compareTo(b['isActive'] as bool ? 1 : 0);
      }
      return _sortDesc ? -cmp : cmp;
    });

    return out;
  }

  // ---------------- filter dialog ----------------
  Future<Map<String, bool?>?> _openFilterDialog() {
    bool? active = _filterActive;
    bool? hasVariants = _filterHasVariants;

    return showDialog<Map<String, bool?>?>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('فیلترها'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // active filter (radio)
              Row(
                children: [
                  const Text('وضعیت'),
                  const SizedBox(width: 12),
                  DropdownButton<bool?>(
                    value: active,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('همه')),
                      DropdownMenuItem(value: true, child: Text('فعال')),
                      DropdownMenuItem(value: false, child: Text('غیرفعال')),
                    ],
                    onChanged: (v) => active = v,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('دارای واریانت'),
                  const SizedBox(width: 12),
                  DropdownButton<bool?>(
                    value: hasVariants,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('همه')),
                      DropdownMenuItem(value: true, child: Text('بله')),
                      DropdownMenuItem(value: false, child: Text('خیر')),
                    ],
                    onChanged: (v) => hasVariants = v,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(null),
                child: const Text('انصراف')),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop({'active': active, 'hasVariants': hasVariants}),
              child: const Text('اعمال'),
            ),
          ],
        );
      },
    );
  }

  // ---------------- pagination UI ----------------
  Widget _buildPaginationControls(int totalPages) {
    final pagesToShow = <int>[];
    final start = (_page - 2).clamp(1, totalPages);
    final end = (_page + 2).clamp(1, totalPages);
    for (var i = start; i <= end; i++) pagesToShow.add(i);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          TextButton(
            onPressed: _page > 1 ? () => setState(() => _page = _page - 1) : null,
            child: const Text('قبلی'),
          ),
          const SizedBox(width: 8),
          ...pagesToShow.map((p) {
            final isCurrent = p == _page;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCurrent ? null : Colors.white,
                  elevation: isCurrent ? 1 : 0,
                  foregroundColor: isCurrent ? null : Colors.black87,
                ),
                onPressed: () => setState(() => _page = p),
                child: Text(p.toString()),
              ),
            );
          }).toList(),
          const SizedBox(width: 8),
          TextButton(
            onPressed: _page < totalPages ? () => setState(() => _page = _page + 1) : null,
            child: const Text('بعدی'),
          ),
          const Spacer(),
          Text('صفحه $_page از $totalPages'),
        ],
      ),
    );
  }

  // ---------------- actions (stubs) ----------------
  void _onAddProduct() {
    // TODO navigate to add product form
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('افزودن محصول (شبیه‌سازی)')));
  }

  void _onEditProduct(int id) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ویرایش محصول #$id')));
  }

  void _onDeleteProduct(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف محصول'),
        content: Text('آیا از حذف محصول شماره $id اطمینان دارید؟'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('لغو')),
          ElevatedButton(
            onPressed: () {
              setState(() => _allProducts.removeWhere((p) => p['id'] == id));
              Navigator.of(ctx).pop();
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _onToggleActive(int id, bool newVal) {
    setState(() {
      final idx = _allProducts.indexWhere((p) => p['id'] == id);
      if (idx >= 0) _allProducts[idx]['isActive'] = newVal;
    });
  }

  // ---------------- notifications bottom sheet ----------------
  void _openNotificationsSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Theme.of(ctx).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      isScrollControlled: true,
      builder: (c) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(4))),
              const SizedBox(height: 12),
              Text('هشدارها و پیام‌ها', style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: 12),
              ..._notifications.map((n) => ListTile(
                    leading: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                    title: Text(n, textDirection: TextDirection.rtl),
                  )),
              const SizedBox(height: 14),
            ],
          ),
        );
      },
    );
  }
}

// ---------------- product card component ----------------
class _ProductCard extends StatelessWidget {
  final int id;
  final String name;
  final int stock;
  final bool isActive;
  final bool hasVariants;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggleActive;

  const _ProductCard({
    required this.id,
    required this.name,
    required this.stock,
    required this.isActive,
    required this.hasVariants,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {}, // open product detail/edit later
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // name
              Text(name, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              // badges row
              Row(
                children: [
                  if (hasVariants)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(10)),
                      child: Text('گزینه‌ها', style: TextStyle(color: cs.onPrimaryContainer)),
                    ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.storage, size: 16, color: cs.onSurfaceVariant),
                      const SizedBox(width: 6),
                      Text('$stock'),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              // actions row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined)),
                    IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline)),
                  ]),
                  Row(
                    children: [
                      const Text('فعال'),
                      Switch(value: isActive, onChanged: onToggleActive),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- bottom nav bar ----------------
class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  const _BottomNavBar({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (i) {
        // TODO: navigate to different pages
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'خانه'),
        NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'فروشگاه‌ها'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'پروفایل'),
        NavigationDestination(icon: Icon(Icons.bar_chart), label: 'آمار'),
        NavigationDestination(icon: Icon(Icons.wallet), label: 'کیف پول'),
      ],
    );
  }
}
