import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/models/list_wisata_model.dart';
import 'package:flutter_camping_frontend/utils/text_styles.dart';
import 'package:flutter_camping_frontend/widgets/custom_chip.dart';
import 'package:flutter_camping_frontend/widgets/custom_list_wisata.dart';
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
  static const urlPrefix =
      'https://docs.flutter.dev/cookbook/img-files/effects/parallax';

  static const locations = [
    ListWisataModel(
      name: 'Mount Rushmore',
      place: 'U.S.A',
      imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
    ),
    ListWisataModel(
      name: 'Gardens By The Bay',
      place: 'Singapore',
      imageUrl: '$urlPrefix/02-singapore.jpg',
    ),
    ListWisataModel(
      name: 'Machu Picchu',
      place: 'Peru',
      imageUrl: '$urlPrefix/03-machu-picchu.jpg',
    ),
    ListWisataModel(
      name: 'Vitznau',
      place: 'Switzerland',
      imageUrl: '$urlPrefix/04-vitznau.jpg',
    ),
    ListWisataModel(
      name: 'Bali',
      place: 'Indonesia',
      imageUrl: '$urlPrefix/05-bali.jpg',
    ),
    ListWisataModel(
      name: 'Mexico City',
      place: 'Mexico',
      imageUrl: '$urlPrefix/06-mexico-city.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: buildFilterBeranda(),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return CustomListWisata(
                    imageUrl: location.imageUrl,
                    name: location.name,
                    country: location.place,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildFilterBeranda() {
    return Row(
      children: List.generate(filters.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
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
    );
  }
}
