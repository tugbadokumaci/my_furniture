enum ServicePath { LOGIN, SIGNUP, PRODUCTS, PRODUCTMODEL, SETFAVPRODUCT, CATEGORIES, POPULAR, SEARCH }

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.LOGIN:
        return '/login';
      case ServicePath.SIGNUP:
        return '/signup';
      case ServicePath.PRODUCTS:
        return '/getproducts.php';
      case ServicePath.PRODUCTMODEL:
        return '/getproductmodel.php';
      case ServicePath.SETFAVPRODUCT:
        return '/setfavproduct.php';
      case ServicePath.CATEGORIES:
        return '/getcategories.php';
      case ServicePath.POPULAR:
        return '/getproducts.php';
      case ServicePath.SEARCH:
        return '/getsearchresults.php';
    }
  }
}
