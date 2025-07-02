
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/category.dart';
import '../../models/api_response.dart';
import '../../models/brand.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/sub_category.dart';
import '../../models/user.dart';
import '../../services/http_services.dart';
import '../../utility/constants.dart';
import '../../utility/snack_bar_helper.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();
    final box = GetStorage();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;



  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _allProducts;


  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;


  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;



  DataProvider() {

   initialize();
  

  }

Future<void> initialize() async {

    await loadInitialData();
  }
  // In your DataProvider, implement staggered loading
Future<void> loadInitialData() async {
  _isLoading = true;
  notifyListeners();

  // Load critical data first
  await getAllCategory();
  
  // Then load secondary data
  await Future.wait([
    getAllProduct(),
    getAllPosters(),
   
  ]);

  // Finally load non-essential data
  await Future.wait([
    getAllBrands(),
    getAllSubCategory(),
  ]);

  _isLoading = false;
  notifyListeners();
}

  User? getLoginUsr() {
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
    User? userLogged = User.fromJson(userJson ?? {});
    return userLogged;
  }


 Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'categories');

      if (response.isOk) {
        print('category fetched');
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Category.fromJson(item)).toList(),
        );
        _allCategories = apiResponse.data ?? [];
        _filteredCategories = List.from(_allCategories);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      } else {
        SnackBarHelper.showErrorSnackBar(
            'failed to load category: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredCategories;
  }

  void filterCategories(String keyboard) {
    if (keyboard.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    } else {
      final lowerKeyboard = keyboard.toLowerCase();
      _filteredCategories = _allCategories
          .where((category) =>
              (category.name ?? '').toLowerCase().contains(lowerKeyboard))
          .toList();
    }
    notifyListeners();
  }

  Future<List<SubCategory>> getAllSubCategory({bool showSnack = false}) async {
    try {
      final response = await service.getItems(endpointUrl: 'subCategory');
      if (response.isOk) {
         print('Subcategory fetched');
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => SubCategory.fromJson(item)).toList(),
        );
        _allSubCategories = apiResponse.data ?? [];
        _filteredSubCategories = List.from(_allSubCategories);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      } else {
        SnackBarHelper.showErrorSnackBar(
            'failed to fetch sub-category : ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('failed to fetch sub-category :${e}');
      rethrow;
    }

    return _filteredSubCategories;
  }

  void filterSubCategories(String keyboard) {
    if (keyboard.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    } else {
      final lowerKeyboard = keyboard.toLowerCase();
      _filteredSubCategories = _allSubCategories
          .where((subCategory) =>
              (subCategory.name ?? '').toLowerCase().contains(lowerKeyboard))
          .toList();
    }
    notifyListeners();
  }

  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      final response = await service.getItems(endpointUrl: 'brand');
      if (response.isOk) {
         print('Brand fetched');
        ApiResponse<List<Brand>> apiResponse = ApiResponse.fromJson(
            response.body,
            (json) =>
                (json as List).map((item) => Brand.fromJson(item)).toList());
        _allBrands = apiResponse.data ?? [];
        _filteredBrands = List.from(_allBrands);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      } else {
        SnackBarHelper.showErrorSnackBar(
            'failed to load brand ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Failed to load brand ${e}');
      rethrow;
    }
    return _filteredBrands;
  }

  void filterBrands(String keyboard) {
    if (keyboard.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    } else {
      final lowerKeyboard = keyboard.toLowerCase();
      _filteredBrands = _allBrands
          .where((brand) =>
              (brand.name ?? '').toLowerCase().contains(lowerKeyboard))
          .toList();
    }
    notifyListeners();
  }



  Future <List<Product>> getAllProduct({bool showSnack = false}) async {
    try {
      final response = await service.getItems(endpointUrl: 'products');
      if (response.isOk) {
         print('Product fetched');
        ApiResponse<List<Product>> apiResponse = ApiResponse.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Product.fromJson(item)).toList(),
        );
        _allProducts = apiResponse.data ?? [];
        _filteredProducts = List.from(_allProducts);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Failed to load products: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Failed to load products: $e');
      rethrow;
    }
    return _filteredProducts;
  }

  void filterProducts(String keyboard) {
    if (keyboard.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    } else {
      final lowerKeyboard = keyboard.toLowerCase();
      _filteredProducts = _allProducts.where((product) {
        final productNameContainsKeyword =
            (product.name ?? '').toLowerCase().contains(lowerKeyboard);
        final categoryNameContainsKeyword = product.proCategoryId?.name
                ?.toLowerCase()
                .contains(lowerKeyboard) ??
            false;
        final subCategoryNameContainsKeyword = product.proSubCategoryId?.name
                ?.toLowerCase()
                .contains(lowerKeyboard) ??
            false;
        return productNameContainsKeyword ||
            categoryNameContainsKeyword ||
            subCategoryNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }



Future<List<Poster>> getAllPosters({bool showSnack = false}) async {
    try {
      final response = await service.getItems(endpointUrl: 'posters');
      if (response.isOk) {
         print('Poster fetched');
        ApiResponse<List<Poster>> apiResponse = ApiResponse.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Poster.fromJson(item)).toList(),
        );
        _allPosters = apiResponse.data ?? [];
        _filteredPosters = List.from(_allPosters);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Failed to load posters: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Failed to load posters: $e');
      rethrow;
    }
    return _filteredPosters;
  }



  
  getAllOrderByUser()async {
    final String orderUrl = 'orders/orderByUserId/${getLoginUsr()?.sId.toString() ?? ''}';
  
    try {
      final response = await service.getItems(endpointUrl: orderUrl);
      if (response.isOk) {
        ApiResponse<List<Order>> apiResponse = ApiResponse.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Order.fromJson(item)).toList(),
        );
        _allOrders = apiResponse.data ?? [];
        _filteredOrders = List.from(_allOrders);
        notifyListeners();
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Order Load failed: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Failed to load orders: $e');
      rethrow;
    }
    
  }


  double calculateDiscountPercentage(num originalPrice, num? discountedPrice) {
    if (originalPrice <= 0) {
      throw ArgumentError('Original price must be greater than zero.');
    }

    //? Ensure discountedPrice is not null; if it is, default to the original price (no discount)
    num finalDiscountedPrice = discountedPrice ?? originalPrice;

    if (finalDiscountedPrice > originalPrice) {
     return originalPrice.toDouble();
    }

    double discount = ((originalPrice - finalDiscountedPrice) / originalPrice) * 100;

    //? Return the discount percentage as an integer
    return discount;
  }


}
