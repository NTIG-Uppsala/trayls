package com.trayls.app;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;
import android.os.Vibrator;
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

import org.json.*;

public class MainActivity extends AppCompatActivity {

    private TextView welcomeText;



    @Override

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button getTaskBtn = (Button) findViewById(R.id.btnGetTask);


        welcomeText = (TextView) findViewById(R.id.textGetTask);



        getTaskBtn.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                apiCallAndChangeText();
                vibrateOnClick();
                //getSupportFragmentManager().beginTransaction().replace(R.id.loginFragment, new AccRejFragment()).commit();
            }
        });
    }




    private void apiCallAndChangeText(){
        RequestQueue queue = Volley.newRequestQueue(this);

        String url = "http://netlabua.se/task";
        final String[] newResponse = new String[1];

        StringRequest request = new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                try {
                    newResponse[0] = parseJson(response);
                }catch (Exception e){
                    newResponse[0] = "error was found";
                }
                welcomeText.setText(newResponse[0]);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d("error",error.toString());
            }
        });
        queue.add(request);
    }


    public String parseJson(String response) throws JSONException {
        JSONObject obj = new JSONObject(response);
        return obj.getString("task_query");
    }

    private void vibrateOnClick() {
        Vibrator v = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
        v.vibrate(75 );
    }
}