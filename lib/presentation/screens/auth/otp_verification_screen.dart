import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone;

  const OtpVerificationScreen({super.key, required this.phone});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;
  bool _canResend = false;
  int _secondsLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsLeft = 60;
    _canResend = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        setState(() => _canResend = true);
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // -------- ICON --------
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),

                  // -------- TITLE --------
                  Text(
                    "کد تأیید",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // -------- SUBTITLE --------
                  Text(
                    "کد ارسال‌شده به شماره ${widget.phone} را وارد کنید",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),

                  // -------- OTP INPUT --------
                  _buildOtpField(context),

                  const SizedBox(height: 32),

                  // -------- SUBMIT BUTTON --------
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
                          : const Text("تأیید"),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // -------- RESEND SECTION --------
                  _buildResendSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- OTP FIELD -----------------
  Widget _buildOtpField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextFormField(
        controller: _otpController,
        keyboardType: TextInputType.number,
        maxLength: 6,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ],
        decoration: const InputDecoration(counterText: "", hintText: "••••••"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "کد تأیید را وارد کنید";
          }
          if (value.length < 4) {
            return "کد تأیید معتبر نیست";
          }
          return null;
        },
      ),
    );
  }

  // ---------------- RESEND SECTION -----------------
  Widget _buildResendSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        if (!_canResend)
          Text(
            "ارسال دوباره تا ${_secondsLeft} ثانیه دیگر",
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

        if (_canResend)
          TextButton(
            onPressed: _resendCode,
            child: const Text("ارسال دوباره کد"),
          ),
      ],
    );
  }

  // ---------------- SUBMIT LOGIC -----------------
  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isLoading = false);

      // TODO: call BLoC event
      // context.read<AuthBloc>().add(AuthVerifyOtp(_otpController.text));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("کد صحیح است")));
    });
  }

  // ---------------- RESEND LOGIC -----------------
  void _resendCode() {
    setState(() => _canResend = false);
    _startTimer();

    // TODO: call BLoC for resending OTP
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("کد جدید ارسال شد")));
  }
}
