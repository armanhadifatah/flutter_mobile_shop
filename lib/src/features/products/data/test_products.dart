import '../domain/product.dart';
import '../domain/product_type.dart';

/// Test products to be used until a data source is implemented
var kTestProducts = [
  Product(
    id: '1',
    imageUrl: 'assets/products/galaxy.jpg',
    title: 'Galaxy S23',
    description: 'Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum',
    price: 15,
    colors: ['red', 'green', 'blue'],
    storages: ['16GB', '32GB', '64GB'],
    productTypes: [
      ProductType(imageUrl: 'assets/products/galaxy.jpg', name: 'Galaxy S23'),
      ProductType(imageUrl: 'assets/products/honor.jpg', name: 'Honor 20P'),
      ProductType(imageUrl: 'assets/products/huawei.png', name: 'huawei 50P'),
      ProductType(imageUrl: 'assets/products/iphone.jpeg', name: 'iphone 14'),
      ProductType(imageUrl: 'assets/products/mi.jpg', name: 'MI'),
    ],
  ),
  Product(
      id: '2',
      imageUrl: 'assets/products/honor.jpg',
      title: 'Honor 20P',
      description: 'Lorem ipsum',
      price: 13,
      colors: [
        'red',
        'green',
        'blue'
      ],
      storages: [
        '16GB',
        '32GB',
        '64GB'
      ],
      productTypes: [
        ProductType(imageUrl: 'assets/products/galaxy.jpg', name: 'Galaxy S23'),
        ProductType(imageUrl: 'assets/products/honor.jpg', name: 'Honor 20P'),
        ProductType(imageUrl: 'assets/products/huawei.png', name: 'huawei 50P'),
        ProductType(imageUrl: 'assets/products/iphone.jpeg', name: 'iphone 14'),
        ProductType(imageUrl: 'assets/products/mi.jpg', name: 'MI'),
      ]),
  Product(
      id: '3',
      imageUrl: 'assets/products/huawei.png',
      title: 'huawei 50P',
      description: 'Lorem ipsum',
      price: 17,
      colors: [
        'red',
        'green',
        'blue'
      ],
      storages: [
        '16GB',
        '32GB',
        '64GB'
      ],
      productTypes: [
        ProductType(imageUrl: 'assets/products/galaxy.jpg', name: 'Galaxy S23'),
        ProductType(imageUrl: 'assets/products/honor.jpg', name: 'Honor 20P'),
        ProductType(imageUrl: 'assets/products/huawei.png', name: 'huawei 50P'),
        ProductType(imageUrl: 'assets/products/iphone.jpeg', name: 'iphone 14'),
        ProductType(imageUrl: 'assets/products/mi.jpg', name: 'MI'),
      ]),
  Product(
      id: '4',
      imageUrl: 'assets/products/iphone.jpeg',
      title: 'iphone 14 ',
      description: 'Lorem ipsum',
      price: 14,
      colors: [
        'green',
        'blue'
      ],
      storages: [
        '128GB',
        '256GB',
        '512GB'
      ],
      productTypes: [
        ProductType(imageUrl: 'assets/products/galaxy.jpg', name: 'Galaxy S23'),
        ProductType(imageUrl: 'assets/products/honor.jpg', name: 'Honor 20P'),
        ProductType(imageUrl: 'assets/products/huawei.png', name: 'huawei 50P'),
        ProductType(imageUrl: 'assets/products/iphone.jpeg', name: 'iphone 14'),
        ProductType(imageUrl: 'assets/products/mi.jpg', name: 'MI'),
      ]),
  Product(
      id: '5',
      imageUrl: 'assets/products/mi.jpg',
      title: 'MI',
      description: 'Lorem ipsum',
      price: 16,
      colors: [
        'green',
        'blue'
      ],
      storages: [
        '128GB',
        '256GB',
        '512GB'
      ],
      productTypes: [
        ProductType(imageUrl: 'assets/products/galaxy.jpg', name: 'Galaxy S23'),
        ProductType(imageUrl: 'assets/products/honor.jpg', name: 'Honor 20P'),
        ProductType(imageUrl: 'assets/products/huawei.png', name: 'huawei 50P'),
        ProductType(imageUrl: 'assets/products/iphone.jpeg', name: 'iphone 14'),
        ProductType(imageUrl: 'assets/products/mi.jpg', name: 'MI'),
      ]),
  Product(
      id: '6',
      imageUrl: 'assets/products/oppo.jpg',
      title: 'Oppo',
      description: 'Oppo',
      price: 16,
      colors: [
        'green',
        'blue'
      ],
      storages: [
        '128GB',
        '256GB',
        '512GB'
      ],
      productTypes: [
        ProductType(imageUrl: 'assets/products/galaxy.jpg', name: 'Galaxy S23'),
        ProductType(imageUrl: 'assets/products/honor.jpg', name: 'Honor 20P'),
        ProductType(imageUrl: 'assets/products/huawei.png', name: 'huawei 50P'),
        ProductType(imageUrl: 'assets/products/iphone.jpeg', name: 'iphone 14'),
        ProductType(imageUrl: 'assets/products/mi.jpg', name: 'MI'),
      ]),
  Product(
      id: '7',
      imageUrl: 'assets/products/redmi.jpg',
      title: 'Redmi',
      description: 'Redmi',
      price: 16,
      colors: [
        'green',
        'blue'
      ],
      storages: [
        '128GB',
        '256GB',
        '512GB'
      ],
      productTypes: [
        ProductType(imageUrl: 'assets/products/galaxy.jpg', name: 'Galaxy S23'),
        ProductType(imageUrl: 'assets/products/honor.jpg', name: 'Honor 20P'),
        ProductType(imageUrl: 'assets/products/huawei.png', name: 'huawei 50P'),
        ProductType(imageUrl: 'assets/products/iphone.jpeg', name: 'iphone 14'),
        ProductType(imageUrl: 'assets/products/mi.jpg', name: 'MI'),
      ]),
];
