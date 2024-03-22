import 'package:bloc/bloc.dart';
import 'package:expense_tracker/repository/expense_repository.dart';
import 'package:expense_tracker/repository/models/category.dart';
import 'package:expense_tracker/screen/add_expense/bloc/get_category/get_category_event.dart';
import 'package:expense_tracker/screen/add_expense/bloc/get_category/get_category_state.dart';




class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  ExpenseRepository expenseRepository;

  GetCategoriesBloc(this.expenseRepository) : super(GetCategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      emit(GetCategoriesLoading());
      try {
        List<Category> categories = await expenseRepository.getCategory();
        emit(GetCategoriesSuccess(categories));
      } catch (e) {
        emit(GetCategoriesFailure());
      }
    });
  }
}