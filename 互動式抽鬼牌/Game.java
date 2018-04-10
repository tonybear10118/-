import java.util.Scanner;
import java.util.Random;

class Game
{
  private DeckOfCards deck;
  int[][] player;
  int box1 = 0;                           //用來算結局
  int box2 = 0;                           //用來算結局
  int select;
  
  Game()
  {
    deck=new DeckOfCards();
    player=new int[2][];
    for(int i=0;i<2;i++)
        player[i]=new int[27];   //每個玩家配置27個記憶體儲存空間(27張牌)
  }
  
  public void start()
  {
   //開場白
 //  this.open();
   deck.shuffle();                                                          
                                                   this.pause2(700);
   System.out.println("發牌！！！！\n\n");         this.pause2(1000);           
   int i=0;
   while(!deck.isEmpty())   //當判斷句為真，會在執行一次     //deal to 2 players term by term
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

  public void show_onlyP1()     //只顯示玩家手上的牌，電腦牌以*表示
  {
     int j;
     System.out.println("您有這些牌：");
     for(j=0; j<27; j++)                           //玩家的牌
     {
      DeckOfCards.showCard(player[0][j]);
     }
     System.out.print("\n\n");
     System.out.print("抽鬼牌大師有：\n");         //電腦的牌
     for(j=0; j<27; j++)
     {
      DeckOfCards.hideCards(player[1][j], j+1);
     }
  }


 

  
   
public void pairoff()        //抽掉成對的牌
{
    int i = 0;
    int j = 0;
    int change = 0;          //解決數目bug
    
  for(i=0; i<2; i++)       //計算玩家  
  {      
     for(j=0; j<27; j++)   //計算第幾張牌
     { 
        for(int q = 1; q<27-change; q++)    //比對
        {   
          
 
       
          if(player[i][j]>52||player[i][j+q]>52)     //避開鬼牌
               {continue;}
          
          if(player[i][j]%13==player[i][j+q]%13)     //把成對的牌變為-1(等同不見)
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


 /* public void selectCard()  //選擇抽第幾張牌    
  {
    String selectNum = 0;      //設定選取數字的變數
    Scanner scn = new Scanner(System.in); //生成輸入
    System.out.print("你要抽抽鬼牌大師的第幾張牌?(僅限阿拉伯數字)\n");  
        
    selectNum = scn.nextLine();   //輸入選取的數字
    selectNum = this.inputInt(selectNum);
    


 } */    //public的大括號


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
            System.out.println("請輸入1~27！");
            continue;
         }
      }
      catch(Exception ex)
      {
             System.out.println("請輸入阿拉伯數字！");
             continue;
      }
 }
   }
   
  public void choseCPcard(int ch)       //抽電腦牌
  {
    String[] suits={"黑桃 ","愛心 ","菱形 ","梅花 "};    //黑桃006，愛心003，菱形004，梅花005
    String[] ranks={"A","2","3","4","5","6","7","8","9","10","J","Q","K"};
    String[] joker={"Joker1", "Joker2"};


for(int y = 1; y>0; y++)
{
    if(player[1][ch-1]==-1)             //以防玩家抽到空格
    {
      ch = this.select;
      
    } 
    else
    {break;}
}       
    
 
    for(int j=0; j<27; j++)        //從玩家手牌中找到空格插入
        {
            if(player[0][j]==-1)       //找到空格
            {
               player[0][j] = player[1][ch-1];      //把抽到的牌指定到空格
               
               if(player[1][ch-1]==53||player[1][ch-1]==54)     //告訴玩家抽到鬼牌
               {  
                    System.out.print("恭喜你抽到鬼牌ㄏㄏ\n\n");
                    this.pause();
               }
               else                                             //告訴玩家抽到的花色數字
               {
                    System.out.print("恭喜你抽到："+suits[(player[1][ch-1]-1)/13]);
                    System.out.print(ranks[(player[1][ch-1]-1)%13]+"\n\n");
                    this.pause();                  
               }
               player[1][ch-1] = -1;                            //讓電腦的牌被抽掉
               break;
                                                         //跳出查找空格的迴圈  
            }
            
        }     
        
        
     //else的大括號     
     //for的大括號

      
  }     //public的大括號

   public int selectCard2()          //隨機抽牌(用於電腦抽玩家的時候)
   {
      
      Random r = new Random();
      int num;
      num = r.nextInt(27)+1;
      

      return num;
   }




    public void choseP1card(int ch)       //電腦抽玩家牌
  {
    String[] suits={"黑桃 ","愛心 ","菱形 ","梅花 "};    //黑桃006，愛心003，菱形004，梅花005
    String[] ranks={"A","2","3","4","5","6","7","8","9","10","J","Q","K"};
    String[] joker={"Joker1", "Joker2"};







    for(int y=1; y>0; y++)
    {

      if(player[0][ch-1]==-1)             //以防電腦抽到空格
      {      
          ch = this.selectCard2();
          continue;
      }

      else
      {
      break;
      }

    } 

     
    
        for(int j=0; j<27; j++)        //從電腦手牌中找到空格插入
        {
            if(player[1][j]==-1)       //找到空格
            {
               player[1][j] = player[0][ch-1];      //把抽到的牌指定到空格
               
               if(player[0][ch-1]==53||player[0][ch-1]==54)     //告訴玩家電腦抽到鬼牌
               {  
                    System.out.println("抽鬼牌大師把你的鬼牌抽走了ㄏㄏ\n\n");
                      this.pause2(3000);
               }
               else                                             //告訴玩家電腦抽到的花色數字
               {
                    System.out.print("抽鬼牌大師抽到你的："+suits[(player[0][ch-1]-1)/13]);
                    System.out.print(ranks[(player[0][ch-1]-1)%13]+"\n\n");
                    this.pause2(3000);
               }
               player[0][ch-1] = -1;                           //讓玩家的牌被抽掉
                     
               break;                                           //跳出查找空格的迴圈  
            }    
        }


      
    }     //public的大括號


     
  public void pause()       //用於暫停
  {
     System.out.print("按enter鍵繼續....\n");                  //用以系統暫停
     Scanner stop = new Scanner(System.in);
     stop.nextLine();
  }

  public void pause2(int i)         //第二種暫停方法
  {
   try 
{
    Thread.sleep(i);       //暫停i*1000毫秒(i秒) 
}
 catch(InterruptedException ex) 
{
 
} 

  }

  public void round()
  {
     this.show_onlyP1();
     this.inputInt();                        //選牌
     this.choseCPcard(this.select);     //把選取函數傳入choseCP
     this.show_onlyP1();                       //顯示玩家抽牌結果
     System.out.println("把自己成對的牌拿掉\n");
     this.pause();
     this.pairoff();
     this.show_onlyP1();
     this.end();                                /////
     this.trashtalk(this.trashnum());
     System.out.println("抽鬼牌大師正在抽玩家的牌，請稍等。");
     this.pause2(3000);
     this.choseP1card(this.selectCard2());
     System.out.println("陰險的抽鬼牌大師正在拿掉他成對的牌，請稍等。");
     this.pause2(3000);
     this.pairoff();
     this.show_onlyP1();
     this.end();                               //////
  }

  public void end()              //負責家數字的end零件
  {
     int j;
     box1 = 0;
     box2 = 0;

     for(j = 0; j<27; j++)         //讓玩家的所有數字加起來
     {   
       box1 += player[0][j];
     }
     for(j=0; j<27; j++)           //讓電腦的所有數字加起來
     { 
       box2 += player[1][j];
     } 
   
  
     if(box1==-27)
     {  
        this.star(20);
        System.out.println();
        System.out.print("您把抽鬼牌大師打得落花流水！");
        System.out.println();
        this.star(20);
        System.out.println("\n\n按enter鍵離開");
        Scanner scn = new Scanner(System.in);
        String p;
     p = scn.nextLine();
        System.exit(0);
     }
   
     else if(box2==-27)
     {
         this.star(20);
         System.out.println();
         System.out.print("你被抽鬼牌大師打趴了！");
         System.out.println();
         this.star(20);
         System.out.println("\n\n按enter鍵離開");
         Scanner scn = new Scanner(System.in);
         String p;
         p = scn.nextLine();
         System.exit(0);
     }

     else               //繼續遊戲
     {  
     }           
 }

 


/////////////////////////////////////以下都是排好看用的

public void star(int i)
{
  for(int j=1; j<=i; j++)
  {   
     System.out.print("*");
  }
}

public void open()                  //開場白
{
  this.star(50);                    this.pause2(300);
  System.out.print("\n");
  this.star(3);
  System.out.print("從");           this.pause2(300);       
  System.out.print("前");           this.pause2(300);   
  System.out.print("從");           this.pause2(300);
  System.out.print("前");           this.pause2(300);
  System.out.print("有");           this.pause2(300);
  System.out.print("一");           this.pause2(300);
  System.out.print("隻");           this.pause2(300);
  System.out.print("熊");           this.pause2(300);
  System.out.print("，");           this.pause2(300);
  System.out.print("人");           this.pause2(300);
  System.out.print("們");           this.pause2(300);
  System.out.print("稱");           this.pause2(300);
  System.out.print("他");           this.pause2(300);
  System.out.print("為");           this.pause2(300);
  System.out.print("：");           this.pause2(300);
  System.out.print("\n");           this.pause2(300);
  this.star(3);
  System.out.print("抽");           this.pause2(300);
  System.out.print("鬼");           this.pause2(300);
  System.out.print("牌");           this.pause2(300);
  System.out.print("大");           this.pause2(300);
  System.out.print("師");           this.pause2(300);
  System.out.print("\n");           this.pause2(300);
  this.star(3);
  System.out.print("他");           this.pause2(300);
  System.out.print("陰");           this.pause2(300);
  System.out.print("險");           this.pause2(300);
  System.out.print("狡");           this.pause2(300);
  System.out.print("猾");           this.pause2(300);
  System.out.print("，");           this.pause2(300);
  System.out.print("希");           this.pause2(300);
  System.out.print("望");           this.pause2(300);
  System.out.print("你");           this.pause2(300);
  System.out.print("能");           this.pause2(300);
  System.out.print("打");           this.pause2(300);
  System.out.print("敗");           this.pause2(300);
  System.out.print("他");           this.pause2(300);
  System.out.print("。");           this.pause2(300);
  System.out.print("。");           this.pause2(300);
  System.out.print("。");           this.pause2(300);
  System.out.print("。");           this.pause2(300);
  System.out.print("。\n");         this.pause2(300);
  this.star(50);
  System.out.print("\n\n");  
  System.out.print("抽鬼牌大師：");           this.pause2(700);
  System.out.print("您好！\n");               this.pause2(700);
  System.out.print("抽鬼牌大師：");           this.pause2(700);
  System.out.print("您就是挑戰者嗎?\n");      this.pause2(700);    
  System.out.print("抽鬼牌大師：");           this.pause2(700);
  System.out.print("讓我們趕緊開始吧！\n\n\n");   this.pause2(700);
  this.instruct();
  System.out.print("(洗牌聲....)\n\n");           this.pause2(1000);          
}

public void instruct()                    //遊戲說明
{
   this.star(50);
   System.out.print("\n");
   this.star(10);
   System.out.print("遊戲說明");
   this.star(32);
   System.out.print("\n");
   System.out.print("遊戲規則很簡單，普通的抽鬼牌，\n最後鬼牌在誰手上就算輸了！\n期間你可以自行選擇要抽對手的哪張牌，\n祝挑戰成功。\n\n");    
   this.star(50);
   System.out.println();
   this.pause();

}

public void trashtalk(int i)            //垃圾話
{
   switch(i)
   {
     case 5:
       {
       this.pause();
       System.out.print("\n抽鬼牌大師：");    this.pause2(500);
       System.out.print("就只有這點實力？\n");this.pause2(1500);
       break;
       }
   
     case 4:
       {
       this.pause();
       System.out.print("\n抽鬼牌大師：");    this.pause2(500);
       System.out.print("Soo EAAAAAASYYYYY！！！\n");this.pause2(1500);
       break;
       }
  
      case 3:
       {
       this.pause();;
       System.out.print("\n抽鬼牌大師：");    this.pause2(500);
       System.out.print("強一點好嗎？\n");this.pause2(1500);
       break;
       }

       case 2:
       {
       this.pause();
       System.out.print("\n抽鬼牌大師：");    this.pause2(500);
       System.out.print("我阿嬤都比你會玩\n");this.pause2(1500);
       break;
       }

       case 1:
       {
       this.pause();
       System.out.print("\n抽鬼牌大師：");    this.pause2(500);
       System.out.print("輕鬆！\n");this.pause2(900);
       break;
       }

       default:
       {
       this.pause();
       break;
       }
   }    
}

public int trashnum()        //產生垃圾話的零件
{
  int num;
  Random r = new Random();
  num = r.nextInt(5);
  
  return num;
}
  










}         //class的大括號