window.setTimeout("sho_clo_time()", 1000);
function get_vn_time(){
    var time = new Date();
    var dow = time.getDay();
    if(dow==0)
        dow = "Chủ nhật";
    else if (dow==1)
        dow = "Thứ hai";
    else if (dow==2)
        dow = "Thứ ba";
    else if (dow==3)
        dow = "Thứ tư";
    else if (dow==4)
        dow = "Thứ năm";
    else if (dow==5)
        dow = "Thứ sáu";
    else if (dow==6)
        dow = "Thứ bảy";  
    var day = time.getDate();
    var month = time.getMonth()+1;
    var year = time.getFullYear();
    var hr = time.getHours();
    var min = time.getMinutes();
    var sec = time.getSeconds();
    day = ((day < 10) ? "0" : "") + day;
    month = ((month < 10) ? "0" : "") + month;
    hr = ((hr < 10) ? "0" : "") + hr;
    min = ((min < 10) ? "0" : "") + min;
    sec = ((sec < 10) ? "0" : "") + sec;
    return dow + " " + day + "/" + month + "/" + year + " " + hr + ":" + min + ":" + sec;
}
function sho_clo_time(){
    var clo_vn_time = document.getElementById("clo_vn_time");
    if (clo_vn_time != null)
        clo_vn_time.innerHTML = get_vn_time();
    setTimeout("sho_clo_time()", 1000);
}