import 'package:flutter/material.dart';

class PaymentResultPage extends StatelessWidget {
  final bool isSuccess; // toggle this manually for now

  const PaymentResultPage({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Success UI
    final successIcon = Icons.check_circle_rounded;
    const successMessage = "پرداخت با موفقیت انجام شد!";
    const successButtonLabel = "بازگشت به داشبورد";

    // Failure UI
    final failIcon = Icons.error_rounded;
    const failMessage = "پرداخت ناموفق بود. لطفاً دوباره تلاش کنید.";
    const failButtonLabel = "بازگشت به صفحه طرح‌ها";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ICON
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            (isSuccess
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.error)
                                .withOpacity(0.12),
                      ),
                      child: Icon(
                        isSuccess ? successIcon : failIcon,
                        size: isMobile ? 80 : 110,
                        color: isSuccess
                            ? theme.colorScheme.primary
                            : theme.colorScheme.error,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // MESSAGE
                    Text(
                      isSuccess ? successMessage : failMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                        color: isSuccess
                            ? theme.colorScheme.primary
                            : theme.colorScheme.error,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          backgroundColor: isSuccess
                              ? theme.colorScheme.primary
                              : theme.colorScheme.error,
                        ),
                        onPressed: () {
                          if (isSuccess) {
                            // TODO: navigate to dashboard
                          } else {
                            // TODO: navigate to plans page
                          }
                        },
                        child: Text(
                          isSuccess ? successButtonLabel : failButtonLabel,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
