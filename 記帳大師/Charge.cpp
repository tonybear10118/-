#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>





void date (void)
{
  system("echo %date%");      //��ܤ��Ѫ�����ɶ�
}

int write (void)           //write���|�}:num4���ƨϥ�
{
  FILE *fp;                //�ŧi�@���ɮ׫���
  FILE *full;              //�ŧi�@���ɮ׫���(�Ψӭp����)
  char judge;              //�ŧi�P�_�O�_�~���ܼ�
  char str4[80];           //�ŧi�B�~��O���ܼ�(���ئW��)
  int num1, num2, num3, num4, sum;          //num1~num3�O�������\�Anum4�O�B�~��O�Asum�Ototal��O
  char timeload[30];                        //�ŧi�@�Ӥ���ܼƨӨ��ɮצW�٥H����R�W
  

  time_t timep;                             //�ɶ�����
  time (&timep);                            //�ɶ�����


   
  printf("�п�J���Ѫ����(xxxx_xx_xx)\n");
  scanf("%s", &timeload);                   //��J�n��X���ɮצW�٪����
  strcat (timeload, ".txt");                //stract��ƥΨӦX�֦r��

  fp = fopen(timeload, "w");        //�}���ɮסA�Htimeload�R�W�A�ݩ�w

  if(fp == NULL)                    //�p�G�L���ɮ׫h��ܿ��~
  {
    printf("�L�k�}���ɮ�\n");
    return 1;
  }
 

  
  fprintf(fp, "%s\n\n", ctime(&timep));           //��J��a�q���ɶ����ɮײĤ@��(�H�Ѭ���)

  printf("How much is ur breakfast?\n");          
  scanf("%d", &num1);                             //��J���\����
  fprintf(fp, "Expenses of breakfast : %d NT\n", num1);       //��J���\������ɮ�
   
  printf("How much is ur lunch?\n"); 
  scanf("%d", &num2);                             //��J���\����
  fprintf(fp, "Expenses of lunch : %d NT\n", num2);           //��J���\������ɮ�
  
  printf("How much is ur dinner?\n");         
  scanf("%d", &num3);                             //��J���\����
  fprintf(fp, "Expenses of dinner : %d NT\n", num3);         //��J���\������ɮ�

  fflush(stdin);       //******���׭��n�A�L�o�����᪺����buffer

  sum = num1+num2+num3;                          //�[�`�T�\��O



 
  do                                             //���L�B�~���O���j��
  {
   printf("Spent money on other things?(Y or N)\n");
   judge = getchar();                            //��Jy or n�Ӫ�ܬO�_���O
  
   if(judge=='N' || judge=='n')                  //�p�G��Jn���ܴN���}�j��
   { 
       fprintf(fp, "\n\nend of charge\n=========================\n");             //�����O�b�A�i�J�`��O���
       break;    //�p�G�S������N��
   }

   fflush(stdin);       //******���׭��n�A�L�o�����᪺����buffer


   printf("please enter the name of costs.\n");
   gets(str4);                                                                    //��J�B�~��O���ت��W��
   fflush(stdin);       //******���׭��n�A�L�o�����᪺����buffer
   printf("how much is it?\n");                                          
   scanf("%d", &num4);                                                            //��J�B�~��O���ت����B
   fflush(stdin);       //******���׭��n�A�L�o�����᪺����buffer
   fprintf(fp, "Other expenses : %s %d NT\n", str4, num4);                        //��J�B�~��O�W�٤Ϊ��B���ɮפ�
   sum += num4;                                                                   //�T�\�O�Υ[�W�B�~�O��(�`�O��)

  }while(judge == 'Y' || judge == 'y');                                           //�p�G�W����Jy���ܴN�~��j��

  fprintf(fp, "Total expenses : %d NT\n=========================\n", sum);        //��J�`���B���ɮפ�
  fclose(fp);                                                                     //�����ɮ�
  printf("end of the process.\n"); 
  fflush(stdin); 



  full = fopen("Total.txt", "a");         //�}��total���ɮסA�i��g�A�Ψӭp��Ҧ��`���B
  
  if(full == NULL)                    //�p�G�L���ɮ׫h��ܿ��~
  {
    printf("�L�k�}���ɮ�\n");
    return 1;
  }

  fprintf(full, "%d", sum);           //��J�`���B���ɮ�
  fprintf(full, "\n");                //�Ŧ�
  fclose(full);                       //�����ɮ�
  

  return 0;



}//write�j�A��



int read (void)
{  
   FILE *stream;                           //�ŧi�ɮ׫���
   char read[400];                         //�ŧi�r��}�C�HŪ����r�ɮ�
   char timeload[30];                      //�ŧi�r��}�C�HŪ����J����A�M���ɮ�
   
   printf("�п�J���(xxxx_xx_xx)\n\n");
   scanf("%s", &timeload);                 //��J�n�䪺�ɮת����
   strcat (timeload, ".txt");              //stract��ƦX�֤����.txt�r��
   stream = fopen(timeload, "r");          //�}���ɮ�

  if(stream == NULL)                       //�p�G�䤣����ɮת��ܡA��ܿ��~
  {
    printf("�L�k�}���ɮסC\n\n");
    return 1;
  }
 
   fread(read, sizeof(int), 400, stream);    //Ū���ɮ�
   printf("%s", read);                       //��ܥX�ɮ�
   fclose(stream);                           //�����ɮ�
   fflush(stdin);                            //�M���w�s

   
   return 0;
}


int main (void)
{
   char judge;                 //�ŧi�P�_����ʧ@���ܼ�
    

   printf("Today's date is�G");
   date();                     //��ܤ��
   printf("\n");               //����
    
   while(judge!='3')          //��J3�ɵ����{��
   {
   fflush(stdin);
   printf("�n�O�b�٬OŪ�b�O�H\n1)�O�b\n2)Ū�b\n3)����\n");  
   scanf("%c", &judge);         //��ܰO�bŪ�b�ε���
  
   if(judge=='1')               //��J1=�O�b
     { write();fflush(stdin); }  //����write���
   else if(judge=='2')          //��J2=Ū�b
     { read(); fflush(stdin); } //����read���
   else if(judge=='3')          //��J3=�����{��
     {break;}
   else{}

 
   printf("\n���� -> (1)\n�~�� -> (2)\n");      //���F3�A�����L��Ӱʧ@��ݭn���n�A�~���L�ʧ@
   scanf("%c", &judge);
   if(judge=='1')  {break;}                     //��J1=�����{��
 

   }
   
   system("pause");                            //�t�μȰ��n���ϥΪ̬ݨ�
   return 0;
 
}
