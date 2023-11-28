<?php

    include 'dbcon.php';
    
    
    
     $email = mysqli_real_escape_string($con, $_POST['email']);
      $name = mysqli_real_escape_string($con, $_POST['name']);
      $phonenumber = mysqli_real_escape_string($con, $_POST['phonenumber']);
      $message = mysqli_real_escape_string($con, $_POST['message']);
   
  
$datevalue = date("d-m-Y");
    $query = "INSERT into contactus(name, email, phonenumber, message) VALUES ('$name', '$email', '$phonenumber', '$message')";
                            if(mysqli_query($con,$query)){
            
                $MSG = 'pass';
                 
                // Converting the message into JSON format.
                $json = json_encode($MSG);
                 
                // Echo the message.
                 echo $json ;
             }
               else{
                echo 'Try Again';
             }

        
?>