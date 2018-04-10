import java.util.Scanner;
import java.util.Random;

class Game
{
  private DeckOfCards deck;
  int[][] player;
  int box1 = 0;                           //�ΨӺ⵲��
  int box2 = 0;                           //�ΨӺ⵲��
  int select;
  
  Game()
  {
    deck=new DeckOfCards();
    player=new int[2][];
    for(int i=0;i<2;i++)
        player[i]=new int[27];   //�C�Ӫ��a�t�m27�ӰO�����x�s�Ŷ�(27�i�P)
  }
  
  public void start()
  {
   //�}����
 //  this.open();
   deck.shuffle();                                                          
                                                   this.pause2(700);
   System.out.println("�o�P�I�I�I�I\n\n");         this.pause2(1000);           
   int i=0;
   while(!deck.isEmpty())   //��P�_�y���u�A�|�b����@��     //deal to 2 players term by term
   {   
        player[i%2][i/2]=deck.deal();        
        i++;
   }
  }
  public void showPlayersCards()
  {
     int i,j;
     for(i=0;i<2;i++)
     {
      System.out.println("Player"+(i+1)+" has:");
      for(j=0;j<27;j++)
        {
        DeckOfCards.showCard(player[i][j]);
        }
      System.out.print("\n\n");
     }   
 
  }

  public void show_onlyP1()     //�u��ܪ��a��W���P�A�q���P�H*���
  {
     int j;
     System.out.println("�z���o�ǵP�G");
     for(j=0; j<27; j++)                           //���a���P
     {
      DeckOfCards.showCard(player[0][j]);
     }
     System.out.print("\n\n");
     System.out.print("�Ⱝ�P�j�v���G\n");         //�q�����P
     for(j=0; j<27; j++)
     {
      DeckOfCards.hideCards(player[1][j], j+1);
     }
  }


 

  
   
public void pairoff()        //�ⱼ���諸�P
{
    int i = 0;
    int j = 0;
    int change = 0;          //�ѨM�ƥ�bug
    
  for(i=0; i<2; i++)       //�p�⪱�a  
  {      
     for(j=0; j<27; j++)   //�p��ĴX�i�P
     { 
        for(int q = 1; q<27-change; q++)    //���
        {   
          
 
       
          if(player[i][j]>52||player[i][j+q]>52)     //�׶}���P
               {continue;}
          
          if(player[i][j]%13==player[i][j+q]%13)     //�⦨�諸�P�ܬ�-1(���P����)
           {
               player[i][j] = -1;
               player[i][j+q] = -1;
           } 
      
        }
         
        change++;

     }
    
        change = 0;
  }

}


 /* public void selectCard()  //��ܩ�ĴX�i�P    
  {
    String selectNum = 0;      //�]�w����Ʀr���ܼ�
    Scanner scn = new Scanner(System.in); //�ͦ���J
    System.out.print("�A�n��Ⱝ�P�j�v���ĴX�i�P?(�ȭ����ԧB�Ʀr)\n");  
        
    selectNum = scn.nextLine();   //��J������Ʀr
    selectNum = this.inputInt(selectNum);
    


 } */    //public���j�A��


   public static void inputInt()
   {

 for(int g=2; g>1; g++)
 {
      try 
      {
         Scanner scn = new Scanner(System.in);
         select = scn.nextInt();    
         if(select>=1&&select<28)
          {
                  break;
          }   
         
         else
         {  
            System.out.println("�п�J1~27�I");
            continue;
         }
      }
      catch(Exception ex)
      {
             System.out.println("�п�J���ԧB�Ʀr�I");
             continue;
      }
 }
   }
   
  public void choseCPcard(int ch)       //��q���P
  {
    String[] suits={"�®� ","�R�� ","�٧� ","���� "};    //�®�006�A�R��003�A�٧�004�A����005
    String[] ranks={"A","2","3","4","5","6","7","8","9","10","J","Q","K"};
    String[] joker={"Joker1", "Joker2"};


for(int y = 1; y>0; y++)
{
    if(player[1][ch-1]==-1)             //�H�����a���Ů�
    {
      ch = this.select;
      
    } 
    else
    {break;}
}       
    
 
    for(int j=0; j<27; j++)        //�q���a��P�����Ů洡�J
        {
            if(player[0][j]==-1)       //���Ů�
            {
               player[0][j] = player[1][ch-1];      //���쪺�P���w��Ů�
               
               if(player[1][ch-1]==53||player[1][ch-1]==54)     //�i�D���a��찭�P
               {  
                    System.out.print("���ߧA��찭�P�~�~\n\n");
                    this.pause();
               }
               else                                             //�i�D���a��쪺���Ʀr
               {
                    System.out.print("���ߧA���G"+suits[(player[1][ch-1]-1)/13]);
                    System.out.print(ranks[(player[1][ch-1]-1)%13]+"\n\n");
                    this.pause();                  
               }
               player[1][ch-1] = -1;                            //���q�����P�Q�ⱼ
               break;
                                                         //���X�d��Ů檺�j��  
            }
            
        }     
        
        
     //else���j�A��     
     //for���j�A��

      
  }     //public���j�A��

   public int selectCard2()          //�H����P(�Ω�q���⪱�a���ɭ�)
   {
      
      Random r = new Random();
      int num;
      num = r.nextInt(27)+1;
      

      return num;
   }




    public void choseP1card(int ch)       //�q���⪱�a�P
  {
    String[] suits={"�®� ","�R�� ","�٧� ","���� "};    //�®�006�A�R��003�A�٧�004�A����005
    String[] ranks={"A","2","3","4","5","6","7","8","9","10","J","Q","K"};
    String[] joker={"Joker1", "Joker2"};







    for(int y=1; y>0; y++)
    {

      if(player[0][ch-1]==-1)             //�H���q�����Ů�
      {      
          ch = this.selectCard2();
          continue;
      }

      else
      {
      break;
      }

    } 

     
    
        for(int j=0; j<27; j++)        //�q�q����P�����Ů洡�J
        {
            if(player[1][j]==-1)       //���Ů�
            {
               player[1][j] = player[0][ch-1];      //���쪺�P���w��Ů�
               
               if(player[0][ch-1]==53||player[0][ch-1]==54)     //�i�D���a�q����찭�P
               {  
                    System.out.println("�Ⱝ�P�j�v��A�����P�⨫�F�~�~\n\n");
                      this.pause2(3000);
               }
               else                                             //�i�D���a�q����쪺���Ʀr
               {
                    System.out.print("�Ⱝ�P�j�v���A���G"+suits[(player[0][ch-1]-1)/13]);
                    System.out.print(ranks[(player[0][ch-1]-1)%13]+"\n\n");
                    this.pause2(3000);
               }
               player[0][ch-1] = -1;                           //�����a���P�Q�ⱼ
                     
               break;                                           //���X�d��Ů檺�j��  
            }    
        }


      
    }     //public���j�A��


     
  public void pause()       //�Ω�Ȱ�
  {
     System.out.print("��enter���~��....\n");                  //�ΥH�t�μȰ�
     Scanner stop = new Scanner(System.in);
     stop.nextLine();
  }

  public void pause2(int i)         //�ĤG�ؼȰ���k
  {
   try 
{
    Thread.sleep(i);       //�Ȱ�i*1000�@��(i��) 
}
 catch(InterruptedException ex) 
{
 
} 

  }

  public void round()
  {
     this.show_onlyP1();
     this.inputInt();                        //��P
     this.choseCPcard(this.select);     //������ƶǤJchoseCP
     this.show_onlyP1();                       //��ܪ��a��P���G
     System.out.println("��ۤv���諸�P����\n");
     this.pause();
     this.pairoff();
     this.show_onlyP1();
     this.end();                                /////
     this.trashtalk(this.trashnum());
     System.out.println("�Ⱝ�P�j�v���b�⪱�a���P�A�еy���C");
     this.pause2(3000);
     this.choseP1card(this.selectCard2());
     System.out.println("���I���Ⱝ�P�j�v���b�����L���諸�P�A�еy���C");
     this.pause2(3000);
     this.pairoff();
     this.show_onlyP1();
     this.end();                               //////
  }

  public void end()              //�t�d�a�Ʀr��end�s��
  {
     int j;
     box1 = 0;
     box2 = 0;

     for(j = 0; j<27; j++)         //�����a���Ҧ��Ʀr�[�_��
     {   
       box1 += player[0][j];
     }
     for(j=0; j<27; j++)           //���q�����Ҧ��Ʀr�[�_��
     { 
       box2 += player[1][j];
     } 
   
  
     if(box1==-27)
     {  
        this.star(20);
        System.out.println();
        System.out.print("�z��Ⱝ�P�j�v���o����y���I");
        System.out.println();
        this.star(20);
        System.out.println("\n\n��enter�����}");
        Scanner scn = new Scanner(System.in);
        String p;
     p = scn.nextLine();
        System.exit(0);
     }
   
     else if(box2==-27)
     {
         this.star(20);
         System.out.println();
         System.out.print("�A�Q�Ⱝ�P�j�v���w�F�I");
         System.out.println();
         this.star(20);
         System.out.println("\n\n��enter�����}");
         Scanner scn = new Scanner(System.in);
         String p;
         p = scn.nextLine();
         System.exit(0);
     }

     else               //�~��C��
     {  
     }           
 }

 


/////////////////////////////////////�H�U���O�Ʀn�ݥΪ�

public void star(int i)
{
  for(int j=1; j<=i; j++)
  {   
     System.out.print("*");
  }
}

public void open()                  //�}����
{
  this.star(50);                    this.pause2(300);
  System.out.print("\n");
  this.star(3);
  System.out.print("�q");           this.pause2(300);       
  System.out.print("�e");           this.pause2(300);   
  System.out.print("�q");           this.pause2(300);
  System.out.print("�e");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�@");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�A");           this.pause2(300);
  System.out.print("�H");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�L");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�G");           this.pause2(300);
  System.out.print("\n");           this.pause2(300);
  this.star(3);
  System.out.print("��");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�P");           this.pause2(300);
  System.out.print("�j");           this.pause2(300);
  System.out.print("�v");           this.pause2(300);
  System.out.print("\n");           this.pause2(300);
  this.star(3);
  System.out.print("�L");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�I");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�A");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�A");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("��");           this.pause2(300);
  System.out.print("�L");           this.pause2(300);
  System.out.print("�C");           this.pause2(300);
  System.out.print("�C");           this.pause2(300);
  System.out.print("�C");           this.pause2(300);
  System.out.print("�C");           this.pause2(300);
  System.out.print("�C\n");         this.pause2(300);
  this.star(50);
  System.out.print("\n\n");  
  System.out.print("�Ⱝ�P�j�v�G");           this.pause2(700);
  System.out.print("�z�n�I\n");               this.pause2(700);
  System.out.print("�Ⱝ�P�j�v�G");           this.pause2(700);
  System.out.print("�z�N�O�D�Ԫ̶�?\n");      this.pause2(700);    
  System.out.print("�Ⱝ�P�j�v�G");           this.pause2(700);
  System.out.print("���ڭ̻���}�l�a�I\n\n\n");   this.pause2(700);
  this.instruct();
  System.out.print("(�~�P�n....)\n\n");           this.pause2(1000);          
}

public void instruct()                    //�C������
{
   this.star(50);
   System.out.print("\n");
   this.star(10);
   System.out.print("�C������");
   this.star(32);
   System.out.print("\n");
   System.out.print("�C���W�h��²��A���q���Ⱝ�P�A\n�̫ᰭ�P�b�֤�W�N���F�I\n�����A�i�H�ۦ��ܭn���⪺���i�P�A\n���D�Ԧ��\�C\n\n");    
   this.star(50);
   System.out.println();
   this.pause();

}

public void trashtalk(int i)            //�U����
{
   switch(i)
   {
     case 5:
       {
       this.pause();
       System.out.print("\n�Ⱝ�P�j�v�G");    this.pause2(500);
       System.out.print("�N�u���o�I��O�H\n");this.pause2(1500);
       break;
       }
   
     case 4:
       {
       this.pause();
       System.out.print("\n�Ⱝ�P�j�v�G");    this.pause2(500);
       System.out.print("Soo EAAAAAASYYYYY�I�I�I\n");this.pause2(1500);
       break;
       }
  
      case 3:
       {
       this.pause();;
       System.out.print("\n�Ⱝ�P�j�v�G");    this.pause2(500);
       System.out.print("�j�@�I�n�ܡH\n");this.pause2(1500);
       break;
       }

       case 2:
       {
       this.pause();
       System.out.print("\n�Ⱝ�P�j�v�G");    this.pause2(500);
       System.out.print("�ڪ�������A�|��\n");this.pause2(1500);
       break;
       }

       case 1:
       {
       this.pause();
       System.out.print("\n�Ⱝ�P�j�v�G");    this.pause2(500);
       System.out.print("���P�I\n");this.pause2(900);
       break;
       }

       default:
       {
       this.pause();
       break;
       }
   }    
}

public int trashnum()        //���ͩU���ܪ��s��
{
  int num;
  Random r = new Random();
  num = r.nextInt(5);
  
  return num;
}
  










}         //class���j�A��