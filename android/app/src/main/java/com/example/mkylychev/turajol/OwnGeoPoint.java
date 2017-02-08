package com.example.mkylychev.turajol;

/**
 * Created by myrzabek on 1/21/17.
 */

public class OwnGeoPoint {
    double latitude;
    double longitude;

    public OwnGeoPoint(){

    }

    public OwnGeoPoint(double latitude, double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
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
}
