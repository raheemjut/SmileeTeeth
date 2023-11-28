<?php

    include 'dbcon.php';
    
    
    
     $username = mysqli_real_escape_string($con, $_POST['username']);
     $email = mysqli_real_escape_string($con, $_POST['email']);
     $password = mysqli_real_escape_string($con, $_POST['password']);
     $accounttype = mysqli_real_escape_string($con, $_POST['accounttype']);
     $registrationno = mysqli_real_escape_string($con, $_POST['registrationno']);
     $phonenumber = mysqli_real_escape_string($con, $_POST['phone']);


    if($accounttype != "Customer" )
    {
        $queryselection =
       "SELECT * FROM users WHERE  email = '$email' or username = '$username' or registration_no  = '$registrationno' " ;
    }
    else
    {
        $queryselection =
       "SELECT * FROM users WHERE  email = '$email' or username = '$username'" ;
    }
  
      
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
    $query = "INSERT INTO users ( username ,email ,password ,account_type,registration_no , phonenumber, status, image, bio)
              VALUES( '$username' , '$email','$password'  ,'$accounttype' , '$registrationno', '$phonenumber', 'Deactive', 'N/A', '')";
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