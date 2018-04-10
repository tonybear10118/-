#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>





void date (void)
{
  system("echo %date%");      //顯示今天的日期時間
}

int write (void)           //write的漏洞:num4重複使用
{
  FILE *fp;                //宣告一個檔案指標
  FILE *full;              //宣告一個檔案指標(用來計算整月)
  char judge;              //宣告判斷是否繼續的變數
  char str4[80];           //宣告額外花費的變數(項目名稱)
  int num1, num2, num3, num4, sum;          //num1~num3是早中午餐，num4是額外花費，sum是total花費
  char timeload[30];                        //宣告一個日期變數來使檔案名稱以日期命名
  

  time_t timep;                             //時間相關
  time (&timep);                            //時間相關


   
  printf("請輸入今天的日期(xxxx_xx_xx)\n");
  scanf("%s", &timeload);                   //輸入要輸出成檔案名稱的日期
  strcat (timeload, ".txt");                //stract函數用來合併字串

  fp = fopen(timeload, "w");        //開啟檔案，以timeload命名，屬性w

  if(fp == NULL)                    //如果無此檔案則顯示錯誤
  {
    printf("無法開啟檔案\n");
    return 1;
  }
 

  
  fprintf(fp, "%s\n\n", ctime(&timep));           //輸入當地電腦時間至檔案第一行(以供紀錄)

  printf("How much is ur breakfast?\n");          
  scanf("%d", &num1);                             //輸入早餐價錢
  fprintf(fp, "Expenses of breakfast : %d NT\n", num1);       //輸入早餐價格至檔案
   
  printf("How much is ur lunch?\n"); 
  scanf("%d", &num2);                             //輸入午餐價錢
  fprintf(fp, "Expenses of lunch : %d NT\n", num2);           //輸入午餐價格至檔案
  
  printf("How much is ur dinner?\n");         
  scanf("%d", &num3);                             //輸入晚餐價錢
  fprintf(fp, "Expenses of dinner : %d NT\n", num3);         //輸入晚餐價格至檔案

  fflush(stdin);       //******極度重要，過濾掉之後的換行buffer

  sum = num1+num2+num3;                          //加總三餐花費



 
  do                                             //有無額外消費的迴圈
  {
   printf("Spent money on other things?(Y or N)\n");
   judge = getchar();                            //輸入y or n來表示是否消費
  
   if(judge=='N' || judge=='n')                  //如果輸入n的話就離開迴圈
   { 
       fprintf(fp, "\n\nend of charge\n=========================\n");             //結束記帳，進入總花費顯示
       break;    //如果沒有花錢就停
   }

   fflush(stdin);       //******極度重要，過濾掉之後的換行buffer


   printf("please enter the name of costs.\n");
   gets(str4);                                                                    //輸入額外花費項目的名稱
   fflush(stdin);       //******極度重要，過濾掉之後的換行buffer
   printf("how much is it?\n");                                          
   scanf("%d", &num4);                                                            //輸入額外花費項目的金額
   fflush(stdin);       //******極度重要，過濾掉之後的換行buffer
   fprintf(fp, "Other expenses : %s %d NT\n", str4, num4);                        //輸入額外花費名稱及金額至檔案內
   sum += num4;                                                                   //三餐費用加上額外費用(總費用)

  }while(judge == 'Y' || judge == 'y');                                           //如果上面輸入y的話就繼續迴圈

  fprintf(fp, "Total expenses : %d NT\n=========================\n", sum);        //輸入總金額至檔案內
  fclose(fp);                                                                     //關閉檔案
  printf("end of the process.\n"); 
  fflush(stdin); 



  full = fopen("Total.txt", "a");         //開啟total的檔案，可續寫，用來計算所有總金額
  
  if(full == NULL)                    //如果無此檔案則顯示錯誤
  {
    printf("無法開啟檔案\n");
    return 1;
  }

  fprintf(full, "%d", sum);           //輸入總金額至檔案
  fprintf(full, "\n");                //空行
  fclose(full);                       //關閉檔案
  

  return 0;



}//write大括號



int read (void)
{  
   FILE *stream;                           //宣告檔案指標
   char read[400];                         //宣告字串陣列以讀取文字檔案
   char timeload[30];                      //宣告字串陣列以讀取輸入日期再尋找檔案
   
   printf("請輸入日期(xxxx_xx_xx)\n\n");
   scanf("%s", &timeload);                 //輸入要找的檔案的日期
   strcat (timeload, ".txt");              //stract函數合併日期跟.txt字串
   stream = fopen(timeload, "r");          //開啟檔案

  if(stream == NULL)                       //如果找不到該檔案的話，顯示錯誤
  {
    printf("無法開啟檔案。\n\n");
    return 1;
  }
 
   fread(read, sizeof(int), 400, stream);    //讀取檔案
   printf("%s", read);                       //顯示出檔案
   fclose(stream);                           //關閉檔案
   fflush(stdin);                            //清除緩存

   
   return 0;
}


int main (void)
{
   char judge;                 //宣告判斷執行動作的變數
    

   printf("Today's date is：");
   date();                     //顯示日期
   printf("\n");               //換行
    
   while(judge!='3')          //輸入3時結束程式
   {
   fflush(stdin);
   printf("要記帳還是讀帳呢？\n1)記帳\n2)讀帳\n3)結束\n");  
   scanf("%c", &judge);         //選擇記帳讀帳或結束
  
   if(judge=='1')               //輸入1=記帳
     { write();fflush(stdin); }  //執行write函數
   else if(judge=='2')          //輸入2=讀帳
     { read(); fflush(stdin); } //執行read函數
   else if(judge=='3')          //輸入3=結束程式
     {break;}
   else{}

 
   printf("\n結束 -> (1)\n繼續 -> (2)\n");      //除了3，執行其他兩個動作後看要不要再繼續其他動作
   scanf("%c", &judge);
   if(judge=='1')  {break;}                     //輸入1=結束程式
 

   }
   
   system("pause");                            //系統暫停好讓使用者看到
   return 0;
 
}
