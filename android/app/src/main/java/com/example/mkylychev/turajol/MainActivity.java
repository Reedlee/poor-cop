package com.example.mkylychev.turajol;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.os.StrictMode;
import android.provider.Settings;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import org.osmdroid.api.IMapController;
import org.osmdroid.events.MapEventsReceiver;
import org.osmdroid.tileprovider.tilesource.TileSourceFactory;
import org.osmdroid.util.GeoPoint;
import org.osmdroid.views.MapView;
import org.osmdroid.views.overlay.MapEventsOverlay;
import org.osmdroid.views.overlay.Marker;

import java.util.Timer;
import java.util.TimerTask;

public class MainActivity extends AppCompatActivity {
    GPSTracker gps;
    MapView map;
    Marker startMarker;
    int countZapros=0;
    long fonDur = 10000;
    Timer timer =new Timer();
    TimerTask timerTask;
    TimerTask timerTaskForTimer;
    private FirebaseDatabase mFirebaseDatabase;
    private DatabaseReference mMessagesDatabaseReference;
    private ChildEventListener mChildEventListener;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);
        org.osmdroid.tileprovider.constants.OpenStreetMapTileProviderConstants.setUserAgentValue(BuildConfig.APPLICATION_ID);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        mFirebaseDatabase = FirebaseDatabase.getInstance();
        mMessagesDatabaseReference = mFirebaseDatabase.getReference().child("geopoints");
        map = (MapView) findViewById(R.id.map);
        initMap();
        getPointsFromFireBaseDB();
        setTimer();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private void initMap() {
        gps=addMyLocationMarker();
        map.setTileSource(TileSourceFactory.MAPNIK);



        map.setBuiltInZoomControls(true);
        map.setMultiTouchControls(true);
        IMapController mapController = map.getController();
        mapController.setZoom(14);
       // GeoPoint startPoint = new GeoPoint(gps.getLatitude(), gps.getLongitude());
        GeoPoint bishkek=new GeoPoint(42.882004,74.582748);
        mapController.setCenter(bishkek);

        MapEventsReceiver mReceiver=new MapEventsReceiver() {
            @Override
            public boolean singleTapConfirmedHelper(final GeoPoint geoPoint) {
                Toast.makeText(getApplicationContext(),"lat= "+geoPoint.getLatitude()+",long= "+geoPoint.getLongitude(),Toast.LENGTH_LONG).show();
                AlertDialog.Builder builder=new AlertDialog.Builder(MainActivity.this);
                builder.setTitle("Обнаружили гаишника?");
                builder.setMessage("Вы уверены, что здесь расположен гаишник?");
                builder.setPositiveButton("Да", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Marker cop=new Marker(map);
                        cop.setPosition(geoPoint);
                        cop.setTitle("Здесь гаишник");
                        cop.setIcon(getResources().getDrawable(R.mipmap.police));
                        cop.setAnchor(Marker.ANCHOR_CENTER, Marker.ANCHOR_BOTTOM);
                        OwnGeoPoint ownGeoPoint=new OwnGeoPoint(geoPoint.getLatitude(),geoPoint.getLongitude());
                        mMessagesDatabaseReference.push().setValue(ownGeoPoint);
                        map.getOverlays().add(cop);
                        map.invalidate();
                    }
                });
                builder.setNegativeButton("Нет", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                });
                AlertDialog dialog=builder.create();
                dialog.show();

                return false;
            }

            @Override
            public boolean longPressHelper(GeoPoint geoPoint) {
                return false;
            }
        };
        MapEventsOverlay overlayEvents=new MapEventsOverlay(getApplicationContext(),mReceiver);
        map.getOverlays().add(overlayEvents);

        map.invalidate();

    }
        private void getPointsFromFireBaseDB(){
            mChildEventListener=new ChildEventListener() {
                @Override
                public void onChildAdded(DataSnapshot dataSnapshot, String s) {
                    OwnGeoPoint ownGeoPoint=dataSnapshot.getValue(OwnGeoPoint.class);
                    Marker cop=new Marker(map);
                    GeoPoint geoPoint=new GeoPoint(ownGeoPoint.getLatitude(),ownGeoPoint.getLongitude());
                    cop.setPosition(geoPoint);
                    cop.setTitle("Здесь гаишник");
                    cop.setIcon(getResources().getDrawable(R.mipmap.police));
                    cop.setAnchor(Marker.ANCHOR_CENTER, Marker.ANCHOR_BOTTOM);
                    map.getOverlays().add(cop);
                    map.invalidate();
                }

                @Override
                public void onChildChanged(DataSnapshot dataSnapshot, String s) {

                }

                @Override
                public void onChildRemoved(DataSnapshot dataSnapshot) {

                }

                @Override
                public void onChildMoved(DataSnapshot dataSnapshot, String s) {

                }

                @Override
                public void onCancelled(DatabaseError databaseError) {

                }
            };
            mMessagesDatabaseReference.addChildEventListener(mChildEventListener);
        }
    public GPSTracker addMyLocationMarker(){ //2в1-вычисляет координаты пользователя и обозначает маркером его местоположение на карте
        GPSTracker gps=getMyLocation();
        GeoPoint myLocationPoint=new GeoPoint(gps.getLatitude(),gps.getLongitude());
        if (startMarker!=null){
            map.getOverlays().remove(startMarker);
            Log.e("remove","1 marker removed");
        }
        startMarker = new Marker(map);
        startMarker.setPosition(myLocationPoint);
        startMarker.setIcon(getResources().getDrawable(R.drawable.ic_menu_compass));
        startMarker.setTitle("Мое место положение");
        startMarker.setAnchor(Marker.ANCHOR_CENTER, Marker.ANCHOR_BOTTOM);
//        startMarker.setOnMarkerClickListener(new Marker.OnMarkerClickListener() {
//            @Override
//            public boolean onMarkerClick(Marker marker, MapView mapView) {
//
//                Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
//                MainActivity.this.startActivity(intent);
//
//                return false;
//            }
//        });
        map.getOverlays().add(startMarker);
        map.invalidate();
        return gps;
    }
    public GPSTracker getMyLocation(){
        GPSTracker gps=new GPSTracker(getApplicationContext());


        if (gps.canGetLocation()) {

        } else {
            // can't get location
            // GPS or Network is not enabled
            // Ask user to enable GPS/network in settings
            //    gps.showSettingsAlert();
            if(countZapros==0){
                AlertDialog.Builder builder=new AlertDialog.Builder(this);
                builder.setTitle("GPS неактивен.\nПерейти в найстройки GPS?");
                builder.setPositiveButton("Да", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                        countZapros=1;
                        Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                        MainActivity.this.startActivity(intent);


                    }
                });
                builder.setNegativeButton("Нет", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        countZapros=1;
                    }
                });
                AlertDialog dialog=builder.create();
                dialog.show();

            }
        }
        return gps;
    }
    public void setTimer(){
        timerTask = new TimerTask() {
            public void run() {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        addMyLocationMarker();
                    }
                });
            }
        };
        setTimerForTimer();
        timer.schedule(timerTask, fonDur);
    }

    public void setTimerForTimer(){ //это временный метод
        timerTaskForTimer = new TimerTask() {
            public void run() {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        setTimer();
                    }
                });
            }
        };
        timer.schedule(timerTaskForTimer, fonDur);
    }


}

