import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/search/cubit/state.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import '../../../../models/shop_app/search_model.dart';
import '../../../../shared/network/end_poits.dart';
import '../../../../shared/network/local/cache_helper.dart';

class SearchCubit extends Cubit<SearchState>{

  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel? searchModel;
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: productssearch,
         token: CacheHelper.getData(key:'token'),
         data: {
           'text':text,
         },
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSucssesState());

    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    }
    );

  }
}