import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  final PageController _pageController = PageController(
    viewportFraction: 0.75,
    initialPage: 0,
  );
  double currentPage = 0.0;

  final plans = [
    {
      "title": "پلن برنزی",
      "icon": Icons.emoji_events_outlined,
      "desc": "مناسب شروع فعالیت و فروش‌های کم",
    },
    {
      "title": "پلن نقره‌ای",
      "icon": Icons.military_tech_outlined,
      "desc": "مناسب فروشندگان با فروش متوسط",
    },
    {
      "title": "پلن طلایی",
      "icon": Icons.workspace_premium_outlined,
      "desc": "مناسب رشد کسب‌وکار و فروش بالا",
    },
    {
      "title": "پلن لجندری",
      "icon": Icons.star_rate_rounded,
      "desc": "ویژه برندها و فروشگاه‌های حرفه‌ای",
    },
  ];

  @override
  void initState() {
    super.initState();
    currentPage = _pageController.initialPage.toDouble();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: AppBar(title: const Text("پلن‌های اشتراک"), centerTitle: true),
      body: isDesktop
          ? _buildDesktopGrid(context)
          : _buildMobileCarousel(context),
    );
  }

  // -------------------------------------------------------------
  // 📱 MOBILE CAROUSEL
  // -------------------------------------------------------------
  Widget _buildMobileCarousel(BuildContext context) {
    // responsive height
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height.clamp(320.0, 520.0),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: PageView.builder(
          controller: _pageController,
          itemCount: plans.length,
          physics: const PageScrollPhysics(), // ensures page scrolling
          padEnds: true,
          allowImplicitScrolling: true,
          onPageChanged: (int page) {
            setState(() {
              currentPage = page.toDouble();
            });
          },
          itemBuilder: (context, index) {
            // compute a normalized delta from currentPage
            final delta = (index - currentPage).abs().clamp(0.0, 1.0);
            final scale = 1.0 - (delta * 0.15); // centered = 1.0, sides ~0.85

            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: _planCard(
                context,
                plans[index],
                isCentered: (delta < 0.2),
              ),
            );
          },
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // 🖥️ DESKTOP GRID
  // -------------------------------------------------------------
  Widget _buildDesktopGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int columns = (constraints.maxWidth / 280).floor();
          columns = columns.clamp(2, 4);

          return GridView.builder(
            itemCount: plans.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: 0.78,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return _planCard(context, plans[index]);
            },
          );
        },
      ),
    );
  }

  // -------------------------------------------------------------
  // CARD WIDGET
  // -------------------------------------------------------------
  Widget _planCard(BuildContext context, Map plan, {bool isCentered = false}) {
    return Card(
      elevation: isCentered ? 6 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              plan["icon"],
              size: isCentered ? 60 : 45,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              plan["title"],
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              plan["desc"],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // Navigate to details page
                },
                child: const Text("مشاهده جزئیات"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
