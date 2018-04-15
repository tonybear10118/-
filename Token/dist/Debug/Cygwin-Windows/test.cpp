/* 
 * File:   main.cpp
 * Author: TeemoBear
 *
 * Created on 2018�~4��11��, �W�� 3:14
 */

# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <cstdlib>
using namespace std;

enum TokenType { IDENTIFIER = 34512, CONSTANT = 87232, SPECIAL = 29742 } ;

typedef char * CharPtr ;

struct Column {
  int column ;                  // ��token(���r��)�b��line���X�{��column
  Column * next;                // �U�@�Ӧ�token(�b��line)���X�{��column
} ; // Column

typedef Column * ColumnPtr ;

struct Line {                   // struct Line �O���F4�ظ�T
  int line ;                    // ��token��b���@ line
  ColumnPtr firstAppearAt ;     // ���즹token�Ĥ@���X�{�b��line�����@column
  ColumnPtr lastAppearAt ;      // ���즹token�̫�X�{�b��line�����@column
  Line *  next;                 // �P�@ token �U�@���X�{�b���@ line
} ;

typedef Line * LinePtr ;

struct Token {                  // Struct token �����F4�ظ�T
  CharPtr tokenStr ;            // tokenStr ��A���U�Ӫ�token
  TokenType type;               // type ������token�O�ݩ���@��case
  LinePtr firstAppearOn ;       // �� token �Ĥ@���X�{�b���@ line
  LinePtr lastAppearOn ;        // �� token �̫�X�{�b���@ line
  Token * next ;                // ���V�U�@��token
} ; // struct Token

typedef Token * TokenPtr ;


TokenPtr gFront = NULL, gRear = NULL ;  // ���O���VToken��C���Y���

typedef char Str100[ 100 ] ; // �����O�O����Ψӫŧi�@�Ӱ}�C�ܼơB�H��Ū�r�ꤧ��

int gLine = 1 ;              // �u�U�@�ӭnŪ�i�Ӫ��r���v�Ҧb��line number
int gColumn = 1 ;            // �u�U�@�ӭnŪ�i�Ӫ��r���v�Ҧb��column number
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
 // �}�l�ϥΪ̿�J
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
                    inputchar == '|' || inputchar == '^' || // " �� ' �P�_�a��b�W��
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
  temp[i] = '\0' ; // �M�����ŦX�oCASE���r��
  strcpy( token, temp ); // now we got the token!
  // �}�l�[�J����TOKEN
  
  
  
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
  
  EveryCaseLast( fornext ) ; // �@�w�OŪ�줣�ŦX�귽���X���A���O�o�Ӧr���O�ƻ�O�H

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
    temp[i] = '\0' ; // �M�����ŦX�oCASE���r�����K����
    // There's a bug .
    
    // �H�U�o�Ӥ��O��̫�A�B�z���M�X�j��
    EveryCaseLast( fornext ) ; // �@�w�OŪ�줣�ŦX�귽���X���A���O�o�Ӧr���O�ƻ�O�H
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
  //token[0] = startchar ; // �����٨S�� '\0'����
  //token[1] = '\0';
  strcpy( token, temp ); // now we got the token!
  
   // �H�U�}�l�걵TOKEN
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
  
  // ���Өҥ~���p�A���p����/ �i�ӬO���Ѫ���....
  if ( startchar == '/' ) { // detect is // , /* or not
    TrackToken( whatisit ) ;
    if ( whatisit == '/'  ) { // �O�@�����
      while ( whatisit != '\n' ) // Ū�촫�欰��
        TrackToken( whatisit ) ;
      
      return ; // ���X�o�Ө��
    } // if �O�@�����
    
    else if ( whatisit == '*' ) { // �]�O����
    // �����O�s�� * �� / �����X��~�i�H�_�y  
      while ( true ) {
        TrackToken( whatisit ) ;
        if ( whatisit == '*' ) {
          TrackToken( whatisit ) ;
          if ( whatisit == '/' ) return ; // �����ѤF�A���X
          else havedouble = true ;
        } // if first condition
      } // while
    } // else if �]�O����
    
    else { // opps, �o���O���ѡA�~�|�F
      havedouble = true ;
    } // else
  } // if
  
  
  
  // ���O���Ѫ��ܶ}�l�i��TOKEN�@�~
  // ���i��O���r���c�����B��l�A�]���n�b�o���ˬd
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
   
  // �}�l������
  
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
  // ����ƥΨӳB�z�C��CASE����Ū���쪺�r��
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
                    inputchar == '|' || inputchar == '^' || // " �� ' �P�_�a��b�W��
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
  // ��inserttoken���V�ڭ̭n�s�W��TOEKN STRUCT����m
  
  // ���M��LINE���c�̭��̤U������m
  // ���ۦp�GgLine == �̤U����line����
  // �N�}�l��column����s�W
  // �_�h�N�s�ؤ@��LINE���c�M��s�_��
  // is that clear?
  
  LinePtr linewalk        = inserttoken->lastAppearOn ;
  ColumnPtr columntemp = inserttoken->lastAppearOn->lastAppearAt ;
  if ( linewalk->line == gLine ) { // �n�s�W����̫�@���X�{���b�P�@��
  // ���۷s�W�bcolumn���c�� (�]���b�P�@LINE)
    inserttoken->lastAppearOn->lastAppearAt->next =   new Column ;
    inserttoken->lastAppearOn->lastAppearAt->next->column = column ;
    inserttoken->lastAppearOn->lastAppearAt->next->next = NULL ;
    
    // ����last��m
    inserttoken->lastAppearOn->lastAppearAt = inserttoken->lastAppearOn->lastAppearAt->next ;
  } // if
  
  else { // �����s�W�@��LINE���c (�b�s���@��)
    inserttoken->lastAppearOn->next = new Line ;
    inserttoken->lastAppearOn->next->line = gLine ;
    inserttoken->lastAppearOn->next->firstAppearAt = new Column ;
    inserttoken->lastAppearOn->next->firstAppearAt->column = column ;
    inserttoken->lastAppearOn->next->lastAppearAt = inserttoken->lastAppearOn->next->firstAppearAt ;
    inserttoken->lastAppearOn->next->next = NULL ;
    
    // ����LAST��m
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
  
  // a�����COPY��TEMP
  CharPtr tokenStrtemp = new char[ ( strlen( a->tokenStr ) + 1 ) ] ;
  strcpy( tokenStrtemp, a->tokenStr );
  
  TokenType typetemp = a->type ;
  LinePtr firsttemp = a->firstAppearOn ;
  LinePtr lasttemp   = a->lastAppearOn ;
  
  // b����Ƶ�a
  a->tokenStr = new char[ ( strlen( b->tokenStr ) + 1 ) ] ;
  strcpy( a->tokenStr, b->tokenStr );
  a->type = b->type ;
  a->firstAppearOn = b->firstAppearOn ;
  a->lastAppearOn  = b->lastAppearOn ;
  
  // temp����Ƶ�B
  b->tokenStr = new char[ ( strlen( tokenStrtemp ) + 1 ) ] ;
  strcpy( b->tokenStr, tokenStrtemp );
  b->type = typetemp ;
  b->firstAppearOn = firsttemp ;
  b->lastAppearOn = lasttemp ;
}  // Swap()

//////////////////////////////////////////////////////////
// �H�U���ϥΪ̰϶�
//////////////////////////////////////////////////////////
void UserInterface() {
  char option = '\0';

      printf( "�п�J���O\n" ) ;
    printf( "1.�`�@���h�ֺ� token\n" );
    printf( "2.�T��case�U���h�� token\n" );
    printf( "3.�L�X���w token ����m (line number,column number) (�n�Ƨ�)\n" );
    printf( "4.�L�X�ҫ��w�����@ line �X�{���X�� token (�n�Ƨ�)\n" );
    printf( "5.����\n" );
  
  do{
    scanf( " %c", &option );
    
    if ( option == '1'  )
      printf( "�`�@%d��\n", HowManyToken( ) );
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
  
  printf( "Case1 �@    %d��\n", case1 );
  printf( "Case2 �@    %d��\n", case2 );
  printf( "Case3 �@    %d��\n", case3 );
} // HowManyEach

void SearchToken() {
  printf( "�п�J�n�j�M�� Token : \n" ) ;
  CharPtr input ;
  TokenPtr result ;
  Str100 temp = "";
  scanf( "%s", temp );
  input = new char [ ( strlen( temp ) + 1 ) ] ;
  strcpy( input, temp ) ;
  
  result = HaveTokenOrNot(  input ) ;
  if ( result == NULL ) printf( "�d�L��Token: %s\n", input );
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
  printf( "�п�J�n���w�� line :\n" );
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