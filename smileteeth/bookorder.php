<?php

    include 'dbcon.php';
    
 $return["error"] = false;
$return["msg"] = "";
//array to return

if(isset($_POST["image"])){
    $pharmacyid = mysqli_real_escape_string($con, $_POST['pharmacyid']);
    $useremail = mysqli_real_escape_string($con, $_POST['useremail']);
    $email = mysqli_real_escape_string($con, $_POST['email']);
    $name = mysqli_real_escape_string($con, $_POST['name']);
    $phone = mysqli_real_escape_string($con, $_POST['phone']);
    $address = mysqli_real_escape_string($con, $_POST['address']);
    $cnic = mysqli_real_escape_string($con, $_POST['cnic']);
    $doctor = mysqli_real_escape_string($con, $_POST['doctor']);

    $val = rand(10,10000000000000);

    $base64_string = $_POST["image"];

    $outputfile = "userimages/".$val.".jpg" ;
 
    $imagename = $val.".jpg";

    //save as image.jpg in uploads/ folder

    $filehandler = fopen($outputfile, 'wb' ); 

    
    
    fwrite($filehandler, base64_decode($base64_string));
   
    fclose($filehandler); 
    $daterefund = date("Y-m-d");
    $query = "INSERT into ordertable 
    (pharmacyid,useremail,email, name, phone, address, cnic, doctor, image, orderdate, status)
    VALUES
    ('$pharmacyid', '$useremail', '$email', '$name', '$phone', '$address', '$cnic', '$doctor', '$imagename', '$daterefund', 'Active')
    
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




