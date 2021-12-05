import 'package:flutter/material.dart';
import 'package:polywin/shared/constants.dart';

class ProductTabBarScreen extends StatelessWidget {
  const ProductTabBarScreen({Key key, this.categoryName, this.itemCount, this.images}) : super(key: key);

  final String categoryName;
  final int itemCount;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Polywin',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      categoryName,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2/2,
                  crossAxisCount: 2,
                ),
                itemCount: itemCount,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(kBaseURL+images[index]),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
