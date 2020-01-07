###              WARNNING                       ###
### If You want to run this ".py" file          ###
### You need to :                               ###
### Install 1. pip install requests             ###
###         2. pip install beautifulsoup4       ###
### And REMEMBER to set your python system path ###
### variable currectly.                         ###

import urllib.request
import requests
from bs4 import BeautifulSoup
import json
import os
import tkinter
import tkinter.messagebox
from tkinter.filedialog import askdirectory
import threading
import time


class StaticNum:
    sexnum = 0
    readnum = 30
    statusdot = 1
    gPath = ""
    stopcrawl = False


class Download:
    def DownloadProcess( self, inputWindow ):
        StaticNum.statusdot = 1
        inputWindow.InsertMsgBox("開始爬各篇文章的圖片 (請稍後).")
        while StaticNum.statusdot != 4:
            inputWindow.DeleteMsgBox()
            #pass
            
            if StaticNum.statusdot == 1:
                inputWindow.InsertMsgBox("開始爬各篇文章的圖片 (請稍後).")
            elif StaticNum.statusdot == 2:
                inputWindow.InsertMsgBox("開始爬各篇文章的圖片 (請稍後)...")
            elif StaticNum.statusdot == 3:
                StaticNum.statusdot = 0
                inputWindow.InsertMsgBox("開始爬各篇文章的圖片 (請稍後).....")
            else:
                inputWindow.InsertMsgBox("------------------------------")
                break
            
            time.sleep(1)
            
            StaticNum.statusdot = StaticNum.statusdot + 1
    def RunProcess(self, inputWindow):
        mythread = threading.Thread(target = self.DownloadProcess, args=( inputWindow, ) )
        mythread.start()

    
class MyWin:
    def UnableAllButton(self):
        self.myButton1.config(state="disabled")
        self.myButton2.config(state="disabled")
        self.myButton3.config(state="disabled")
        self.sexLeftButton.config(state="disabled")
        self.readLeftButton.config(state="disabled")
        self.readRightButton.config(state="disabled")
        self.pathButton.config(state="disabled")
        self.stopButton.config(state="normal") # 停止按鈕相反

    def EnableAllButton(self):
        self.myButton1.config(state="normal")
        self.myButton2.config(state="normal")
        self.myButton3.config(state="normal")
        self.sexLeftButton.config(state="normal")
        self.readLeftButton.config(state="normal")
        self.readRightButton.config(state="normal")
        self.pathButton.config(state="normal")
        self.stopButton.config(state="disabled") # 停止按鈕相反

    def CrawlChild(self, want_to_crawl, sexual, pagenum, displayedText, displayLabel, Window):
        mythread = threading.Thread(target = Crawl, args = (want_to_crawl, sexual, pagenum, displayedText, displayLabel, Window)  )
        mythread.start()
    
    # 按此開始爬蟲
    def ClickAction(self, want_to_crawl):
        self.UnableAllButton()
        if self.sexChoiseLabel.cget("text") == "男性貼文":
            sexual = "male"
        elif self.sexChoiseLabel.cget("text") == "女性貼文":
            sexual = "female"
        else:
            sexual = "all"
            
        # 使用子線程來避免主UI當機的問題
        self.CrawlChild( want_to_crawl, sexual, int(StaticNum.readnum/30), self.displayedText, self.displayLabel, self )

    def ClickLeftChangeSex(self):
        StaticNum.sexnum = StaticNum.sexnum + 1
        if StaticNum.sexnum > 2 :
            StaticNum.sexnum = 0 # reset
            
        if StaticNum.sexnum == 0 :
            self.sexChoiseLabelText.set("全部性別貼文")
        elif StaticNum.sexnum == 1 :
            self.sexChoiseLabelText.set("男性貼文")
        elif StaticNum.sexnum == 2 :
            self.sexChoiseLabelText.set("女性貼文")



    def ClickPlusReadNum(self):
        StaticNum.readnum = StaticNum.readnum + 30
        self.readChoiseLabelText.set("閱讀文章數量："+str(StaticNum.readnum)+"篇")

    def ClickMinusReadNum(self):
        if  StaticNum.readnum - 30 == 0 :
            tkinter.messagebox.showinfo("錯誤", "文章數量不得少於30！")
        else:    
            StaticNum.readnum = StaticNum.readnum - 30
        self.readChoiseLabelText.set("閱讀文章數量："+str(StaticNum.readnum)+"篇")

    def InsertMsgBox( self, inputstr ):
        self.statusScrollbar.insert( tkinter.END, inputstr )

    def DeleteMsgBox(self):
        self.statusScrollbar.delete( tkinter.END )





    def StopAll(self):
        self.myWindow.destroy
        os._exit(0)

    def SelectPath(self):
        path_ = askdirectory()
        if len( path_ ) > 0:
            self.path.set(path_)
        else:
            self.path.set(os.getcwd())

        StaticNum.gPath = self.path
        self.InsertMsgBox( "選擇路徑:"+self.path.get() )
        
    def StopCrawl(self):
        StaticNum.stopcrawl = True
        self.EnableAllButton()


    def OpenReadME(self):
        explain = open( self.path.get()+'\\README.txt', "w",encoding="utf-8" )
        explain.write(
            '''############################################
### 2018.12.27 Author: Tony              ###
###                                      ###
###           Dcard 爬圖大師             ###
###              程式說明                ###
############################################

此程式被設計用來爬起Dcard上面文章裡的圖片

介面說明:
	-> 說明按鈕 : 開啟說明程式文字檔
	-> 西斯板 :   開始爬取Dcard西斯板文章
	-> 攝影板 :   開始爬取Dcard攝影板文章
	-> 寵物板 :   開始爬取Dcard寵物板文章

  在爬文章前可做個人化設定 :
	-> 切換性別 : 只選取特定性別所發的文章(也可全部都爬)
	-> 增加文章數量 : 如果覺得爬取的數量不夠多可以增加爬取的文章數量
	-> 減少文章數量 : 如果覺得爬取的數量太多可以減少爬取的文章數量

  狀態顯示:
	-> 共下載了 x 張 (單次已下載圖片張數)
	-> 狀態歷程 : log供使用者查看
	-> 停止爬蟲 : 若途中想停止爬蟲動作即可按此按鈕停止

  路徑及退出:
	-> 瀏覽下載路徑 : 可供使用者選擇下載的檔案位置
	-> xx:\\xx\\xx : 目前會把檔案下載下來的位置
	-> 退出 : 按下即可退出程式''')

        
        os.startfile(StaticNum.gPath.get()+"\\README.txt")

        
    def __init__(self):
        
        self.myWindow = tkinter.Tk(className = "Dcard 爬圖大神")
        self.myWindow.geometry('300x800')
        self.myFrame = tkinter.Frame(self.myWindow)
        self.myFrame.pack()
        self.path = tkinter.StringVar()
        self.path.set(os.getcwd()) # 預設路徑
        StaticNum.gPath = self.path
        

        # WelCome Label
        welcome_text = "歡迎來到DCARD爬圖大神!\n"
        welcome_text += "按下即刻爬您想爬的看板!\n"
        self.myLabel = tkinter.Label(self.myFrame, text = welcome_text )
        self.myLabel.pack(side='top')

        # 說明按鈕
        self.readButton1 = tkinter.Button(self.myFrame, text="說明", command = self.OpenReadME, width=5 )
        self.readButton1.pack(side='left')



        self.boardFrame = tkinter.Frame(self.myWindow, pady=10)
        self.boardFrame.pack()
        # Buttons ( For board )
        self.myButton1 = tkinter.Button(self.boardFrame, text="西斯板", command = lambda: self.ClickAction("sex"), width=35, font='bold' )
        self.myButton1.pack()

        # Buttons ( For board )
        self.myButton2 = tkinter.Button(self.boardFrame, text="攝影板", command = lambda: self.ClickAction("photography"), width=35, font='bold' )
        self.myButton2.pack()


        # Buttons ( For board )
        self.myButton3 = tkinter.Button(self.boardFrame, text="寵物板", command = lambda: self.ClickAction("pet"), width=35, font='bold' )
        self.myButton3.pack()

        
        
        

        
        # 性別選擇Frame
        self.sexFrame = tkinter.Frame(self.myWindow, pady = 10)
        self.sexFrame.pack()
        # 性別選擇標籤
        self.sexChoiseLabelText = tkinter.StringVar()
        self.sexChoiseLabelText.set( "全部性別貼文" )
        self.sexChoiseLabel = tkinter.Label(self.sexFrame, textvariable = self.sexChoiseLabelText )
        self.sexChoiseLabel.pack()
        # Button ( For sex choise )
        self.sexLeftButton = tkinter.Button(self.sexFrame, text="切換性別", command = lambda: self.ClickLeftChangeSex() )
        self.sexLeftButton.pack()






        # 文章數量 Frame
        self.readFrame = tkinter.Frame(self.myWindow, pady = 10)
        self.readFrame.pack()
        # 文章數量標籤
        self.readChoiseLabelText = tkinter.StringVar()
        self.readChoiseLabelText.set( "閱讀文章數量：30篇" )
        self.readChoiseLabel = tkinter.Label(self.readFrame, textvariable = self.readChoiseLabelText )
        self.readChoiseLabel.pack()

        # Button ( For num of read choise )
        self.readLeftButton = tkinter.Button(self.readFrame, text="增加文章數量", command = lambda: self.ClickPlusReadNum() )
        self.readLeftButton.pack()
        # Button ( For num of read choise )
        self.readRightButton = tkinter.Button(self.readFrame, text="減少文章數量", command = lambda: self.ClickMinusReadNum() )
        self.readRightButton.pack()   
        



        # 進度條 Frame
        self.displayFrame = tkinter.Frame(self.myWindow, pady = 10)
        self.displayFrame.pack()
        # 進度條
        self.displayedText = tkinter.StringVar()
        self.displayedText.set("共下載了 0 張")
        self.displayLabel = tkinter.Label(self.displayFrame, textvariable=self.displayedText)
        self.displayLabel.pack()

        # 狀態顯示
        self.statusScrollbar = tkinter.Listbox( self.displayFrame, width=30 )
        self.msgBox = tkinter.Scrollbar( self.displayFrame )
        self.msgBox.pack( side='right', fill = tkinter.Y )
        self.statusScrollbar['yscrollcommand'] = self.msgBox.set
        self.statusScrollbar.insert( tkinter.END,"狀態歷程：" )
        self.statusScrollbar.pack()
        


        # 停止Frame
        self.stopFrame = tkinter.Frame(self.myWindow, pady = 10)
        self.stopFrame.pack()
        # 停止按鈕
        self.stopButton = tkinter.Button(self.stopFrame, text="停止爬蟲", command = self.StopCrawl, width=10, state="disabled") 
        self.stopButton.pack()




        # 退出Frame
        self.quitFrame = tkinter.Frame(self.myWindow, pady = 10)
        self.quitFrame.pack()


        # 瀏覽按鈕
        self.pathButton = tkinter.Button(self.quitFrame, text="瀏覽下載路徑", command = self.SelectPath, width=10) 
        self.pathButton.pack()
        self.pathLabel = tkinter.Label(self.quitFrame, textvariable=self.path )
        self.pathLabel.pack()


        # Quit
        self.quitButton = tkinter.Button(self.quitFrame, text="退出", command = self.StopAll, width=35 ) # 有點暴力，時間不夠先用這招
        self.quitButton.pack()


        
        # Status update
        self.displayLabel.update_idletasks()
        self.myWindow.protocol("WM_DELETE_WINDOW", self.StopAll) # 有點暴力，時間不夠先用這招

        
        tkinter.mainloop() # event handler

def MakeFolder(path, myWindow):
    folder = os.path.exists(path)
    if not folder:
        os.makedirs(path)
        print("Making pic folder...")
        myWindow.InsertMsgBox( "Making pic folder..." )
    else:
        myWindow.InsertMsgBox( "Already has the folder..." )
        print("Already has the folder...")

    os.system("start "+path)

def Crawl(want_to_crawl, want_sex_par, page, displayedText, displayLabel, myWindow):
  try:
    # 製作專屬資料夾
    downloadpath = StaticNum.gPath.get()+"/"+want_to_crawl
    downloadpath.replace("/", "\\")
    print( downloadpath )
    
    MakeFolder( downloadpath, myWindow )

    StaticNum.stopcrawl = False # 讓使用者停止用

    
    
    # 以下headers用來反 "反爬蟲"，DCARD於12月初開始加入了反爬蟲網路機制
    # 因此，利用假造的header製作出 "看似由瀏覽器所發出的HTTP請求"
    # 來繞過反爬蟲機制(伺服器判斷是人為操作而非機器)
    # 接著把request的間隔條成10秒一次(降低嫌疑XD)
    print("開始爬"+want_to_crawl+"板文章圖片..." )
    myWindow.InsertMsgBox( "開始爬"+want_to_crawl+"板文章圖片..." )
    p = requests.Session()
    headers = { "Accept":"text/html,application/xhtml+xml,application/xml;",
                "Accept-Encoding":"gzip",
                "Accept-Language":"zh-CN,zh;q=0.8",
                "Referer":"http://www.example.com/",
                "User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36"}
    url=requests.get("https://www.dcard.tw/f/"+want_to_crawl, headers=headers, timeout=10)


    # 利用BeautifulSoup套件來漂亮擷取我們的request結果
    soup = BeautifulSoup(url.text,"html.parser")

    # 在結果中尋找標籤'a'，並且class為 'PostEntry_root_V6g0rd' 的行
    # p.s 'PostEntry_root_V6g0rd' 為看板中每篇文章的格子
    sel = soup.find_all('a', 'PostEntry_root_V6g0rd')
    postlist_url=[]

    # 每個a標籤並且為'PostEntry_root_V6g0rd' 爬下來的結果為 "/f/pet/p/230339916-"+文章標題
    # 經由F12發現DCARD網站網址的規則為 : "https://www.dcard.tw" + 我們上面第一次爬蟲所爬的結果
    # 把每篇文章完整的網址存入list 'a'
    for aTag in sel:
        #print( str(aTag['href']) )
        url = "https://www.dcard.tw"+ str(aTag['href'])
        postlist_url.append(url)


    
    


    
    # 再利用開發者模式的Nework欄位發現到往下滑動會發送下方組成的GET請求，模擬該請求來達到更多文章的目的
    page = page - 1 
    for k in range(0,page):
        # 下方為該GET請求會傳送的參數
        if want_to_crawl == 'sex':
            temp = 30
            temp2 = 38
        elif want_to_crawl == 'pet':
            temp = 30
            temp2 = 38
        elif want_to_crawl == 'photography':
            temp = 38
            temp2 = 46
        else:
            temp = 30
            temp2 = 38
        
        post_data={
            "before":postlist_url[-1][temp:temp2], # 最後一篇舊有文章的編號
            "limit":"30",
            "popular":"true"
        } # post_data
        
        r = p.get( "https://www.dcard.tw/_api/forums/"+want_to_crawl+"/posts",params=post_data, headers = { "Referer": "https://www.dcard.tw/", "User-Agent": "Mozilla/5.0" }, timeout=10 )
        
        # 處理json
        data2 = json.loads(r.text)
        for json_index in range(len(data2)):
            Temporary_url = "/f/"+want_to_crawl+"/p/"+ str(data2[json_index]["id"]) + "-" + str(data2[json_index]["title"].replace(" ","-"))
            postlist_url.append("https://www.dcard.tw"+Temporary_url)


        

    # 再從每篇文章裡把所有圖片( 標籤為img且class為'GalleryImage_image_3lGzO5' )爬出來
    print("開始爬各篇文章的圖片 (請稍後).")
    count = 1 # for picture num
    readcount = 1 # for read

    # 模擬下載狀態
    download = Download()
    download.RunProcess( myWindow )



    myfile = open(downloadpath+"\\url_information.txt","w",encoding="utf-8")
    myfile.close()
    for urlindex in postlist_url:
        if StaticNum.stopcrawl == True:
            print("爬蟲提早結束\n------------------------------")
            myWindow.InsertMsgBox("爬蟲提早結束結束")
            inputWindow.InsertMsgBox("------------------------------")
            return # 使用者中斷

        
        # 分段讀寫避免被使用者中斷
        myfile = open(downloadpath+"\\url_information.txt","a",encoding="utf-8")
        myfile.write( "第"+ str(readcount) +"篇文章 URL-> " )  
        myfile.write( urlindex+"\n" )
        myfile.close()
        
        url=requests.get(urlindex, headers=headers, timeout=10)
        soup = BeautifulSoup(url.text,"html.parser")
        sel_jpg = soup.find_all('img', 'GalleryImage_image_3lGzO5')

        # 根據性別作選擇
        # male:   AnonymousAvatar_male_3mpl_6
        # female: AnonymousAvatar_female_swqLgz
        if want_sex_par == "male":
          want_sex = 'AnonymousAvatar_male_3mpl_6'
        elif want_sex_par == "female":
          want_sex = 'AnonymousAvatar_female_swqLgz'
        else:
          want_sex = "all"
            
        sexual = soup.find('div', 'PostPage_header_3iu5wC' ).findAll('div', want_sex)
            
            
        # 每篇文章
        if len( sexual ) != 0 or want_sex == "all" :
            
            for sel_index in sel_jpg:
                if StaticNum.stopcrawl == True:
                    print("爬蟲提早結束\n------------------------------")
                    myWindow.InsertMsgBox("爬蟲提早結束")
                    inputWindow.InsertMsgBox("------------------------------")
                    return # 使用者中斷
                pic=requests.get( sel_index["src"], headers=headers, timeout=10 )
                toimg = pic.content
                pic_out = open( downloadpath+"/"+str(count)+".png",'wb' )
                pic_out.write( toimg )
                displayedText.set("共下載了 " + str(count) + " 張")
                displayLabel.update_idletasks()

                myfile = open(downloadpath+"\\url_information.txt","a",encoding="utf-8")
                myfile.write( "圖片編號："+str(count)+".png\n" )
                myfile.close()
                count = count + 1 
                pic_out.close()
        readcount = readcount + 1 

    os.system("start "+downloadpath+"\\url_information.txt")
    StaticNum.statusdot = 4
    myWindow.EnableAllButton()
    print("爬蟲結束\n------------------------------")
    myWindow.InsertMsgBox("爬蟲結束")
    myWindow.InsertMsgBox("------------------------------")
    tkinter.messagebox.showinfo("完成", "工作完成！")
  except:
    print( "爬蟲出現錯誤，提早結束\n------------------------------" );
    StaticNum.statusdot = 4
    os.system("start "+downloadpath+"\\url_information.txt")
    myWindow.EnableAllButton()
    myWindow.InsertMsgBox("爬蟲出現錯誤，提早結束")
    myWindow.InsertMsgBox("------------------------------")
    tkinter.messagebox.showinfo("完成", "工作完成！")

def main():
        crawlWindow = MyWin()

main()
