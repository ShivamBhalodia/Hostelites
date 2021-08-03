import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List product_list = [
    {
      "name": "P_1",
      "picture": 'lib/images/907106.jpg',
    },
    {
      "name": "P_2",
      "picture": 'lib/images/bootstrap-carousel-slide-4.jpg',
    },
    {
      "name": "P_3",
      "picture": 'lib/images/food2.jpg',
    },
    {
      "name": "p_4",
      "picture":
          'lib/images/FSSAI-Drafts-Regulations-on-Safe-and-Wholesome-Food-for-School-Children.jpg',
    },
    {
      "name": "P_5",
      "picture": 'lib/images/H220546cb02cc4c4da8e6dc437d0986d9f.jpg',
    },
    {
      "name": "P_6",
      "picture": 'lib/images/bootstrap-carousel-slide-4.jpg',
    },
    {
      "name": "P_7",
      "picture": 'lib/images/907106.jpg',
    },
    {
      "name": "P_8",
      "picture": 'lib/images/907106.jpg',
    },
    {
      "name": "P_9",
      "picture": 'lib/images/bootstrap-carousel-slide-4.jpg',
    },
    {
      "name": "P_10",
      "picture": 'lib/images/food2.jpg',
    },
    {
      "name": "p_11",
      "picture":
          'lib/images/FSSAI-Drafts-Regulations-on-Safe-and-Wholesome-Food-for-School-Children.jpg',
    },
    {
      "name": "P_12",
      "picture": 'lib/images/H220546cb02cc4c4da8e6dc437d0986d9f.jpg',
    },
    {
      "name": "P_13",
      "picture": 'lib/images/bootstrap-carousel-slide-4.jpg',
    },
    {
      "name": "P_14",
      "picture": 'lib/images/907106.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: product_list[index]['name'],
              prod_pricture: product_list[index]['picture'],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;

  Single_prod({
    this.prod_name,
    this.prod_pricture,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: prod_name,
        child: Material(
          child: InkWell(
            onTap: () {},
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    prod_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.favorite_border),
                ),
              ),
              child: Image.asset(
                prod_pricture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
