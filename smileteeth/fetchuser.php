<?php

    include 'dbcon.php';
    
    
    $email = mysqli_real_escape_string($con, $_POST['email']);

 $queryselection = "SELECT * FROM users WHERE email = '".$email."' or username = '".$email."'  ";
    $resultcheck = mysqli_query($con,$queryselection);
    if(mysqli_num_rows($resultcheck) > 0){
        if($rows=mysqli_fetch_array($resultcheck))
        {
            $MSG = "exists"."*".$rows["image"]."*".$rows["bio"]."*".$rows["phonenumber"];
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