package com.example.trivenibanpela.ninja;

/**
 * Created by trivenibanpela on 2/29/16.
 */
import android.content.Context;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import java.util.ArrayList;
import java.util.Random;


public class GamePanel extends SurfaceView implements SurfaceHolder.Callback
{
    public static final int WIDTH = 856;
    public static final int HEIGHT = 480;
    public static final int MOVESPEED = -5;
    //private long smokeStartTime;
    private long fruitStartTime;
    private MainThread thread;
    private Background bg;
    private Player player;
    //private ArrayList<Smokepuff> smoke;
    private ArrayList<Fruit> fruits;
    private Random rand = new Random();


    public GamePanel(Context context)
    {
        super(context);


        //add the callback to the surfaceholder to intercept events
        getHolder().addCallback(this);

        thread = new MainThread(getHolder(), this);

        //make gamePanel focusable so it can handle events
        setFocusable(true);
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height){}

    @Override
    public void surfaceDestroyed(SurfaceHolder holder){
        boolean retry = true;
        int counter = 0;
        while(retry && counter<1000)
        {
            counter++;
            try{thread.setRunning(false);
                thread.join();
                retry = false;

            }catch(InterruptedException e){e.printStackTrace();}

        }

    }

    @Override
    public void surfaceCreated(SurfaceHolder holder){

        bg = new Background(BitmapFactory.decodeResource(getResources(), R.drawable.wood2));
        player = new Player(BitmapFactory.decodeResource(getResources(), R.drawable.axe), 65, 25, 3);
        //smoke = new ArrayList<Smokepuff>();
        fruits = new ArrayList<Fruit>();
        //smokeStartTime=  System.nanoTime();
        fruitStartTime = System.nanoTime();



        //we can safely start the game loop
        thread.setRunning(true);
        thread.start();

    }
    @Override
    public boolean onTouchEvent(MotionEvent event)
    {
        if(event.getAction()==MotionEvent.ACTION_DOWN){
            if(!player.getPlaying())
            {
                player.setPlaying(true);
            }
            else
            {
                player.setUp(true);
            }
            return true;
        }
        if(event.getAction()==MotionEvent.ACTION_UP)
        {
            player.setUp(false);
            return true;
        }

        return super.onTouchEvent(event);
    }

    public void update()

    {
        if(player.getPlaying()) {

            bg.update();
            player.update();

            //add fruits on timer
            long fruitElapsed = (System.nanoTime()-fruitStartTime)/1000000;
            if(fruitElapsed >(2000 - player.getScore()/4)){

                System.out.println("making fruit");
                //first fruit always goes down the middle
                if(fruits.size()==0)
                {
                    fruits.add(new Fruit(BitmapFactory.decodeResource(getResources(),R.drawable.
                            melon),WIDTH + 10, HEIGHT/2, 128, 128, player.getScore(), 13));
                }
                else
                {

                    fruits.add(new Fruit(BitmapFactory.decodeResource(getResources(),R.drawable.melon),
                            WIDTH+10, (int)(rand.nextDouble()*(HEIGHT)),128,128, player.getScore(),13));
                }

                //reset timer
                fruitStartTime = System.nanoTime();
            }
            //loop through every fruit and check collision and remove
            for(int i = 0; i<fruits.size();i++)
            {
                //update fruit
                fruits.get(i).update();

                if(collision(fruits.get(i),player))
                {
                    fruits.remove(i);
                    player.setPlaying(false);
                    break;
                }
                //remove fruit if it is way off the screen
                if(fruits.get(i).getX()<-100)
                {
                    fruits.remove(i);
                    break;
                }
            }

/*

            //add smoke puffs on timer
            long elapsed = (System.nanoTime() - smokeStartTime)/1000000;
            if(elapsed > 120){
                smoke.add(new Smokepuff(player.getX(), player.getY()+10));
                smokeStartTime = System.nanoTime();
            }

            for(int i = 0; i<smoke.size();i++)
            {
                smoke.get(i).update();
                if(smoke.get(i).getX()<-10)
                {
                    smoke.remove(i);
                }
            } */
        }
    }
    public boolean collision(GameObject a, GameObject b)
    {
        if(Rect.intersects(a.getRectangle(),b.getRectangle()))
        {
            return true;
        }
        return false;
    }
    @Override
    public void draw(Canvas canvas)
    {
        final float scaleFactorX = getWidth()/(WIDTH*1.f);
        final float scaleFactorY = getHeight()/(HEIGHT*1.f);

        if(canvas!=null) {
            final int savedState = canvas.save();



            canvas.scale(scaleFactorX, scaleFactorY);
            bg.draw(canvas);
            player.draw(canvas);
            //draw smokepuffs
           /* for(Smokepuff sp: smoke)
            {
                sp.draw(canvas);
            }*/
            //draw fruits
            for(Fruit m: fruits)
            {
                m.draw(canvas);
            }






            canvas.restoreToCount(savedState);
        }
    }


}