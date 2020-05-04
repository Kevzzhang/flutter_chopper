import 'package:chopper/chopper.dart';
import 'package:flutterwithchopper/data/mobile_data_interceptor.dart';
import 'package:flutterwithchopper/model/built_post.dart';
import 'package:built_collection/built_collection.dart';

import 'built_value_converter.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: '/{id}')
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  // Put & Patch requests are specified the same way - they must contain the @Body
  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: BuiltValueConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        MobileDataInterceptor(),
      ],
    );
    return _$PostApiService(client);
  }
}
