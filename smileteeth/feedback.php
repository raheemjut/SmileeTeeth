<?php

    include 'dbcon.php';
    
    
    
     $email = mysqli_real_escape_string($con, $_POST['email']);
     
      $message = mysqli_real_escape_string($con, $_POST['message']);
   
  
$datevalue = date("d-m-Y");
    $query = "INSERT into feedback(email, message) VALUES ('$email', '$message')";
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