<?php

    include 'dbcon.php';
    
    
    
     $userid = mysqli_real_escape_string($con, $_POST['userid']);
      $status = mysqli_real_escape_string($con, $_POST['status']);
  
$datevalue = date("d-m-Y");
    $query = "update users set status = '$status' where user_id = '$userid'";
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