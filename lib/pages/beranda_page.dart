import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/utils/text_styles.dart';
import 'package:flutter_camping_frontend/widgets/custom_chip.dart';
import 'package:flutter_camping_frontend/widgets/search_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int selectedFilterIndex = 0;

  final List<String> filters = ['Semua', 'Terfavorit', 'Camping Terbanyak'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset('assets/icons/campHome.svg'),
                      ),
                      Text("Halo Adam Rasyid",
                          style: AppTextStyle.semiBold16.copyWith(
                            color: Color(0xFF274F66),
                          )),
                    ],
                  ),
                  Text(
                    "Anda mau pergi camping di mana?",
                    style: AppTextStyle.bold24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SearchInput(
                      hintText: "Cari tempat camping",
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  Text("Eksplor Tempat Camping",
                      style: AppTextStyle.semiBold16),
                ],
              ),
            ),
            // Text("Filter") Biar bisa di scroll horizontal
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(filters.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: CustomChip(
                      label: filters[index],
                      isSelected: selectedFilterIndex == index,
                      onTap: () {
                        setState(() {
                          selectedFilterIndex = index;
                        });
                      },
                    ),
                  );
                }),
              ),
            ),
            Column(children: [Text("1"), Text("1"), Text("1")])
          ],
        ),
      ),
    );
  }
}
