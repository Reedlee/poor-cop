package com.example.mkylychev.turajol;

import java.util.List;

import retrofit2.Call;

/**
 * Created by myrzabek on 1/21/17.
 */

public class OwnGeoPoint  {
    int id;
    double latitude;
    double longitude;
    int counter;

    public OwnGeoPoint(){

    }

    public OwnGeoPoint(double latitude, double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public int getCounter() {
        return counter;
    }

    public void setCounter(int counter) {
        this.counter = counter;
    }



}

