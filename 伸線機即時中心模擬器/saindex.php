<html>
  <head>
  <p id = "show" ></p>
  <p id = "speed" ></p>
  
  <script>
  function Clear() {  //清除上一筆資料
    document.getElementById( 'show' ).innerHTML='';
  }  // Clear()
  
  function ClearSpeed() {  //清除上一筆速度
    document.getElementById( 'speed' ).innerHTML='';
  }  // ClearSpeed()
  </script>
  
  <?php
    function Dataformat( $num ) {
      $hour = floor( $num / 3600 );
      $minute = floor( ( $num - 3600 * $hour ) / 60 );
      $second = floor( ( ( $num - 3600 * $hour ) - 60 * $minute ) % 60 );
	  
      return $hour.':'.$minute.':'.$second;
	} // Dataformat()
	
	function PushArrayIntoDB( &$dataarray, &$dataindex, &$obj ) {
      if ( isset($obj['data']) == true )
        $dataarray[$dataindex] = $obj['data']; 
	  else { 
	    echo "模擬器炸掉啦!!!!!<br>";
	  } // else
      $dataindex++;

	} // PushArrayIntoDB()
	
	function FormatArray( &$dataarray ) {
	  $i = 0 ; 
	  while ( $i < 6 ) {
		$dataarray[$i] = "";
	    $i++;
	  } // while
	} // FormatArray()
	
	function Machine( &$dataarray, $startsecend, $insert ) {
      // 抓取模擬器資料部分
	  // 寫成一個函數想抓啥就抓啥之後的演算法比較好算 ， 如果insert == true的話就是要insert進資料庫其餘不用
	  // $dataarray[0] = time
	  // $dataarray[1] = C11_I1_Meter
	  // $dataarray[2] = C11_I1_Position
	  // $dataarray[3] = C11_O1_Meter
	  // $dataarray[4] = C11_O1_Position
	  // $dataarray[5] = C11_Thermal

	  $simulatoractive = true ; // default it is active
	  set_time_limit(0); // 不受時間限制
      $link = mysqli_connect ( 'localhost' , 'root' , '1234' ) ;
	  mysqli_select_db($link, 'sa'); 
	  // 送出Big5編碼的MySQL指令
	  //mysqli_query($link, "SET CHARACTER SET utf8"); 
      //mysqli_query($link, 'SET collation_connection = "utf8_general_ci"');
      
	  $i = $startsecend ; // 讀取資料用的秒數
	  $dataindex = 0 ; // 陣列的INDEX
	  $dataarray = array(); // 準備存進SQL的陣列  	
		// 抓取TIME && C11_I1_METER
	    $url = "http://etouch20.cycu.edu.tw:5146/simone/read/?mid=%E8%B3%87%E7%AE%A1%E4%B8%89C11%E4%BC%B8%E7%B7%9A%E6%A9%9F&sid=C11-I1-Meter&time=";
	    $time = Dataformat( $i ) ;
		$c11_i1_meter= file_get_contents( $url.$time );
		$obj = json_decode( $c11_i1_meter, true ); // 轉成陣列
		foreach( $obj as $key=>$value ) { // 把陣列的值取出來
          $dataarray[$dataindex] = $value;
		  $dataindex++;
        } // foreach
		
		
		// 抓取C11_I1_POSITION
	    $url = "http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-I1-Position&time=";
	    $time = Dataformat( $i ) ;
		$c11_i1_position= file_get_contents( $url.$time );
		$obj = json_decode( $c11_i1_position, true ); // 轉成陣列
		
		// 把陣列的值取出來
		PushArrayIntoDB( $dataarray, $dataindex, $obj ) ;
     
	    // 抓取C11-O1-Meter
	    $url = "http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-O1-Meter&time=";
	    $time = Dataformat( $i ) ;
		$c11_o1_meter= file_get_contents( $url.$time );
		$obj = json_decode( $c11_o1_meter, true ); // 轉成陣列
		
		// 把陣列的值取出來
		PushArrayIntoDB( $dataarray, $dataindex, $obj ) ;
				
		
	    // 抓取C11-O1-Position
	    $url = "http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-O1-Position&time=";
	    $time = Dataformat( $i ) ;
		$c11_o1_position = file_get_contents( $url.$time );
		$obj = json_decode( $c11_o1_position, true ); // 轉成陣列
		
		// 把陣列的值取出來
		PushArrayIntoDB( $dataarray, $dataindex, $obj ) ;
		
	    // 抓取C11-Thermal
	    $url = "http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-Thermal&time=";
	    $time = Dataformat( $i ) ;
		$c11_thermal = file_get_contents( $url.$time );
		$obj = json_decode( $c11_thermal, true ); // 轉成陣列
		
		// 把陣列的值取出來
		PushArrayIntoDB( $dataarray, $dataindex, $obj ) ;
		
		
        
		if ( $insert == true ) { // 如果為true的話才要輸入進資料庫
		    // `
			$sql = " INSERT INTO `C11` (`Time`, `C11_I1_Meter`, `C11_I1_Position`, `C11_O1_Meter`, `C11_O1_Position`, `C11_Thermal` ) 
		         VALUES ( '$dataarray[0]', '$dataarray[1]', '$dataarray[2]', '$dataarray[3]', '$dataarray[4]', '$dataarray[5]' ) " ;  
			if ( mysqli_query( $link, $sql ) == false )
		      echo "Insert Error!!!...<br>";
		} // if insert == true
		
		
		mysqli_close( $link );
	} // Machine()
	
	function Speed( &$dataarray, &$countmeter, $speed, &$speedsecend, &$workstartornot ) { // 此秒的資料陣列、要比對變動的線段長度、速度、計算到下次線段變動後的秒數家總、是否開始生產電纜了
	  // 看要花多少秒從自己的公尺數變動到下一個公尺數
	  // 8秒一公尺
	  // 6 5 4 3 
	  // bug是0秒的時候無法計算 ( 加上整備的過程，過程中公尺數一直都是0 )
	  
	  $nowmeter = ( int ) $dataarray[3] ; // 現在的產出線段長度
	  if ( $dataarray[2] != "0" && $dataarray[4] != "0" ) { // 當產出軸跟投入軸都有的時候
	    if ( $countmeter == -1 ) { // 第一次進來要下錨
	      $countmeter = $nowmeter ;
		  $speedsecend = 1 ; // 第一秒
		  $workstartornot = true ; // 代表生產工作開始了
		  return $speed ;
	    } // if 
	  
	    else if ( $countmeter != -1 ) { // 已經下錨了
	      if ( $nowmeter == $countmeter ) {
	        $speedsecend++ ; // 要計算的秒數增加
		    return $speed; // 線速保持不辨，因為公尺數並無增加
		  } // if
		
		  else { // 公尺數變動了，開始計算變動之前到後花的秒數
	        // 每$speedsecend 秒有一公尺的線
		    // 每秒可產出 1 / $speedsecend 公尺
		    // 再乘以60 等於每分鐘可以產 多少公尺就可以算出分鐘線速
		    $speed = ( double ) ( $nowmeter - $countmeter ) / ( double ) $speedsecend ;
		    $speed *= 60 * 60 ; // 每小時線速
			if ( $speed < 0 )
			  $speed = 0 - $speed ; // 取正數
		    $countmeter = $nowmeter ; // 把錨reset
		    $speedsecend = 1 ;
		    return $speed ;
		  } // else
	    }  // else if
   
      } // if $dataarray[2] != "0" && $dataarray[4] != "0"
	  
	  
	  // 以下的nowmeter都等於0
	  
	  
	  else {  // 沒有產出軸
	    $countmeter = -1 ;
		return 0 ;
	  } // else 
	
	} // Speed()
	
	
	function Transfer(  ) {
		
	} // Transfer()
	
	
	
	
	function MachineStatus( &$dataarray, $startsecend, $speed, $lastspeed, &$workstartornot ) { // 現在所有資料、現在秒數、現在速度、十秒速度陣列、電纜生產完沒
	  // $dataarray[0] = time
	  // $dataarray[1] = C11_I1_Meter
	  // $dataarray[2] = C11_I1_Position
	  // $dataarray[3] = C11_O1_Meter
	  // $dataarray[4] = C11_O1_Position
	  // $dataarray[5] = C11_Thermal
	  // 第一種狀況A：兩軸座皆無軸 -> 不用算
	  // 第二種狀況B：投入軸有軸，產出軸無軸
	  // 第三種狀況B：投入軸無軸，產出軸有軸
	  // 第四種狀況D：投入軸跟產出軸皆上       -> 這時候的線速直接1MIN去算
	  // 剩餘參考燈號表  	  
	  
	  /*
	  if ( $startsecend != 0 ) {
		set_time_limit(0); // 不受時間限制
        $link = mysqli_connect ( 'localhost' , 'root' , '1234' ) ;
	    mysqli_select_db($link, 'sa');
		$temp = Dataformat( $startsecend - 1 ) ;
		$sql = " SELECT * FROM `c11` WHERE TIME = `$temp` ";
		$lastarray = mysqli_query( $link, $sql ) ;
		echo $lastarray['time'];
		
	    // Machine( $lastarray, $startsecend - 1, false ); // 查詢前一秒的機台感應器
	  } // if
	  */
	  
	  if ( $dataarray[2] == "0" && $dataarray[4] == "0"  ) { // 第一種狀況A：兩軸座皆無軸
	    return "停工中..." ;
	  } // if A
		
	  else if ( $dataarray[2] != "0" && $dataarray[4] == "0" ) {  // 第二種狀況B：投入軸有軸，產出軸無軸
	    // 接下來看產出軸與投入軸的線段判斷狀況
		if ( $dataarray[1] == "0" && $dataarray[3] == "0" ) { // 皆沒有線段
		  $workstartornot = false ;
		  return "完成所有產出工作，等待投入軸下軸即可完工。。。";
		} // if
		
		else if ( $dataarray[1] != "0" && $dataarray[3] == "0" ) { // 有投入線段無產出線段
		  if ( $workstartornot == true ) // 上一秒的時間不為0且上一秒的產出軸還在
		    return "整備中。。。(更換產出軸)";
		  else // $workstartornot == false 產出玩了OR沒再產出
			return "整備中。。。(新製令下來)";
		} // else if 
		
		else if ( $dataarray[1] == "0" && $dataarray[3] != "0" ) { // 有產出線段無投入線段
		  return "投入線段已使用完畢，待產出軸生產完。。。";
		} // else if 
		
		else { // 同時有投入線段與產出線段
		  // 根本沒有有投入軸，產出軸無軸且同時都有線段的狀況 ( 照理說產出軸無軸就不該有產出線段了 )
		  return "異常狀況發生！！";
		} // else
		
	  } // else if 
	  
	  else if ( $dataarray[2] == "0" && $dataarray[4] != "0" ) {  // 第三種狀況C：投入軸吳軸，產出軸有軸
	    // 這種狀況一定是還在進行生產然後更換投入軸，不然就是異常狀況了 
	    if ( $dataarray[1] == "0" && $dataarray[3] == "0" ) { // 皆沒有線段 
		  // 同時都需要換軸的可能在這
		  return "整備中。。。(更換投入軸 更換產出軸中)";
		} // if
		
		else if ( $dataarray[1] == "0" && $dataarray[3] != "0" ) { //只有產出軸有線段
		  // 那就是投入的線段已用完但還要繼續產出的時候
		  return "整備中。。。(更換投入軸)";
		} // else if
		
		else { // 同時有投入線段與產出線段
		  return "異常狀況發生！！";
		} // else
	  } // else if 
		  
	  else { // 第四種狀況D：投入軸跟產出軸皆上
	    if ( $dataarray[1] == "0" && $dataarray[3] == "0" ) { // 皆沒有線段
		  // 沒有這種狀況@@
		  return "異常狀況發生！！！";
		} // if
		
		else if ( $dataarray[1] != "0" && $dataarray[3] == "0" ) { // 有投入線段無產出線段
		  return "生產中。。。(線速未知)";
		} // else if 
		
		else if ( $dataarray[1] == "0" && $dataarray[3] != "0" ) { // 有產出線段無投入線段 
		  // 需要判斷增速降速均素
		  return SpeedStatus( $lastspeed );
		} // else if 
		
		else { // 同時有投入線段與產出線段
		  // 需要判斷增速降速均素
		  return SpeedStatus( $lastspeed );
		} // else
	    
	  }  // else if 
	  
	} // MachineStatus()
	
	
	function SpeedStatus( $lastspeed ) {
	  // 如果線速10S內變動不超過400 hr / m 又持續升速，且低於1200(+-100)的話就是穩定升速
      // 如果線速10S內變動不超過400 hr / m 又持續降速，且低於1200(+-100)的話就是降速 
	  // 會進入到這個函數的時候產出軸與投入軸都是有軸的！
	  
	  
	  if ( $lastspeed[9] > 1300 )
	    return "線速過低！！";
	  else if ( $lastspeed[9] == 0 )
		return "生產中。。。(線速未知)";
	
	  else if ( $lastspeed[0] < $lastspeed[9] && $lastspeed[9] < 1300 ) {
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
	
	function UpdateTenSpeed( $speed, &$speedarray ) {
	  $i = 0 ;
	  while ( $i < 9 ) { // 10個裡面往左邊移動 0~8 
	    $speedarray[$i] = $speedarray[$i+1] ;
		$i++;
	  } // while
	  
	  
	  $speedarray[9] = $speed ; // 最新的一筆速度資料
	} // UpdateTenSpeed()
	
  ?>
  </head>
  
  <body>

    <?php 
	  // main()
	  $startsecend = 0 ; // 讀取資料用開始的秒數
	  $endsecend = 3601 ;   // 讀取資料用結束的秒數
	  $speedsecend = 0 ;    // 線速秒數計算
	  $dataarray = array(); // 準備存進SQL的陣列
	  $countmeter = -1;      // 計算線速用
	  $speed = 0.0 ; // 線速
	  $lastspeed = array(); // 上十秒的線速
	  $lastspeedindex = 0 ; // 上十秒線速INDEX
	  $insert = true; // 要不要匯入資料庫
	  $workstartornot = false ; // 如果整個線段開始生產了就設為true，產玩了則FALSE
	  
	  ob_end_flush(); // 顯示用
	  while ( $startsecend < $endsecend ) {
	    Machine( $dataarray, $startsecend, $insert) ;
		
		/*
		if ( $startsecend != 0 ) {
		  // Machine( $lastdataarray, $startsecend - 1, false ) ; // 抓取上一秒資料用
		} // if
        */
		
	    $show = "時間：".$dataarray[0]."<br>C11-I1-Meter：".$dataarray[1]."<br>C11-I1-Position：".$dataarray[2]
              	."<br>C11-O1-Meter：".$dataarray[3]."<br>C11-O1-Position：".$dataarray[4]."<br>C11-Thermal：".$dataarray[5];
        $speed = Speed( $dataarray, $countmeter, $speed, $speedsecend, $workstartornot );
		
		// 把秒數輸入進lastspeed陣列裡
		if ( $lastspeedindex < 10 ) { // 未記錄完前十筆線速資料
		  $lastspeed[$lastspeedindex] = $speed;
		  $lastspeedindex++;
		} // if
		
		else // 已經滿了就更新那10秒的陣列到最新
		  UpdateTenSpeed( $speed, $lastspeed );
		
		echo "目前線速為".$speed." m / hr<br>" ;
		if ( $speed < 0 || $speed > 1200 ) // 
		  echo $dataarray[0];
		$status = MachineStatus( $dataarray, $startsecend, $speed, $lastspeed, $workstartornot ) ;
		echo $status."<br>";
		flush();
	?>
    <script>
      function Show() {//顯示下一筆資料
        document.getElementById('show').innerHTML="<?php echo $show;?>";                                                       
      } // Show()
   	</script>
	<?php
	//顯示用部分
		echo "<script> Clear() </script>";	 
		flush();
		echo "<script> Show() </script>"; // 顯示用 
		flush();
		// sleep( 0.5 ); // 暫停0.5秒	
        $startsecend++;		
		FormatArray( $dataarray ) ; // 清空陣列	
	} // while		
	
	// main() end
	?> 
	
    
  </body>
</html>