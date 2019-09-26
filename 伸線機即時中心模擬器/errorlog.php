<html>
  <head>
	<?php
	  function FormatArray( &$dataarray ) {
	    $i = 0 ;
	    while ( $i < 6 ) {
		  $dataarray[$i] = "";
	      $i++;
	    } // while
	  } // FormatArray()
	  
	  function UpdateTenSpeed( $speed, &$speedarray ) {
	    $i = 0 ;
	    while ( $i < 9 ) { // 10個裡面往左邊移動 0~8 
	      $speedarray[$i] = $speedarray[$i+1] ;
		  $i++;
	    } // while
	  
	  
	    $speedarray[9] = $speed ; // 最新的一筆速度資料
	  } // UpdateTenSpeed()
	  
	function SpeedStatus( $lastspeed ) {
	  // 如果線速10S內變動不超過400 m / hr 又持續升速，且低於1200(+-100)的話就是穩定升速
      // 如果線速10S內變動不超過400 m / hr 又持續降速，且低於1200(+-100)的話就是降速 
	  // 會進入到這個函數的時候產出軸與投入軸都是有軸的！
	  
	  if ( $lastspeed[0] < $lastspeed[9] && $lastspeed[9] < 1300 ) {
		if ( $lastspeed[9] - $lastspeed[0] > 400 )
	      return "異常升速！";
	    else
	      return "穩定增速中。。。";
	  } // if
	  
	  else if ( $lastspeed[0] > $lastspeed[9] && $lastspeed[9] < 1300 ) {
		if ( $lastspeed[9] - $lastspeed[0] > 400 )
	      return "異常降速！";
	    else
	      return "穩定降速中。。。";
	  } // else if
		
	  else if ( $lastspeed[9] != 0 && $lastspeed[0] == $lastspeed[9] ) {
	    if ( $lastspeed[0] > 1100 && $lastspeed[0] < 1300 ) // 十秒內線速一樣且S在正常值
	      return "穩定生產狀態。。。";
		else if ( $lastspeed[0] < 1100 )
          return "線速過低！！";
        else if ( $lastspeed[0] > 1300 ) 
          return "線速過高！";			
	  } // else if			 	
	} // SpeedStatus()
	
	function RecordInfo( $date, $time, $event, $errorkey, $errorvalue ) {
	  $info = "======================================== <br><br> 
		       機台發生錯誤！ <br><br>
		       日期：$date    <br><br>
			   時間：$time    <br><br>
			   發生事件：$event<br><br>
			   $errorkey ： $errorvalue <br><br>
			   ======================================== <br><br>
		       ";	// 顯示給人員用，資料會存進資料庫
			   
	  return $info ;
	} // RecordInfo()
	?>
  </head>
  
  <body>
    <div>
	  智慧機台歷史錯誤紀錄：<br><br>
	  <p id = "errorlog" ></p>
	</div>
	
	
	
    <?php
	
	  // while ( i < 3601 ) {  整個應該是一個while迴圈目前只能先模擬那一秒各組算出的資料
	  
      set_time_limit(0); // 不受時間限制
      $link = mysqli_connect ( 'localhost' , 'root' , '1234' ) ;
	  mysqli_select_db($link, 'sa'); 
	  // 送出Big5編碼的MySQL指令
	  mysqli_query($link, "SET CHARACTER SET utf8"); 
      mysqli_query($link, 'SET collation_connection = "utf8_general_ci"');
	  $showerror = array(); // 用來顯示給人員看得陣列
	  $showindex = 0 ;
	  $lastspeed = array(); // 上十秒的線速
	  $lastspeedindex = 0 ; // 上十秒線速INDEX
	  
	  
	  // 以下的錯誤紀錄是由劉大講義所規範規格去寫
      	  
	  
	  //溫度示範
      $doc = new DomDocument(); // 建立HTMLDOM模組
      $doc->loadHTMLFile('http://127.0.0.1/sa/errordata.php'); // 模擬別組計算的溫度資料
	  
      $thetime = $doc->getElementById( 'time' ); // 模擬別組算出來的時間
      $thetemper = $doc->getElementById( 'temper' ); // 模擬別組算出來的溫度資料
      // echo $thediv->textContent;
	  $temper = ( int ) $thetemper->textContent ; //把資料強制轉型成int型態，在此語言可以直接轉換無須煩惱ASCII的轉換
	  $time = $thetime->textContent ; // 發生時間( ex : 00:00:00)
	  $date = date("Y-m-d"); // 今天日期 ( ex : 2015-12-07 )
	  
	  if ( $temper > 120 ) {  //如果超過120度C的話，把溫度過高的事件寫進歷程記錄
	    $sql = "INSERT INTO `errorlog` (`Date`, `Time`, `Event`, `Errordata`) 
		        VALUES ('$date', '$time', 'OverHeat', '$temper') " ;
		$showerror[$showindex] = "======================================== <br><br> 
		                          機台發生錯誤！ <br><br>
		                          日期：$date    <br><br>
								  時間：$time    <br><br>
								  發生事件：溫度過高！<br><br>
								  溫度：$temper 度C <br><br>
								  ======================================== <br><br>
		                        ";	// 顯示給人員用，資料會存進資料庫	
        $showindex++;	
		if ( mysqli_query( $link, $sql ) == false ) // 如果輸入資料庫失敗
		  echo "Something Wrong...<br>";
	  } // if
	  
	  
	  
	  
	  
	  
	  //線速示範  
	  
      $thespeed = $doc->getElementById( 'speed' ); // 模擬別組算出來的線速資料
	  $speed = ( int ) $thespeed->textContent ; //把資料強制轉型成int型態，在此語言可以直接轉換無須煩惱ASCII的轉換
	  $speedstatusrecord = ""; // 紀錄SpeedStatus回傳的數值
	  if ( $lastspeedindex < 10 ) { // 未記錄完前十筆線速資料
		  $lastspeed[$lastspeedindex] = $speed;
		  $lastspeedindex++;
	  } // if
		
	  else // 已經滿了就更新那10秒的陣列到最新
		  UpdateTenSpeed( $speed, $lastspeed );
		  
	  // 下面這是偽裝的speed資料，前十秒的，真的要用的話請刪掉這裡的程式碼
      $lastspeed[0] = 500;
	  $lastspeed[1] = 500;
	  $lastspeed[2] = 500;
	  $lastspeed[3] = 700;
      $lastspeed[4] = 900;
	  $lastspeed[5] = 900;
	  $lastspeed[6] = 1200;
	  $lastspeed[7] = 1200;
      $lastspeed[8] = 1200;
	  $lastspeed[9] = 1200;
	  ////////////////////////////////////////////////////




	  
      $speedstatusrecord = SpeedStatus( $lastspeed );
	  
	  if ( $speedstatusrecord == "異常升速！" ) {
		$sql = "INSERT INTO `errorlog` (`Date`, `Time`, `Event`, `Errordata`) 
		        VALUES ('$date', '$time', 'SpeedUpTooQuick', '$speed' ) " ;
		$showerror[$showindex] = RecordInfo( $date, $time, "異常升速！", "線速", $lastspeed[0] ) ;	
        $showindex++;		
		if ( mysqli_query( $link, $sql ) == false ) // 如果輸入資料庫失敗
		  echo "Something Wrong...<br>";
	  } // if
	  
	  else if ( $speedstatusrecord == "異常降速！" ) {
		$showerror[$showindex] = RecordInfo( $date, $time, "異常降速！", "線速", $lastspeed[0] ) ;	
	  } // else if
	  
	  else if ( $speedstatusrecord == "線速過低！！" ) {
		$showerror[$showindex] = RecordInfo( $date, $time, "線速過低！！", "線速", $speed ) ;	
	  } // else if
	  
	  else if ( $speedstatusrecord == "線速過高！" ) {
		$showerror[$showindex] = RecordInfo( $date, $time, "線速過高！", "線速", $speed ) ;	
	  } // else if
	  
	  
	  
	  //轉換率示範
      $theturn = $doc->getElementById('turn'); // 模擬別組算出來的轉換率資料
	  $turn = ( double ) $theturn->textContent ; //把資料強制轉型成int型態，在此語言可以直接轉換無須煩惱ASCII的轉換
      if ( $turn < 5.85 ) {
	    $sql = "INSERT INTO `errorlog` (`Date`, `Time`, `Event`, `Errordata`) 
		        VALUES ('$date', '$time', 'TransferTooLow', '$turn' ) " ;
		$showerror[$showindex] = RecordInfo( $date, $time, "轉換率過低！", "轉換率", "1:".$turn ) ;	
        $showindex++;		
		if ( mysqli_query( $link, $sql ) == false ) // 如果輸入資料庫失敗
		  echo "Something Wrong...<br>";
	  } // if lower than 5.99
	  
	  else if ( $turn > 6.01 ) {
	    $sql = "INSERT INTO `errorlog` (`Date`, `Time`, `Event`, `Errordata`) 
		        VALUES ('$date', '$time', 'TransferTooHigh', '$turn' ) " ;
		$showerror[$showindex] = RecordInfo( $date, $time, "轉換率過高！！", "轉換率", "1:".$turn ) ;		
        $showindex++;	
		if ( mysqli_query( $link, $sql ) == false ) // 如果輸入資料庫失敗
		  echo "Something Wrong...<br>";
	  } // else if higher than 6.15
	  
	  
	  
	  
	  //機台狀態(標準工時)示範(未完成)
	  
      $thestatus = $doc->getElementById('machinestatus'); // 模擬別組算出來的機台狀態資料
	  $machinestatus = $thestatus->textContent ; //把資料強制轉型成int型態，在此語言可以直接轉換無須煩惱ASCII的轉換
	  
	  $theworktime = $doc->getElementById('worktime');  //MO101總工時(秒)
	  $worktime =(int) $theworktime->textContent ; //把資料強制轉型成int型態，在此語言可以直接轉換無須煩惱ASCII的轉換
	  $worktime_hour= floor($worktime/3600);
	  $worktime_minute = floor( ($worktime - ($worktime_hour*3600)) / 60);
	  $worktime_second = floor( ($worktime - ($worktime_hour*3600) - 60* $worktime_minute )%60);
	 
	  
	  
	  
	  if ( $worktime > 2700 ) {  //如果超過50分鐘的話，把超過標準工時的事件寫進歷程記錄
	    $sql = "INSERT INTO `errorlog` (`Date`, `Time`, `Event`, `Errordata`) 
		        VALUES ('$date', '$time', 'OverTime', '$worktime_hour:$worktime_minute:$worktime_second') " ;
		$showerror[$showindex] = "======================================== <br><br> 
		                          機台發生錯誤！ <br><br>
		                          日期：$date    <br><br>
								  時間：$time    <br><br>
								  發生事件：工時過高！<br><br>
								  工時：$worktime_hour : $worktime_minute : $worktime_second  <br><br>
								  ======================================== <br><br>
		                        ";	// 顯示給人員用，資料會存進資料庫	
        $showindex++;				
		if ( mysqli_query( $link, $sql ) == false ) // 如果輸入資料庫失敗
		  echo "Something Wrong...<br>";
	  } // if
	  
	  // 顯示出來給人員看
	 
	  ?>
	  <script>
        function ShowError() { //顯示下一筆資料
		  var i = 0 ;
		  var temp = <?php echo json_encode( $showerror );?> ;
		  var index = <?php echo $showindex ; ?> ;
		  while ( i < 3 ) { 
		    document.write( "" );
            document.getElementById('errorlog').innerHTML += temp[i];
			i++;
		  } // while
		} // ShowError()
   	  </script>
	  
	  <?php
	  
     echo " <script>ShowError()</script> " ; 
     flush();	 
        //  } // while // 整個應該是一個while迴圈目前只能先模擬那一秒各組算出的資料
        ?>	
  </body>
</html>