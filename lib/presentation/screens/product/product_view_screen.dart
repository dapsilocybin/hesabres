import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  int _currentImage = 0;
  final PageController _imageController = PageController();

  void _showQrShareModal(BuildContext context) {
    const orderLink = 'https://hesabres.com/order/PRD-23901';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final cs = Theme.of(context).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Text(
                'اشتراک‌گذاری لینک سفارش',
                style: Theme.of(context).textTheme.titleMedium,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),

              // QR Code
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: QrImageView(data: orderLink, size: 200),
              ),

              const SizedBox(height: 12),

              Text(
                orderLink,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.copy),
                      label: const Text('کپی لینک'),
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(text: orderLink));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('لینک کپی شد')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.download),
                      label: const Text('دانلود QR'),
                      onPressed: () {
                        // Hook: implement image export later
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('دانلود QR به‌زودی اضافه می‌شود'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
      appBar: AppBar(
        title: const Text('مشخصات محصول'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              _showQrShareModal(context);
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Image Gallery
          // Product Image Gallery
          Column(
            children: [
              SizedBox(
                height: 260,
                width: double.infinity,
                child: PageView.builder(
                  controller: _imageController,
                  itemCount: 4,
                  onPageChanged: (i) {
                    setState(() => _currentImage = i);
                  },
                  itemBuilder: (_, i) {
                    final imageUrl =
                        'https://picsum.photos/600/600?image=${i + 10}';

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                _FullScreenImage(imageUrl: imageUrl),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Dots indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentImage == i ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentImage == i
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Product Info
          Text(
            'کفش ورزشی مردانه مدل اسپرت',
            style: Theme.of(context).textTheme.titleLarge,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            'کفش مناسب پیاده‌روی و استفاده روزمره با کیفیت بالا و طراحی مدرن.',
            textDirection: TextDirection.rtl,
          ),

          const SizedBox(height: 20),

          // Price & Stock
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('قیمت پایه: ۱٬۲۰۰٬۰۰۰ تومان'),
              Text('موجودی کل: ۴۵ عدد'),
            ],
          ),

          const SizedBox(height: 24),

          // Variant Products (SKU-based variants)
          Text(
            'تنوع‌های محصول',
            style: Theme.of(context).textTheme.titleMedium,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),

          Column(
            children: const [
              _VariantSkuCard(
                title: 'تی‌شرت مردانه',
                price: 420000,
                stock: 12,
                attributes: {'سایز': 'XL', 'رنگ': 'قرمز'},
              ),
              SizedBox(height: 8),
              _VariantSkuCard(
                title: 'تی‌شرت مردانه',
                price: 420000,
                stock: 12,
                attributes: {'سایز': 'XL', 'رنگ': 'قرمز'},
              ),
              SizedBox(height: 8),
              _VariantSkuCard(
                title: 'تی‌شرت مردانه',
                price: 420000,
                stock: 12,
                attributes: {'سایز': 'XL', 'رنگ': 'قرمز'},
              ),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _FullScreenImage extends StatelessWidget {
  final String imageUrl;
  const _FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true, // ✅ KEY FIX
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: InteractiveViewer(
        child: Center(child: Image.network(imageUrl, fit: BoxFit.contain)),
      ),
    );
  }
}

class _VariantSkuCard extends StatelessWidget {
  final String title;
  final Map<String, String> attributes; // e.g. {'سایز': 'XL', 'رنگ': 'قرمز'}
  final int stock;
  final int price; // ← NEW

  const _VariantSkuCard({
    required this.title,
    required this.attributes,
    required this.stock,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + price
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Text(
                  '${price.toString()} تومان',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Variant attributes
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: attributes.entries.map((e) {
                return Chip(
                  label: Text('${e.key}: ${e.value}'),
                  backgroundColor: cs.surfaceVariant,
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Stock
            Row(
              children: [
                Icon(Icons.inventory_2_outlined, size: 18, color: cs.outline),
                const SizedBox(width: 6),
                Text(
                  'موجودی: $stock عدد',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
