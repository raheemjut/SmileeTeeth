<?php

    include 'dbcon.php';
    $email = mysqli_real_escape_string($con, $_POST['email']);
   // $password = mysqli_real_escape_string($con, $_POST['password']);
    $rowsTotal = 0;

$queryselection = "SELECT * from users where email = '$email'";
$resultcheck = mysqli_query($con,$queryselection);
    if(mysqli_num_rows($resultcheck) > 0){



        if($val=mysqli_fetch_array($resultcheck)){

            $MSG = 'exists';
            
                 
    $queryselectionn = "SELECT users.user_id, users.email, users.image,users.username, appointment.apt_id, appointment.useremail, appointment.doctor_id, appointment.apt_time, appointment.apt_date, appointment.status FROM users , appointment

WHERE

appointment.useremail = users.email

AND
appointment.status = 'Confirmed'
AND

appointment.doctor_id = '$val[user_id]'";
    $resultchecks = mysqli_query($con,$queryselectionn);
    if($resultchecks->num_rows >= 1){
         $spacecrafts=array();
        while($row=mysqli_fetch_array($resultchecks))
        {
            $rowsTotal++;
            array_push($spacecrafts, array("id"=>$row['apt_id'],"username"=>$row['username'],"apttime"=>$row['apt_time'],
                    "aptdate"=>$row['apt_date'],"status"=>$row['status'],"image"=>$row['image']
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
        }
         
        
    }


 
        
?>
