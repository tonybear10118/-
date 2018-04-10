import java.util.Random;

public class DeckOfCards
{
 //資料成員
 private int[] cards;
 private int numofcard;
 
 DeckOfCards()
 { 
   int i;
   cards=new int[54]; //一花色13張          /**
   numofcard=54;
   //init cards  1~52   
   //1:spade A,  2:spade 2, ...13: Spade K, 14:Heart A, ... 26:Heart K, 27:Diamod A.... 
   for(i=0;i<numofcard;i++) 
   {
     cards[i]=i+1;
   }

 }
 
 void showAll() //show all the cards left in the deck from bottom up
 {
   int i;
   for(i=numofcard-1;i>=0;i--)
   {
     showCard(cards[i]);

   }  

 }
 
 public boolean isEmpty()
 {
   if(numofcard==0)
      return true;
    else
      return false;
 } 
 
 public void shuffle() //shuffle all the cards left in the deck
 {
   Random r=new Random();
   int index;
   int temp;
   int i;
   for(i=0;i<numofcard;i++)
   {
    index=r.nextInt(54);       //有變動
    //swap cards[i] with cards[index]
    temp=cards[i];
    cards[i]=cards[index];
    cards[index]=temp; 
   }

 }
 
 static void showCard(int i)  //show suit and rank for the given number(1-52)
 {
   
   String[] suits={"黑桃 ","愛心 ","菱形 ","梅花 "};    //黑桃006，愛心003，菱形004，梅花005
   String[] ranks={"A","2","3","4","5","6","7","8","9","10","J","Q","K"};
   String[] joker={"Joker1", "Joker2"};

   if(i==-1)
    {
    //System.out.print("\n");            //The deck is empty     
    }
   else if(i==53)
   {
    System.out.print(joker[0]+"\n");  
   }   
   else if(i==54)
   {
    System.out.print(joker[1]+"\n");
   }
   else
   {
    System.out.print(suits[(i-1)/13]);          
    System.out.print(ranks[(i-1)%13]+"\n");
   }
 }

 
  public int deal()  //deal one card from the deck
 {
    if(numofcard==0)
      return -1;
    else
      return cards[--numofcard];
 }


 static void hideCards(int i, int j)    //顯示卡片但隱藏電腦手上的牌
 {
    if(i==-1)           //空白
    {
    }

    else
    {
    System.out.print("*\n");      //用*隱藏手牌
    }  
 }





}