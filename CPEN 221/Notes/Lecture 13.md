# **CPEN 221 Lecture 21: Multithreading**
### November 7 2024

``` Java
public class Threading {
    
    public static void main(String[] args) {
        MyThread[] threads = new MyThread[10];

        for (int i = 0; i < threads.length; i++) {
            threads[i] = new Thread(new MyThread2());
            threads[i].start();
        }
    }

    class MyThread2 implements Runnable {
        public void run() {
            System.out.println("Runnable Interface Instance");
        }
    }

    class MyThread extends Thread {
        public void run() {
            System.out.println(Thread.currentThread().getName());
        }
    }
}
```
