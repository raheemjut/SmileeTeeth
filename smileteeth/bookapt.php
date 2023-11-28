<?php

    include 'dbcon.php';
    
    
    
     $aptdate = mysqli_real_escape_string($con, $_POST['aptdate']);
     $apttime = mysqli_real_escape_string($con, $_POST['apttime']);
     $useremail = mysqli_real_escape_string($con, $_POST['useremail']);
     $doctorid = mysqli_real_escape_string($con, $_POST['doctorid']);

   $queryselection =
       "SELECT * FROM appointment WHERE  apt_date = '$aptdate' and apt_time = '$apttime' and doctor_id = '$doctorid'" ;

  
      
    $resultcheck = mysqli_query($con,$queryselection);
    if(mysqli_num_rows($resultcheck) > 0){
         $MSG = 'exists';
            
                 
                // Converting the message into JSON format.
                $json = json_encode($MSG);
                 
                // Echo the message.
                 echo $json ;
        
    }
    else
{
$datevalue = date("d-m-Y");
    $query = "INSERT INTO appointment (useremail,doctor_id, apt_time, apt_date,status)
              VALUES( '$useremail' , '$doctorid','$apttime'  ,'$aptdate' , 'Booked')";
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
} 
        
?>