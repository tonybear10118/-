import java.util.Scanner;

public class Game_project
{

 public static void main(String[] aru)
 {
     Game myGame=new Game(); //�}�l�s�C��
     myGame.start(); //start the game     
     myGame.pairoff();   //�������諸�P
     System.out.println("���J�P�j�v���P�O����Q�ݨ쪺"); //����
    
     for(int e=2; e>1; e++)        //�L�a�^��
     {
         myGame.round();           //�B��round                                  
     }
     
     System.out.println("��enter�����}");
     Scanner scn = new Scanner(System.in);
     String p;
     p = scn.nextLine();
 }

}