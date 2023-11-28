<?php

    include 'dbcon.php';
    
 $return["error"] = false;
$return["msg"] = "";
//array to return

if(isset($_POST["image"])){
    $bio = mysqli_real_escape_string($con, $_POST['bio']);
    $email = mysqli_real_escape_string($con, $_POST['email']);
   
  
    $val = rand(10,10000000000000);

    $base64_string = $_POST["image"];

    $outputfile = "userimages/".$val.".jpg" ;
 
    $imagename = $val.".jpg";

    //save as image.jpg in uploads/ folder

    $filehandler = fopen($outputfile, 'wb' ); 

    
    
    fwrite($filehandler, base64_decode($base64_string));
   
    fclose($filehandler); 
    $daterefund = date("Y-m-d");
    $query = "update users 
    set
    bio = '$bio',
    image = '$imagename'

    where
    
    email
     = '$email'
    
    ";
    mysqli_query($con, $query);
      
     
}else{
    $return["error"] = true;
    $return["msg"] =  "No image is submited.";
}

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);
        
?>




