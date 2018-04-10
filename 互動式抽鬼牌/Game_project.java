import java.util.Scanner;

public class Game_project
{

 public static void main(String[] aru)
 {
     Game myGame=new Game(); //開始新遊戲
     myGame.start(); //start the game     
     myGame.pairoff();   //拿掉成對的牌
     System.out.println("撲克牌大師的牌是不能被看到的"); //說明
    
     for(int e=2; e>1; e++)        //無窮回拳
     {
         myGame.round();           //運行round                                  
     }
     
     System.out.println("按enter鍵離開");
     Scanner scn = new Scanner(System.in);
     String p;
     p = scn.nextLine();
 }

}