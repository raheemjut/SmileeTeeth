<?PHP
   include 'dbcon.php';
    $senderphone = mysqli_real_escape_string($con, $_POST['senderphone']);
    $receiverphone = mysqli_real_escape_string($con, $_POST['receiverphone']);
    $queryselection = "select * from chat where (sender_phone = '$senderphone' and receiver_phone = '$receiverphone')
    or
    (sender_phone = '$receiverphone' and receiver_phone = '$senderphone')
    order by chat_id ";
    $resultcheck = mysqli_query($con,$queryselection);
    if($resultcheck->num_rows >= 1){
         $spacecrafts=array();
        while($row=mysqli_fetch_array($resultcheck))
        {
            $rowsTotal++;
         $time = date("H:i A  d-m-Y",strtotime($row['date_time']));
                    array_push($spacecrafts, array("id"=>$row['chat_id'],"senderphone"=>$row['sender_phone'],"receiverphone"=>$row['receiver_phone'],
                    "message"=>$row['message'],"datetime"=>$time,
                    "status"=>$row['status']
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