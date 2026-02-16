import 'package:ecommerce_app/models/products_model/products_model.dart';

final List<Product> dummyProducts = [
  Product(
    id: '1',
    title: 'Wireless Headphones',
    description: 'High quality sound with active noise cancellation.',
    price: 99.99,
    images: [
      ProductImage(
        publicId: 'headphones_1',
        url: 'assets/products/headphones.png',
        alt: 'Wireless Headphones',
        id: 'img_1',
      ),
    ],
    category: 'Electronics',
    stock: 25,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    id: '2',
    title: 'Smart Watch',
    description: 'Track your fitness and stay connected with notifications.',
    price: 199.99,
    images: [
      ProductImage(
        publicId: 'watch_1',
        url: 'assets/products/watch.png',
        alt: 'Smart Watch',
        id: 'img_2',
      ),
    ],
    category: 'Electronics',
    stock: 15,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    id: '3',
    title: 'Running Shoes',
    description: 'Comfortable shoes for daily running and workouts.',
    price: 79.99,
    images: [
      ProductImage(
        publicId: 'shoes_1',
        url: 'assets/products/shoes.png',
        alt: 'Running Shoes',
        id: 'img_3',
      ),
    ],
    category: 'Fashion',
    stock: 42,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    id: '4',
    title: 'Leather Jacket',
    description: 'Premium leather jacket for men, stylish and durable.',
    price: 149.99,
    images: [
      ProductImage(
        publicId: 'jacket_1',
        url: 'assets/products/jacket.png',
        alt: 'Leather Jacket',
        id: 'img_4',
      ),
    ],
    category: 'Fashion',
    stock: 8,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    id: '5',
    title: 'Modern Lamp',
    description: 'A stylish LED lamp for your living room with adjustable brightness.',
    price: 49.99,
    images: [
      ProductImage(
        publicId: 'lamp_1',
        url: 'assets/products/lamp.png',
        alt: 'Modern Lamp',
        id: 'img_5',
      ),
    ],
    category: 'Home',
    stock: 33,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    id: '6',
    title: 'Beauty Products Set',
    description: 'Complete skincare set with moisturizer, serum, and cleanser.',
    price: 2000.00,
    images: [
      ProductImage(
        publicId: 'beauty_1',
        url: 'assets/products/beauty.png',
        alt: 'Beauty Products Set',
        id: 'img_6',
      ),
    ],
    category: 'Beauty',
    stock: 19,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    id: '7',
    title: 'iPhone 14 Pro',
    description: 'Latest smartphone with advanced camera and A16 chip.',
    price: 20455.00,
    images: [
      ProductImage(
        publicId: 'iphone_1',
        url: 'assets/products/iphone.png',
        alt: 'iPhone 14 Pro',
        id: 'img_7',
      ),
    ],
    category: 'Mobiles',
    stock: 23,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

// Note: The Product and ProductImage classes are already defined in your models file
// so you don't need to redefine them here