<?php

    include 'dbcon.php';
    
    
    
     $aptid = mysqli_real_escape_string($con, $_POST['aptid']);
      $status = mysqli_real_escape_string($con, $_POST['status']);
  
$datevalue = date("d-m-Y");
    $query = "update ordertable set status = '$status' where order_id = '$aptid'";
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