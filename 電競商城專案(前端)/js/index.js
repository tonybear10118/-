function check(){
	//regist,Rpwd,name,mail
	var checkName = document.getElementById("name").value;
    if(checkName.match(/[^\u3447-\uFA29]/ig)){
    	alert("姓名只能是中文！");
    	document.getElementById("name").value = "";
    }

    var checkEmail = document.getElementById("mail").value;
    if(checkEmail.match("@")==null){
        alert("信箱要函有@！");
    	document.getElementById("mail").value = "";
    }
}