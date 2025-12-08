import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

import '../../widgets/loading/fullscreen_loading.widget.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  Uint8List? _avatarBytes;
  bool _isSubmitting = false;

  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  final _businessLinkController = TextEditingController();
  final _bankController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalController = TextEditingController();

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    _businessLinkController.dispose();
    _bankController.dispose();
    _addressController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  // ---------------- AVATAR PICKER ------------------
  Future<void> _pickAvatar() async {
    final ImagePicker picker = ImagePicker();
    XFile? file;

    if (kIsWeb) {
      file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        final bytes = await file.readAsBytes();
        setState(() => _avatarBytes = bytes);
      }
    } else {
      file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        final bytes = await file.readAsBytes();
        setState(() => _avatarBytes = bytes);
      }
    }
  }

  // ---------------- SUBMIT ------------------
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    await Future.delayed(const Duration(seconds: 2)); // simulate network

    // TODO → call BLoC event

    // Keep loader visible (as you requested)
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width < 600
        ? MediaQuery.of(context).size.width * 0.9
        : 450.0;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text("تکمیل اطلاعات"), centerTitle: true),
          body: Center(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // ---------- AVATAR ----------
                        InkWell(
                          onTap: _pickAvatar,
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.15),
                            backgroundImage: _avatarBytes != null
                                ? MemoryImage(_avatarBytes!)
                                : null,
                            child: _avatarBytes == null
                                ? Icon(
                                    Icons.camera_alt_rounded,
                                    size: 36,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ---------- FIRST NAME ----------
                        TextFormField(
                          controller: _firstController,
                          decoration: const InputDecoration(labelText: "نام"),
                          validator: (v) {
                            if (v == null || v.isEmpty) return "نام اجباری است";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // ---------- LAST NAME ----------
                        TextFormField(
                          controller: _lastController,
                          decoration: const InputDecoration(
                            labelText: "نام خانوادگی",
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return "نام خانوادگی اجباری است";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // ---------- BUSINESS LINK ----------
                        TextFormField(
                          controller: _businessLinkController,
                          decoration: const InputDecoration(
                            labelText: "لینک پیج / فروشگاه",
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return "این فیلد اجباری است";
                            if (!v.startsWith("http"))
                              return "لینک معتبر وارد کنید";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // ---------- BANK ACCOUNT ----------
                        TextFormField(
                          controller: _bankController,
                          decoration: const InputDecoration(
                            labelText: "شماره حساب / کارت بانکی",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return "شماره حساب اجباری است";
                            if (v.length < 10) return "شماره حساب معتبر نیست";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // ---------- ADDRESS ----------
                        TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            labelText: "آدرس فروشگاه / محل کار",
                          ),
                          maxLines: 3,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return "آدرس اجباری است";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // ---------- POSTAL CODE ----------
                        TextFormField(
                          controller: _postalController,
                          decoration: const InputDecoration(
                            labelText: "کد پستی",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return "کد پستی اجباری است";
                            if (v.length != 10)
                              return "کد پستی باید ۱۰ رقم باشد";
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

                        // ---------- SUBMIT ----------
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _isSubmitting ? null : _submit,
                            child: const Text("ثبت اطلاعات"),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // ---------- FULLSCREEN LOADER ----------
        FullscreenLoader(
          visible: _isSubmitting,
          message: "در حال ذخیره اطلاعات...",
        ),
      ],
    );
  }
}
