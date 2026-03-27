package com.example.motivationalquotes;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
import java.util.Random;

public class MainActivity extends Activity {

    private static final String[] QUOTES = {
        "Believe you can and you're halfway there.\n— Theodore Roosevelt",
        "The only way to do great work is to love what you do.\n— Steve Jobs",
        "In the middle of every difficulty lies opportunity.\n— Albert Einstein",
        "It does not matter how slowly you go as long as you do not stop.\n— Confucius",
        "Life is what happens when you're busy making other plans.\n— John Lennon",
        "The future belongs to those who believe in the beauty of their dreams.\n— Eleanor Roosevelt",
        "Success is not final, failure is not fatal: it is the courage to continue that counts.\n— Winston Churchill",
        "You miss 100% of the shots you don't take.\n— Wayne Gretzky",
        "Whether you think you can or you think you can't, you're right.\n— Henry Ford",
        "The best time to plant a tree was 20 years ago. The second best time is now.\n— Chinese Proverb",
        "An unexamined life is not worth living.\n— Socrates",
        "Spread love everywhere you go. Let no one ever come to you without leaving happier.\n— Mother Teresa",
        "When you reach the end of your rope, tie a knot in it and hang on.\n— Franklin D. Roosevelt",
        "Always remember that you are absolutely unique. Just like everyone else.\n— Margaret Mead",
        "Don't judge each day by the harvest you reap but by the seeds that you plant.\n— Robert Louis Stevenson"
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Random random = new Random();
        String quote = QUOTES[random.nextInt(QUOTES.length)];

        TextView quoteText = (TextView) findViewById(R.id.quote_text);
        quoteText.setText(quote);
    }
}
