<?php

    include 'dbcon.php';
    
    
    $email = mysqli_real_escape_string($con, $_POST['email']);
    $password = mysqli_real_escape_string($con, $_POST['password']);

 $queryselection = "SELECT * FROM users WHERE (email = '".$email."' or username = '".$email."'  )and password = '".$password."' and status = 'Active'";
    $resultcheck = mysqli_query($con,$queryselection);
    if(mysqli_num_rows($resultcheck) > 0){
        if($rows=mysqli_fetch_array($resultcheck))
        {
            $MSG = "exists"."*".$rows["email"]."*".$rows["account_type"]."*".$rows["username"];
            // Converting the message into JSON format.
                $json = json_encode($MSG);
                 
                // Echo the message.
                 echo $json ;
        
        }
            
                
    }
else
{
        $MSG = 'not' ;
                 
                // Converting the message into JSON format.
                $json = json_encode($MSG);
                 
                // Echo the message.
                 echo $json ;
            
} 
        
?>