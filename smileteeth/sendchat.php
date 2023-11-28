<?php

    include 'dbcon.php';
    
     $message = mysqli_real_escape_string($con, $_POST['message']);
     
     $senderphone = mysqli_real_escape_string($con, $_POST['senderphone']);
      $receiverphone = mysqli_real_escape_string($con, $_POST['receiverphone']);
       $status = mysqli_real_escape_string($con, $_POST['status']);
       
    
          $return["error"] = false;
$return["msg"] = "";
//array to return

if(isset($_POST["image"])){
  
   
  
    $val = rand(10,1000000000000);

    $base64_string = $_POST["status"];

    $outputfile = "userimages/".$val.".jpg" ;
 
    $imagename = $val.".jpg";

    //save as image.jpg in uploads/ folder

    $filehandler = fopen($outputfile, 'wb' ); 

    
    
    fwrite($filehandler, base64_decode($base64_string));
   
    fclose($filehandler); 
    $daterefund = date("Y-m-d");
    $query = "INSERT INTO chat (message, sender_phone,receiver_phone, status)
              VALUES('$message', '$senderphone','$receiverphone','$imagename' )";
              mysqli_query($con,$query);
            //                 if(mysqli_query($con,$query)){
            // //  $to_email = $email;
            // //     $subject = 'Mad Mom V';
            // //     $message = 'Dear User:'.$email.' Your verification code for registration at My Home  is : '.$code;
            // //     $headers = 'From: info@myhomeinteriors.uk';
            // //     mail($to_email,$subject,$message,$headers); 
            //      // On query success it will print below message.
            //     $MSG = 'pass' ;
                 
            //     // Converting the message into JSON format.
            //     $json = json_encode($MSG);
                 
            //     // Echo the message.
            //      echo $json ;
            //  }
            //   else{
            //     echo 'Try Again';
            //  }
      
     
}else{
    $return["error"] = true;
    $return["msg"] =  "No image is submited.";
    
    $query = "INSERT INTO chat (message, sender_phone,receiver_phone, status)
              VALUES('$message','$senderphone','$receiverphone','$status' )";
                            if(mysqli_query($con,$query)){
            //  $to_email = $email;
            //     $subject = 'Mad Mom V';
            //     $message = 'Dear User:'.$email.' Your verification code for registration at My Home  is : '.$code;
            //     $headers = 'From: info@myhomeinteriors.uk';
            //     mail($to_email,$subject,$message,$headers); 
                 // On query success it will print below message.
                $MSG = 'pass' ;
                 
                // Converting the message into JSON format.
                $json = json_encode($MSG);
                 
                // Echo the message.
                 echo $json ;
             }
               else{
                echo 'Try Again';
             }
                    
}

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);  


        
?>











