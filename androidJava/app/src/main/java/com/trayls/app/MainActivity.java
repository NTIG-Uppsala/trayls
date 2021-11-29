package com.trayls.app;


import android.content.Context;
import android.os.Bundle;
import android.os.Vibrator;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import valley



public class MainActivity extends AppCompatActivity {

    private TextView taskTxt;
    private Button submitBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        taskTxt = (TextView)findViewById(R.id.taskTxt);
        submitBtn = (Button)findViewById(R.id.btnNewTask);

        submitBtn.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                vibrateOnClick();
                apiCallAndChangeText();
            }
        });

    }
    private void apiCallAndChangeText(){
        // Start reqQ
        RequestQueue queue = Volley.newRequestQueue(this);
        String url ="https://walk-api.azurewebsites.net/gettask";

        // Req string from url
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {
                    taskTxt.setText(response);
                }, error -> taskTxt.setText("That didn't work!"));

        // Q reqQ
        queue.add(stringRequest);
    }
    private void vibrateOnClick() {
        Vibrator v = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
        v.vibrate(75 );
    }
}