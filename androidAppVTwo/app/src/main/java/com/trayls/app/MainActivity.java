package com.trayls.app;

import androidx.appcompat.app.AppCompatActivity;


import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import org.json.*;

public class MainActivity extends AppCompatActivity {
    private Button getTaskBtn;

    private TextView welcomeText;


    @Override

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        getTaskBtn = (Button) findViewById(R.id.btnGetTask);
        welcomeText = (TextView) findViewById(R.id.welcomeText);
        getTaskBtn.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                apiCallAndChangeText();
            }
        });
    }

    private String parseJson(String apiOutPut) throws JSONException {

        JSONObject obj = new JSONObject(apiOutPut);

        return obj.getJSONArray("task_query").getString(Integer.parseInt("task_query"));
    }

    private void apiCallAndChangeText(){
        RequestQueue queue = Volley.newRequestQueue(this);

        String url = "http://netlabua.se/task";

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response ->     {
                    try {
                        welcomeText.setText(parseJson(response));
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                },error -> welcomeText.setText("That didn't work!"));
        queue.add(stringRequest);
    }
}