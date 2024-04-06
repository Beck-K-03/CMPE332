<?php
include 'connectdb.php';

$GroupID = $_POST['GroupID'];
$AccomodationType = $_POST['AccomodationType'];
$PreferredNumBath = $_POST['PreferredNumBath'];
$PreferredNumBed = $_POST['PreferredNumBed'];
$PreferredLaundry = $_POST['PreferredLaundry'];
$PreferredAccessibility = $_POST['PreferredAccessibility'];
$ParkingDesired = $_POST['ParkingDesired'];
$MaxRent = $_POST['MaxRent'];



$query = $connection->prepare("UPDATE RentalGroup SET AccomodationType = :AccomodationType, PreferredNumBath = :PreferredNumBath, PreferredNumBed = :PreferredNumBed, PreferredLaundry = :PreferredLaundry, PreferredAccessibility = :PreferredAccessibility, ParkingDesired = :ParkingDesired, MaxRent = :MaxRent WHERE GroupID = :GroupID");


$query->bindParam(':GroupID', $GroupID);
$query->bindParam(':AccomodationType', $AccomodationType);
$query->bindParam(':PreferredNumBath', $PreferredNumBath);
$query->bindParam(':PreferredNumBed', $PreferredNumBed);
$query->bindParam(':PreferredLaundry', $PreferredLaundry);
$query->bindParam(':PreferredAccessibility', $PreferredAccessibility);
$query->bindParam(':ParkingDesired', $ParkingDesired);
$query->bindParam(':MaxRent', $MaxRent);

if ($query->execute()) {
    echo "Group details updated successfully.";
} else {
    echo "Error updating group details.";
}

echo "<a href='RentalGroupList.php'>Back to Rental Group List</a>";
?>