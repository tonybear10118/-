/* 
 * File:   main.cpp
 * Author: TeemoBear
 *
 * Created on 2018年4月11日, 上午 3:14
 */

# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <cstdlib>
using namespace std;

enum TokenType { IDENTIFIER = 34512, CONSTANT = 87232, SPECIAL = 29742 } ;

typedef char * CharPtr ;

struct Column {
  int column ;                  // 此token(的字首)在本line有出現於此column
  Column * next;                // 下一個此token(在本line)有出現的column
} ; // Column

typedef Column * ColumnPtr ;

struct Line {                   // struct Line 記錄了4種資訊
  int line ;                    // 此token放在哪一 line
  ColumnPtr firstAppearAt ;     // 指到此token第一次出現在此line的哪一column
  ColumnPtr lastAppearAt ;      // 指到此token最後出現在此line的哪一column
  Line *  next;                 // 同一 token 下一次出現在哪一 line
} ;

typedef Line * LinePtr ;

struct Token {                  // Struct token 紀錄了4種資訊
  CharPtr tokenStr ;            // tokenStr 放你切下來的token
  TokenType type;               // type 紀錄此token是屬於哪一個case
  LinePtr firstAppearOn ;       // 此 token 第一次出現在哪一 line
  LinePtr lastAppearOn ;        // 此 token 最後出現在哪一 line
  Token * next ;                // 指向下一個token
} ; // struct Token

typedef Token * TokenPtr ;


TokenPtr gFront = NULL, gRear = NULL ;  // 分別指向Token串列的頭跟尾

typedef char Str100[ 100 ] ; // 此型別是打算用來宣告一個陣列變數、以供讀字串之用

int gLine = 1 ;              // 「下一個要讀進來的字元」所在的line number
int gColumn = 1 ;            // 「下一個要讀進來的字元」所在的column number
bool stillhaveinput = true ;

void TrackToken( char & inputchar ) ;
void ReadNonespace( char & inputchar ) ;
void IfIdentifier( char startchar ) ;
void IfNumberOrCharOrString( char startchar ) ;
void IfSpecial( char startchar ) ;
void EveryCaseLast( char inputchar ) ;
TokenPtr HaveTokenOrNot( CharPtr token ) ;
void InsertNullLink( CharPtr token, TokenType type, int gLine, int column, int gColumn ) ;
void AddToLink( CharPtr token, TokenType type, int gLine, int column, int gColumn ) ;
void UpdateToken( TokenPtr & inserttoken, CharPtr token, TokenType type, int gLine, int column, int gColumn ) ;
void BubbleSort() ;
void Swap(  TokenPtr a, TokenPtr b ) ;
void PrintToken( ) ;
void UserInterface() ;
int HowManyToken( ) ;
void HowManyEach() ;
void SearchToken() ;
void PrintTokenOnLine() ;



int main(int argc, char** argv) {
  char inputchar ;
  while ( stillhaveinput ) {
     ReadNonespace( inputchar ) ;
  } // while
  
 BubbleSort() ; // Sort them
 PrintToken() ; // Print all Token
 // 開始使用者輸入
 UserInterface() ;
} // main()

void TrackToken( char & inputchar ) {
  if ( scanf( "%c", &inputchar ) == EOF ) stillhaveinput = false ; 
  
  else { // keep going
    if ( inputchar == '\n' ) {
      gLine++;
      gColumn = 1 ;
    } // if
  
    else gColumn++;
  } // else keep going
} // TrackToken()

void ReadNonespace( char & inputchar ) {
  TrackToken( inputchar ) ;
  if ( ! stillhaveinput ) { // stop tec
    inputchar = '\0';
    return ;
  } // if 
    
  if ( inputchar == '_' || 
         ( inputchar >= 65 && inputchar <= 90 ) || 
         ( inputchar >= 97 && inputchar <= 122 ) ) 
    IfIdentifier( inputchar ) ;
  else if ( ( inputchar >= 48 && inputchar <= 57  )|| 
                  inputchar == 39 || inputchar == '"' ) 
    IfNumberOrCharOrString( inputchar ) ;
  else  if (  inputchar == '+' || inputchar == '-' || inputchar == '*' || inputchar == '/' ||
                    inputchar == '>' || inputchar == '<' || inputchar == '=' ||
                    inputchar == '?' ||
                    inputchar == '%' || inputchar == '&' || 
                    inputchar == '|' || inputchar == '^' || // " 跟 ' 判斷地方在上面
                    inputchar == '.' || inputchar == ',' || inputchar == '(' || inputchar == ')' ||
                    inputchar == '[' || inputchar == ']' || inputchar == '{' || inputchar == '}' ||
                    inputchar == '!' || inputchar == ':' ||
                    inputchar == ';' || inputchar == '#'  ) 
     IfSpecial( inputchar ) ;
  
  else  ReadNonespace( inputchar ) ;
} // ReadNonespace()

void IfIdentifier( char startchar ) {
  int column = gColumn-1 ;
  CharPtr token = "" ; 
  Str100 temp = "";
  char fornext ;
  int i = 1 ;
  temp[0] = startchar ;
  TrackToken( temp[i] ) ;
  while ( temp[i] == '_' || 
               ( temp[i] >= 65 && temp[i] <= 90 )   || // A-Z
               ( temp[i] >= 97 && temp[i] <= 122 ) || // a-z
               ( temp[i] >= 48 && temp[i] <= 57 )       // 0-9
             ) {
    i++;
    TrackToken( temp[i] ) ;
  } // while
  
  
  token = new char[ ( strlen(temp) + 1 ) ] ;
  fornext = temp[i];
  temp[i] = '\0' ; // 清除不符合這CASE的字元
  strcpy( token, temp ); // now we got the token!
  // 開始加入串鍊TOKEN
  
  
  
  if ( strcmp( token, "END_OF_FILE" ) != 0 ) {
    if ( gFront == NULL ) { // first time
      InsertNullLink( token, IDENTIFIER, gLine, column, gColumn ) ;
    } // if
  
    else { // secend time
      TokenPtr findtemp = NULL ;
      findtemp = HaveTokenOrNot( token ) ;
      if ( findtemp != NULL ) {
        UpdateToken( findtemp, token, IDENTIFIER, gLine, column, gColumn ) ;
      } // if
      else AddToLink( token, IDENTIFIER, gLine, column, gColumn ) ;
    } // else secend time
  } // if END_OF_FILE
  
  else stillhaveinput = false ;
  
  EveryCaseLast( fornext ) ; // 一定是讀到不符合資源跳出的，但是這個字元是甚麼呢？

} // IfIdentifier()





void IfNumberOrCharOrString( char startchar ) {
  CharPtr token = "" ;
  Str100 temp = "";
  char fornext ;
  int i = 1 ;
  int column = gColumn-1 ;

  temp[0] = startchar ;
  //temp[0] = '\0'; // dont know why
  
  if ( startchar >= 48 && startchar <= 57  ) { // is number
    TrackToken( temp[i] ) ;
    while ( ( temp[i] >= 48 && temp[i] <= 57 ) || temp[i] == '.' ) { // still number
      i++;
      TrackToken( temp[i] ) ;
    } // while
    
    fornext = temp[i];
    temp[i] = '\0' ; // 清除不符合這CASE的字元順便結尾
    // There's a bug .
    
    // 以下這個切記放最後再處理不然出大事
    EveryCaseLast( fornext ) ; // 一定是讀到不符合資源跳出的，但是這個字元是甚麼呢？
  } // if is number
  
  
  
  else if ( startchar == '"' ) { // "might" be a String or
    TrackToken( temp[i] ) ;
    while ( temp[i] != '"' ) { // still in String
      i++;
      TrackToken( temp[i] ) ;
    } // while
    

   
  } // else if "might" be a String or
  
  
  
  else if ( startchar == 39 ) { // "might" be a char or
    TrackToken( temp[i] ) ;
    while ( temp[i] != 39 ) { // still in String
      i++;
      TrackToken( temp[i] ) ;
    } // while

  } // else if "might" be a char or
  
  token = new char[ ( strlen(temp) + 1 ) ] ;
  //token[0] = startchar ; // 此時還沒用 '\0'結尾
  //token[1] = '\0';
  strcpy( token, temp ); // now we got the token!
  
   // 以下開始串接TOKEN
  if ( gFront == NULL ) 
   InsertNullLink( token, CONSTANT, gLine, column, gColumn ) ;
  else { // secend time 
    TokenPtr findtemp = NULL ;
    findtemp = HaveTokenOrNot( token ) ;
    if ( findtemp != NULL ) {
      UpdateToken( findtemp, token, CONSTANT, gLine, column, gColumn ) ;
    } // if
    else AddToLink( token, CONSTANT, gLine, column, gColumn ) ;
  } //else secend time
} // IfNumberOrCharOrString





void IfSpecial( char startchar ) {
  CharPtr token = "" ; 
  Str100 temp = "";
  char whatisit = '\0';
  int t = 1 ;
  int column = gColumn-1 ;
  bool havedouble = false ;
  temp[0] = startchar ; // new
  
  // 有個例外狀況，假如今天/ 進來是註解的話....
  if ( startchar == '/' ) { // detect is // , /* or not
    TrackToken( whatisit ) ;
    if ( whatisit == '/'  ) { // 是一行註解
      while ( whatisit != '\n' ) // 讀到換行為止
        TrackToken( whatisit ) ;
      
      return ; // 跳出這個函數
    } // if 是一行註解
    
    else if ( whatisit == '*' ) { // 也是註解
    // 必須是連續 * 跟 / 的結合體才可以斷句  
      while ( true ) {
        TrackToken( whatisit ) ;
        if ( whatisit == '*' ) {
          TrackToken( whatisit ) ;
          if ( whatisit == '/' ) return ; // 找到註解了，跳出
          else havedouble = true ;
        } // if first condition
      } // while
    } // else if 也是註解
    
    else { // opps, 這不是註解，誤會了
      havedouble = true ;
    } // else
  } // if
  
  
  
  // 不是註解的話開始進行TOKEN作業
  // 有可能是雙字元構成的運算子，因此要在這裡檢查
  if ( startchar == '+' || startchar == '=' || startchar == '&' || startchar == '|'  ) { 
        // if == ++ && || 
    TrackToken( whatisit ) ;
    if ( whatisit == startchar ) {
      temp[1] = whatisit ;
      //token[1] = whatisit ;
      //t = 2 ;
    } // if
    else havedouble = true ;
  } // if might be a '++'

  else if ( startchar == '!' ) { // else if !=
    TrackToken( whatisit ) ;
    if ( whatisit == '=' ) {
      temp[1] = whatisit ;
    } // if is !=
    else havedouble = true ;
  } // else if
  
  else if ( startchar == '<' ) { // else if << <=
    TrackToken( whatisit ) ;
    if ( whatisit == '<' || whatisit == '=' ) { // equlas << <=
      temp[1] = whatisit ;
    } // if
    else havedouble = true ;
  } // else if
  
  else if ( startchar == '>' ) { // else if >> >=
    TrackToken( whatisit ) ;
    if ( whatisit == '>' || whatisit == '=' ) { // equlas >> >=
      temp[1] = whatisit ;
    } // if
    else havedouble = true ;
  } // else if
  
  else if ( startchar == '-' ) { // else if -- ->
    TrackToken( whatisit ) ;
    if ( whatisit == '-' || whatisit == '>' ) { // equlas -- ->
      temp[1] = whatisit ;
    } // if
    else havedouble = true ;
  } // else if
  
  token = new char[ ( strlen(temp) + 1 ) ] ;
  strcpy( token, temp );
   
  // 開始做串鍊
  
  if ( gFront == NULL ) {  // first ;
    InsertNullLink( token, SPECIAL, gLine, column, gColumn ) ;
  } // if first time
  
  else { // gFront already has 
    TokenPtr findtemp = NULL ;
    findtemp = HaveTokenOrNot( token ) ;
    if ( findtemp != NULL ) {
      UpdateToken( findtemp, token, SPECIAL, gLine, column, gColumn ) ;
    } // if
    else AddToLink( token, SPECIAL, gLine, column, gColumn ) ;
  } // else
  
  
  // -> -- >> >= << <= || && == ++ !=
  if ( havedouble == true )
    EveryCaseLast( whatisit ) ;
} // IfSpecial()


void EveryCaseLast( char inputchar ) {
  // 此函數用來處理每個CASE之後讀取到的字元
  if ( inputchar == ' ' || inputchar == '\t' || inputchar == '\n' ) ; // do nothing
  else if ( inputchar == '_' || 
               ( inputchar >= 65 && inputchar <= 90 ) || 
               ( inputchar >= 97 && inputchar <= 122 ) ) 
    IfIdentifier( inputchar ) ;
  else if ( ( inputchar >= 48 && inputchar <= 57  ) // 0-9
                   || inputchar == 39 || inputchar == '"' )
      IfNumberOrCharOrString( inputchar ) ;
  else  if (  inputchar == '+' || inputchar == '-' || inputchar == '*' || inputchar == '/' ||
                    inputchar == '>' || inputchar == '<' || inputchar == '=' || 
                    inputchar == '?' ||
                    inputchar == '%' || inputchar == '&' ||
                    inputchar == '|' || inputchar == '^' || // " 跟 ' 判斷地方在上面
                    inputchar == '.' || inputchar == ',' || inputchar == '(' || inputchar == ')' ||
                    inputchar == '[' || inputchar == ']' || inputchar == '{' || inputchar == '}' ||
                    inputchar == '!' || inputchar == ':' ||
                    inputchar == ';' || inputchar == '#' ) 
     IfSpecial( inputchar ) ;
} // EveryCaseLast()


TokenPtr HaveTokenOrNot(  CharPtr token ) {
  
  TokenPtr find  = gFront ;
  //find->tokenStr = new char[ ( strlen(token) + 1 ) ] ;
  while ( find != NULL ) {
    if ( strcmp( find->tokenStr, token ) == 0 ) {
       return find ;
       printf( "test\n" );
    } // if
    find = find->next ;
  } // while
  
  return NULL ;
} // HaveTokenOrNot()


void InsertNullLink( CharPtr token, TokenType type, int gLine, int column, int gColumn ) {
  gFront = new Token;
  gFront->tokenStr = new char[ ( strlen(token) + 1 ) ] ;
  strcpy( gFront->tokenStr, token ) ;
  gFront->type =  type ;
  gFront->next = NULL ;
    
    
    gFront->firstAppearOn = new Line ;
    gFront->firstAppearOn->line = gLine;
    gFront->firstAppearOn->next = NULL;
    gFront->firstAppearOn->firstAppearAt = new Column ;
    gFront->firstAppearOn->firstAppearAt->column = column ;
    gFront->firstAppearOn->firstAppearAt->next = NULL ;
    gFront->firstAppearOn->lastAppearAt = gFront->firstAppearOn->firstAppearAt ;
    
     gFront->lastAppearOn = gFront->firstAppearOn ;

    gRear = gFront ;
     
} // InsertNullLink()


void AddToLink( CharPtr token, TokenType type, int gLine, int column, int gColumn ) {\
  
  TokenPtr tokenptrtemp = gFront ;
  gFront = new Token ;
  gFront->tokenStr = new char[ ( strlen(token) + 1 ) ] ;
  
  strcpy( gFront->tokenStr, token ) ;
  gFront->type = type ;
  gFront->next = tokenptrtemp ;
  
  gFront->firstAppearOn = new Line ;
  gFront->firstAppearOn->line = gLine ;
  gFront->firstAppearOn->next = NULL;
  gFront->firstAppearOn->firstAppearAt = new Column ;
  gFront->firstAppearOn->firstAppearAt->column = column ;
  gFront->firstAppearOn->firstAppearAt->next = NULL ; // struct column
  gFront->firstAppearOn->lastAppearAt = gFront->firstAppearOn->firstAppearAt ;
  
  gFront->lastAppearOn = gFront->firstAppearOn ;
} // AddToLink()



void UpdateToken( TokenPtr & inserttoken, CharPtr token, TokenType type, int gLine, int column, int gColumn ) {
  // 此inserttoken指向我們要新增的TOEKN STRUCT的位置
  
  // 先尋找LINE結構裡面最下面的位置
  // 接著如果gLine == 最下面的line的話
  // 就開始往column那邊新增
  // 否則就新建一個LINE結構然後連起來
  // is that clear?
  
  LinePtr linewalk        = inserttoken->lastAppearOn ;
  ColumnPtr columntemp = inserttoken->lastAppearOn->lastAppearAt ;
  if ( linewalk->line == gLine ) { // 要新增的跟最後一次出現的在同一行
  // 接著新增在column結構裡 (因為在同一LINE)
    inserttoken->lastAppearOn->lastAppearAt->next =   new Column ;
    inserttoken->lastAppearOn->lastAppearAt->next->column = column ;
    inserttoken->lastAppearOn->lastAppearAt->next->next = NULL ;
    
    // 移動last位置
    inserttoken->lastAppearOn->lastAppearAt = inserttoken->lastAppearOn->lastAppearAt->next ;
  } // if
  
  else { // 直接新增一個LINE結構 (在新的一行)
    inserttoken->lastAppearOn->next = new Line ;
    inserttoken->lastAppearOn->next->line = gLine ;
    inserttoken->lastAppearOn->next->firstAppearAt = new Column ;
    inserttoken->lastAppearOn->next->firstAppearAt->column = column ;
    inserttoken->lastAppearOn->next->lastAppearAt = inserttoken->lastAppearOn->next->firstAppearAt ;
    inserttoken->lastAppearOn->next->next = NULL ;
    
    // 移動LAST位置
    inserttoken->lastAppearOn =  inserttoken->lastAppearOn->next ;
  } // else

} // UpdateToken()
 



void PrintToken() {
  TokenPtr printToken = gFront ;
  LinePtr linewalk  ;
  ColumnPtr columnwalk  ;
  int i = 0 ;
  
  while ( printToken != NULL ) {
    linewalk = printToken->firstAppearOn;
    printf( "%s ", printToken->tokenStr );
    
    while ( linewalk != NULL ) {
      
      columnwalk = linewalk->firstAppearAt ;
      while ( columnwalk != NULL ) {
        
        printf( "(%d,%d)", linewalk->line, columnwalk->column  );
        columnwalk = columnwalk->next ;
      } // while column
      
      linewalk = linewalk->next ;
    } // while line
    
    printf( "\n" );
    printToken = printToken->next ;
  } // while token
  
} // PrintToken()

void BubbleSort() {
    int swapped, i;
    TokenPtr ptr1;
    TokenPtr lptr = NULL;
 
    // if null than return 
    if (ptr1 == NULL)
        return;
    do {
        swapped = 0;
        ptr1 = gFront;
 
        while (ptr1->next != lptr) {
            if ( strcmp( ptr1->tokenStr, ptr1->next->tokenStr ) > 0 ) { 
                Swap(ptr1, ptr1->next);
                swapped = 1;
            } // if
            
            ptr1 = ptr1->next;
        } // while
        
        lptr = ptr1;
    }  while ( swapped ); // do while
} // BubbleSort()

void Swap(  TokenPtr a, TokenPtr b ) {
  // a = new char[ ( strlen(b) + 1 ) ] ;
  
  // a的資料COPY到TEMP
  CharPtr tokenStrtemp = new char[ ( strlen( a->tokenStr ) + 1 ) ] ;
  strcpy( tokenStrtemp, a->tokenStr );
  
  TokenType typetemp = a->type ;
  LinePtr firsttemp = a->firstAppearOn ;
  LinePtr lasttemp   = a->lastAppearOn ;
  
  // b的資料給a
  a->tokenStr = new char[ ( strlen( b->tokenStr ) + 1 ) ] ;
  strcpy( a->tokenStr, b->tokenStr );
  a->type = b->type ;
  a->firstAppearOn = b->firstAppearOn ;
  a->lastAppearOn  = b->lastAppearOn ;
  
  // temp的資料給B
  b->tokenStr = new char[ ( strlen( tokenStrtemp ) + 1 ) ] ;
  strcpy( b->tokenStr, tokenStrtemp );
  b->type = typetemp ;
  b->firstAppearOn = firsttemp ;
  b->lastAppearOn = lasttemp ;
}  // Swap()

//////////////////////////////////////////////////////////
// 以下為使用者區塊
//////////////////////////////////////////////////////////
void UserInterface() {
  char option = '\0';

      printf( "請輸入指令\n" ) ;
    printf( "1.總共有多少種 token\n" );
    printf( "2.三種case各有多少 token\n" );
    printf( "3.印出指定 token 的位置 (line number,column number) (要排序)\n" );
    printf( "4.印出所指定的那一 line 出現哪幾個 token (要排序)\n" );
    printf( "5.結束\n" );
  
  do{
    scanf( " %c", &option );
    
    if ( option == '1'  )
      printf( "總共%d種\n", HowManyToken( ) );
    else if ( option == '2' )
      HowManyEach() ;
    else if ( option == '3' ) 
      SearchToken() ;
    else if ( option == '4' ) 
      PrintTokenOnLine() ;
    else if ( option == '5' )  printf( "byebye" );
  } while ( option != '5' ) ;
} // UserInterface()

int HowManyToken( ) {
  TokenPtr temp = gFront ;
  int count = 0 ;
  while ( temp != NULL ) {
    count++ ;
    temp = temp->next ;
  } // while
  
  return count ;
} // HowManyToken()

void HowManyEach() {
  int case1 = 0, case2 = 0, case3 = 0 ;
  TokenPtr temp = gFront ;
  while ( temp != NULL ) {
    if ( temp->type == IDENTIFIER )     case1++;
    else if ( temp->type == CONSTANT ) case2++ ;
    else if ( temp->type == SPECIAL )   case3++;
    temp = temp->next ;
  } // while
  
  printf( "Case1 共    %d個\n", case1 );
  printf( "Case2 共    %d個\n", case2 );
  printf( "Case3 共    %d個\n", case3 );
} // HowManyEach

void SearchToken() {
  printf( "請輸入要搜尋的 Token : \n" ) ;
  CharPtr input ;
  TokenPtr result ;
  Str100 temp = "";
  scanf( "%s", temp );
  input = new char [ ( strlen( temp ) + 1 ) ] ;
  strcpy( input, temp ) ;
  
  result = HaveTokenOrNot(  input ) ;
  if ( result == NULL ) printf( "查無此Token: %s\n", input );
  else { // have Token
    LinePtr linewalk = result->firstAppearOn ;
    ColumnPtr columnwalk = NULL ;
    
    printf( "%s ", result->tokenStr );
    while ( linewalk != NULL ) {
      columnwalk = linewalk->firstAppearAt ;
      while ( columnwalk != NULL ) {
        printf( "(%d,%d)", linewalk->line, columnwalk->column );
        columnwalk = columnwalk->next ;
      } // while // column
      
      linewalk = linewalk->next ;
    } // while // line
    
    printf( "\n" );
  } // else have token
} // SearchToken()


void PrintTokenOnLine() {
  TokenPtr temp = gFront ;
  int input = 0 ;
  printf( "請輸入要指定的 line :\n" );
  scanf( "%d", &input ) ;
  while ( temp != NULL ) {
    LinePtr linewalk = temp->firstAppearOn ;
    
    while ( linewalk != NULL ) {
      if ( linewalk->line == input ) printf( "%s\n", temp->tokenStr ) ;
      linewalk = linewalk->next ;
    } // while
    
    temp = temp->next ;
  } // while
} // PrintTokenOnLine()