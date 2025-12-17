import 'package:flutter/material.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({super.key});

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final nameCtrl = TextEditingController(text: 'کفش ورزشی مردانه مدل اسپرت');
  final descCtrl = TextEditingController(
    text: 'کفش مناسب پیاده‌روی و استفاده روزمره با کیفیت بالا.',
  );
  final priceCtrl = TextEditingController(text: '1200000');
  final stockCtrl = TextEditingController(text: '45');

  /// MOCK: variant products (SKU-like)
  final List<_VariantProduct> variantProducts = [
    _VariantProduct(
      description: 'سایز XL - رنگ قرمز',
      price: 1350000,
      stock: 12,
      variants: {'سایز': 'XL', 'رنگ': 'قرمز'},
    ),
    _VariantProduct(
      description: 'سایز L - رنگ مشکی',
      price: 1300000,
      stock: 8,
      variants: {'سایز': 'L', 'رنگ': 'مشکی'},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ویرایش محصول'),
        leading: const BackButton(),
        actions: [TextButton(onPressed: () {}, child: const Text('ذخیره'))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ---------- Gallery ----------
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://picsum.photos/200?image=${i + 20}',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close, size: 14),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemCount: 3,
            ),
          ),

          const SizedBox(height: 14),

          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload),
            label: const Text('افزودن تصویر جدید'),
          ),

          const SizedBox(height: 28),

          /// ---------- Fields ----------
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: 'نام محصول'),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 18),

          TextField(
            controller: descCtrl,
            decoration: const InputDecoration(labelText: 'توضیحات محصول'),
            maxLines: 3,
            textDirection: TextDirection.rtl,
          ),

          const SizedBox(height: 28),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: priceCtrl,
                  decoration: const InputDecoration(
                    labelText: 'قیمت پایه (تومان)',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: TextField(
                  controller: stockCtrl,
                  decoration: const InputDecoration(labelText: 'موجودی کل'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          /// ---------- Variant Products ----------
          Row(
            children: [
              Text(
                'تنوع‌های محصول',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => _openVariantEditor(),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ...variantProducts.map(
            (v) => _VariantProductCard(
              data: v,
              onEdit: () => _openVariantEditor(editing: v),
              onDelete: () => _confirmDelete(v),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// ---------- Delete confirm ----------
  void _confirmDelete(_VariantProduct v) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف تنوع'),
        content: const Text('آیا از حذف این تنوع مطمئن هستید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () {
              setState(() => variantProducts.remove(v));
              Navigator.pop(context);
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  /// ---------- Bottom sheet editor ----------
  void _openVariantEditor({_VariantProduct? editing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _VariantEditorSheet(initial: editing),
    );
  }
}

/// ===============================================================
/// ======================= UI COMPONENTS =========================
/// ===============================================================

class _VariantProductCard extends StatelessWidget {
  final _VariantProduct data;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _VariantProductCard({
    required this.data,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.description,
                    style: t.titleSmall,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: data.variants.entries
                  .map((e) => Chip(label: Text('${e.key}: ${e.value}')))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('موجودی: ${data.stock}'),
                const Spacer(),
                Text('${data.price.toString()} تومان', style: t.titleMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------- Bottom Sheet Variant Editor ----------
class _VariantEditorSheet extends StatefulWidget {
  final _VariantProduct? initial;
  const _VariantEditorSheet({this.initial});

  @override
  State<_VariantEditorSheet> createState() => _VariantEditorSheetState();
}

class _VariantEditorSheetState extends State<_VariantEditorSheet> {
  late TextEditingController descCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController stockCtrl;

  Map<String, List<String>> storeVariants = {
    'سایز': ['L', 'XL', 'XXL'],
    'رنگ': ['قرمز', 'سبز', 'آبی'],
  };

  Map<String, String> selected = {};

  @override
  void initState() {
    super.initState();
    descCtrl = TextEditingController(text: widget.initial?.description ?? '');
    priceCtrl = TextEditingController(
      text: widget.initial?.price.toString() ?? '',
    );
    stockCtrl = TextEditingController(
      text: widget.initial?.stock.toString() ?? '',
    );

    selected = Map.from(widget.initial?.variants ?? {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ویرایش تنوع محصول',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'توضیح کوتاه'),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: priceCtrl,
                    decoration: const InputDecoration(
                      labelText: 'قیمت (تومان)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: stockCtrl,
                    decoration: const InputDecoration(labelText: 'موجودی'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            Text('ویژگی‌ها'),
            const SizedBox(height: 8),

            ...storeVariants.entries.map(
              (e) => _VariantSelector(
                title: e.key,
                options: e.value,
                selected: selected[e.key],
                onSelected: (v) {
                  setState(() => selected[e.key] = v);
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ذخیره تنوع'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------- Variant selector (modern tag input) ----------
class _VariantSelector extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selected;
  final ValueChanged<String> onSelected;

  const _VariantSelector({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          children: options
              .map(
                (o) => ChoiceChip(
                  label: Text(o),
                  selected: selected == o,
                  onSelected: (_) => onSelected(o),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

/// ---------- Model ----------
class _VariantProduct {
  final String description;
  final int price;
  final int stock;
  final Map<String, String> variants;

  _VariantProduct({
    required this.description,
    required this.price,
    required this.stock,
    required this.variants,
  });
}
