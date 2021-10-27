import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'lib/images/907106.jpg',
            image_caption: 'Chinese',
          ),
          Category(
            image_location: 'lib/images/bootstrap-carousel-slide-4.jpg',
            image_caption: 'Punjabi',
          ),
          Category(
            image_location: 'lib/images/food2.jpg',
            image_caption: 'Indian',
          ),
          Category(
            image_location:
                'lib/images/FSSAI-Drafts-Regulations-on-Safe-and-Wholesome-Food-for-School-Children.jpg',
            image_caption: 'Mexican',
          ),
          Category(
            image_location: 'lib/images/H220546cb02cc4c4da8e6dc437d0986d9f.jpg',
            image_caption: 'Desi',
          ),
          Category(
            image_location: 'lib/images/907106.jpg',
            image_caption: 'Chinese',
          ),
          Category(
            image_location: 'lib/images/bootstrap-carousel-slide-4.jpg',
            image_caption: 'Punjabi',
          ),
          Category(
            image_location: 'lib/images/food2.jpg',
            image_caption: 'Indian',
          ),
          Category(
            image_location:
                'lib/images/FSSAI-Drafts-Regulations-on-Safe-and-Wholesome-Food-for-School-Children.jpg',
            image_caption: 'Mexican',
          ),
          Category(
            image_location: 'lib/images/H220546cb02cc4c4da8e6dc437d0986d9f.jpg',
            image_caption: 'Desi',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({required this.image_location, required this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: 100.0,
            height: 150.0,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    image_location,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    image_caption,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            // ListTile(
            //   title: Image.asset(
            //     image_location,
            //     fit: BoxFit.cover,
            //   ),
            //   subtitle: Container(
            //     alignment: Alignment.topCenter,
            //     child: Text(image_caption, style:TextStyle(fontSize: 16.0),),
            //   )
            // ),
          ),
        ),
      ),
    );
  }
}
