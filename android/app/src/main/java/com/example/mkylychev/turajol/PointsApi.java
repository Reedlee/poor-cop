package com.example.mkylychev.turajol;

import com.google.gson.JsonObject;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;


import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import retrofit2.Call;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.http.Body;
import retrofit2.http.DELETE;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.Headers;
import retrofit2.http.POST;
import retrofit2.http.Path;

/**
 * Created by myrzabek on 3/9/17.
 */

public interface PointsApi {

    @GET("/")
    Call<List<OwnGeoPoint>> getData();


    @FormUrlEncoded
    @POST("/points")
    Call<OwnGeoPoint> createPoint(@Field("latitude") double latitude, @Field("longitude") double longitude);

    @POST("/points")
    Call<List<OwnGeoPoint>> createPointAbs(@Body OwnGeoPointRequest request);

    @DELETE("/points/{id}")
    Call<List<OwnGeoPoint>> deletePoint(@Path("id") int id);

    @GET("/points/{id}/confirm")
    Call<List<OwnGeoPoint>> confirmPoint(@Path("id") int id);


    OkHttpClient client = new OkHttpClient.Builder().addInterceptor(new Interceptor() {
        @Override
        public Response intercept(Chain chain) throws IOException {
            Request request = chain.request().newBuilder()
                    .addHeader("Accept", "application/json")
                    .addHeader("Content-type", "application/json")
                    .build();
            return chain.proceed(request);
        }
    }).build();
    Retrofit retrofit = new Retrofit.Builder()
            .baseUrl("https://turajol.herokuapp.com/")
            .addConverterFactory(GsonConverterFactory.create())
            .client(client)
            .build();

}
