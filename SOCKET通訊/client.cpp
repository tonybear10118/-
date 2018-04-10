#include <stdio.h>
#include <stdlib.h>
#include <WinSock2.h>
#pragma comment(lib, "ws2_32.lib") 
int main(){
    
    WSADATA wsaData;
    WSAStartup(MAKEWORD(2, 2), &wsaData);
    
    SOCKET sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    
    sockaddr_in sockAddr;
    memset(&sockAddr, 0, sizeof(sockAddr));  
    sockAddr.sin_family = PF_INET;
    sockAddr.sin_addr.s_addr = inet_addr("220.134.65.207");
    sockAddr.sin_port = htons(1234);
    connect(sock, (SOCKADDR*)&sockAddr, sizeof(SOCKADDR));
    
    char szBuffer[MAXBYTE] = {0};
    recv(sock, szBuffer, MAXBYTE, 0);
    
    printf("Message form server: %s\n", szBuffer);
  
    closesocket(sock);
    
    WSACleanup();

    system("pause");
    
    return 0;
}