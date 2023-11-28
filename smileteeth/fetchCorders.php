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
            
                 
    $queryselectionn = "SELECT users.user_id, users.email, users.image,users.username, ordertable.pharmacyid, ordertable.useremail, ordertable.order_id,ordertable.pharmacyid, ordertable.email, ordertable.name, ordertable.phone , ordertable.address, ordertable.cnic, ordertable.doctor, ordertable.image as orderimage, ordertable.orderdate FROM users , ordertable

WHERE

ordertable.useremail = users.email

AND
ordertable.status = 'Deleivered'
AND

ordertable.pharmacyid = '$val[user_id]'

ORDER BY ordertable.order_id DESC
";
    $resultchecks = mysqli_query($con,$queryselectionn);
    if($resultchecks->num_rows >= 1){
         $spacecrafts=array();
        while($row=mysqli_fetch_array($resultchecks))
        {
            $rowsTotal++;
            array_push($spacecrafts, array("id"=>$row['order_id'],"username"=>$row['username'],"name"=>$row['name'],
                    "email"=>$row['email'],"phone"=>$row['phone'],"address"=>$row['address'],"cnic"=>$row['cnic'],"doctor"=>$row['doctor'],"image"=>$row['image'],"orderdate"=>$row['orderdate'],"orderimage"=>$row['orderimage']
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


