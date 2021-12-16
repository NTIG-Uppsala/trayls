package com.trayls.app;

import androidx.appcompat.app.AppCompatActivity;


import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;


public class MainActivity extends AppCompatActivity {

    private TextView welcomeText;

    @Override

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


/*
        Button getTaskBtn = (Button) findViewById(R.id.btnGetTask);
        welcomeText = (TextView) findViewById(R.id.welcome);
        getTaskBtn.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                apiCallAndChangeText();
            }
        });*/
    }


    private void apiCallAndChangeText(){
        RequestQueue queue = Volley.newRequestQueue(this);

        String url = "http://netlabua.se/task";

        StringRequest request = new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                welcomeText.setText(response.toString());
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d("error",error.toString());
            }
        });
        queue.add(request);
    }
}