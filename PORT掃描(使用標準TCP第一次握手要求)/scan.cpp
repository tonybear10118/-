# include <stdio.h>
# include <sys/socket.h>
# include <arpa/inet.h>
# include <errno.h>
# include <netdb.h>
# include <string.h>
# include <stdlib.h>
# include <netinet/in.h>
# include <unistd.h>

bool Isdigit( char ch ) ;

int main( int argc, char **argv ) {
  struct hostent *host ;
  int err, i = 0, sock, start, end ;
  char hostname[100];
  struct sockaddr_in sa;
  
  // Get the hostname to scan
 printf( "Enter hostname or IP : \n" );
 scanf( "%s", &hostname );
  
  // Get start port number 
 printf( "Enter start port number : \n" );
 scanf( "%d", &start );

  // Get the end port number
 printf( "Enter end port number : \n" );
 scanf( "%d", &end );

  // Initial the sockaddr
 strncpy( ( char * ) &sa, "", sizeof sa );
 sa.sin_family = AF_INET ;

  // direct ip address and use it
  if ( Isdigit( hostname[0] ) == true ) {
   printf( "Doing inet_addr...\n" );
   sa.sin_addr.s_addr = inet_addr( hostname );
   printf( "Done\n" ); 
 } // if 

  else if ( gethostbyname( hostname ) != 0 ) {
    printf( "Doing getbyhostname...\n" );
 } // else if

  else {
   herror( hostname );
   exit(2);
 } // else



  printf( "Starting the portscan loop...\n" );
  i = start;
    while ( i <= end ) {
        // Fill the port num
    sa.sin_port = htons( i );
    sock = socket( AF_INET, SOCK_STREAM, 0 );
  
       // Check whether socket created fine or not
       if ( sock < 0 ) {
     perror( "Socket\n" );
     exit( 1 ) ;
   } // if     

      // Connet using that socket and sockaddr structure 
   err = connect( sock, ( struct sockaddr* ) &sa, sizeof( sa ) ) ;
  
      // if not connected
      if ( err < 0 ) {
         fflush( stdout );
   } // if

        else 
       printf( "%-5d open\n", i ) ;
    close( sock );
    i++;
  } // while

     printf( "\r" );
     fflush( stdout );
           return 0 ;
} // main()

bool Isdigit( char ch ) {
   return ( ch >= '0' ) && ( ch <= '9' ) ; 
} // Isdigit()
