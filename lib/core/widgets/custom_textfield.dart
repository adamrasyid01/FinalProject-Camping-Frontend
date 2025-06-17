import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

// --- PERUBAHAN 1: Ubah menjadi StatefulWidget ---
class CustomTextfield extends StatefulWidget {
  final TextEditingController inputController;
  final String label;
  final TextInputType? keyboardType;
  final bool isObscureText; // Tidak lagi nullable, wajib diisi
  final String? obscureCharacter;
  final String hintText;
  final Color cursorColor;

  const CustomTextfield({
    super.key,
    required this.inputController,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false, // Default value tetap false
    this.obscureCharacter = '*',
    required this.hintText,
    this.cursorColor = Colors.black,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  // --- PERUBAHAN 2: Buat variabel state untuk mengontrol visibilitas password ---
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    // Inisialisasi state dengan nilai awal dari widget
    _isPasswordVisible = widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        TextFormField(
          cursorColor: widget.cursorColor,
          controller: widget.inputController,
          keyboardType: widget.keyboardType,
          // Gunakan state lokal, bukan properti widget
          obscureText: _isPasswordVisible,
          obscuringCharacter: widget.obscureCharacter!,
          decoration: InputDecoration(
            fillColor: MyColor().secondaryColor.withOpacity(0.1),
            constraints:
                BoxConstraints(maxHeight: height * 0.065, maxWidth: width),
            filled: true,
            hintText: widget.hintText,
            hintStyle: AppTextStyle.regular15.copyWith(
              color: Colors.grey,
            ),
            // --- PERUBAHAN 3: Tambahkan suffixIcon untuk tombol mata ---
            suffixIcon: widget.isObscureText
                ? IconButton(
                    icon: Icon(
                      // Pilih ikon berdasarkan state visibilitas
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // --- PERUBAHAN 4: Update state saat tombol ditekan ---
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null, // Jika bukan field password, tidak ada ikon
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: MyColor().secondaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: MyColor().secondaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: MyColor().primaryColor, // Beri warna saat fokus
                width: 2.0,
              ),
            ),
          ),
          validator: (value) {
            return value == null || value.isEmpty
                ? 'This field is required'
                : null;
          },
        ),
      ],
    );
  }
}
