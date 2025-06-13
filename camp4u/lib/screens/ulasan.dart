import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Ulasan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back when pressed
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Product card (centered)
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(204, 255, 153, 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/tent_dome.png', 
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tenda Dome 4 Orang',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Text(
                          'Rp 150.000/hari',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(4, (index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Reviews list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                ReviewItemWithPhoto(
                  name: 'Monkey D Luffy',
                  date: '9 April 2022',
                  rating: 5,
                  comment: 'Sudah 2 kali berkemah menggunakan tenda ini. Kualitasnya bagus, mudah dipasang, dan tahan hujan. Sangat direkomendasikan untuk pemula',
                  image: 'assets/images/luffy.jpeg',
                  reviewPhoto: 'assets/images/review.jpeg',
                ),
                ReviewItem(
                  name: 'Nagi Seishiro',
                  date: '15 April 2022',
                  rating: 4,
                  comment: 'Sesuai dengan harganya. Lumayan untuk camping keluarga, tapi sedikit bocor saat hujan deras. Pemasangan cukup mudah dengan petunjuknya kurang jelas.',
                  image: 'assets/images/nagi.jpeg',
                ),
                ReviewItem(
                  name: 'Sukuna Ryomen',
                  date: '7 April 2022',
                  rating: 4,
                  comment: 'Tenda ini cukup kokoh, tahan angin kencang di pantai dan tidak-tidak. Material: Bungkus cukup rapi untuk 4 orang, ventilasi juga bagus, tidak panas.',
                  image: 'assets/images/sukuna.jpeg',
                ),
                ReviewItem(
                  name: 'Akabane Karma',
                  date: '5 April 2022',
                  rating: 3,
                  comment: 'Ringan dibawa naik gunung! Cuma bagian kantong agak kecil, jadi agak males suatu saat. Tapi nyaman untuk tidur taat camping.',
                  image: 'assets/images/karma.jpeg',
                ),
              ],
            ),
          ),
          
          // Write review button (centered)
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(122, 151, 72, 1),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tulis Ulasan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Original ReviewItem class
class ReviewItem extends StatelessWidget {
  final String name;
  final String date;
  final int rating;
  final String comment;
  final String image;

  const ReviewItem({
    Key? key,
    required this.name,
    required this.date,
    required this.rating,
    required this.comment,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Circular profile image
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Name and date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Star rating
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating ? Colors.amber : Colors.grey[300],
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Review text
          Text(
            comment,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// New ReviewItemWithPhoto class that includes a review photo
class ReviewItemWithPhoto extends StatelessWidget {
  final String name;
  final String date;
  final int rating;
  final String comment;
  final String image;
  final String reviewPhoto;

  const ReviewItemWithPhoto({
    Key? key,
    required this.name,
    required this.date,
    required this.rating,
    required this.comment,
    required this.image,
    required this.reviewPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Circular profile image
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Name and date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Star rating
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating ? Colors.amber : Colors.grey[300],
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Review text
          Text(
            comment,
            style: const TextStyle(fontSize: 13),
          ),
          
          // Review photo
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(reviewPhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}