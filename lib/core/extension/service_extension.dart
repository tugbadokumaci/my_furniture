enum ServicePath {
  LOGIN,
  SIGNUP,
  PRODUCTS,
  CATEGORIES,
  POPULAR,
}

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.LOGIN:
        return '/login';
      case ServicePath.SIGNUP:
        return '/signup';
      case ServicePath.PRODUCTS:
        return '/getproducts.php';
      case ServicePath.CATEGORIES:
        return '/getcategories.php';
      case ServicePath.POPULAR:
        return '/getproducts.php';
    }
  }
}
