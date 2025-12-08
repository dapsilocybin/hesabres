import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Responsive max width for tablets/desktop
    double maxWidth = size.width < 500 ? size.width * 0.90 : 400;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // ---------- APP ICON ----------
                  Icon(
                    Icons.phone_iphone_rounded,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),

                  // ---------- TITLE ----------
                  Text(
                    "ورود به حساب‌رس",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 32),

                  // ---------- PHONE INPUT ----------
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "شماره موبایل",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Directionality(
                    textDirection: TextDirection.ltr, // for +98 placement
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        prefixText: "+98 ",
                        hintText: "9123456789",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "شماره موبایل را وارد کنید";
                        }
                        if (!RegExp(r"^9\d{9}$").hasMatch(value)) {
                          return "شماره موبایل معتبر نیست";
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ---------- SUBMIT BUTTON ----------
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _isLoading ? null : _onSubmit,
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("دریافت کد تأیید"),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ---------- EXTRA MODERN TOUCH ----------
                  Text(
                    "با ورود، شما با قوانین و شرایط استفاده موافقت می‌کنید.",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isLoading = false);

      // TODO: Call your BLoC event
      // context.read<AuthBloc>().add(AuthRequestOtp(_phoneController.text));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("کد تأیید ارسال شد")),
      );
    });
  }
}
