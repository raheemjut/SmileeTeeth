<?php

    include 'dbcon.php';
    
   // $password = mysqli_real_escape_string($con, $_POST['password']);
    $rowsTotal = 0;
 $queryselection = "SELECT * from users where account_type = 'Doctor' and status = 'Active'";
    $resultcheck = mysqli_query($con,$queryselection);
    if($resultcheck->num_rows >= 1){
         $spacecrafts=array();
        while($row=mysqli_fetch_array($resultcheck))
        {
            $rowsTotal++;
            array_push($spacecrafts, array("id"=>$row['user_id'],"username"=>$row['username'],"email"=>$row['email']
                    )
                    
                    );
        
        }
            print(json_encode($spacecrafts));
                
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


