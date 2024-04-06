<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Property Details</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>

<body>
    <h1>Property Details</h1>
    <?php
    include 'connectdb.php';

    if (isset($_POST['propertyinfo'])) {
        $propertyID = $_POST['propertyinfo'];

        $query = $connection->prepare("SELECT RentalProperty.*, PropertyManager.FirstName AS ManagerFirstName, PropertyManager.LastName AS ManagerLastName, 
        GROUP_CONCAT(DISTINCT Owner.FirstName, ' ', Owner.LastName SEPARATOR ', ') AS OwnerNames 
        FROM RentalProperty 
        JOIN PropertyManager ON RentalProperty.ManagerID = PropertyManager.ManagerID JOIN OwnerProperty ON RentalProperty.PropertyID = OwnerProperty.PropertyID 
        JOIN Owner ON OwnerProperty.OwnerID = Owner.OwnerID WHERE RentalProperty.PropertyID = :propertyID 
        GROUP BY RentalProperty.PropertyID");

        $query->execute([':propertyID' => $propertyID]);

        if ($row = $query->fetch(PDO::FETCH_ASSOC)) {
            echo "<table>";
            echo "<tr><th>Attribute</th><th>Value</th></tr>";
            echo "<tr><td>Property ID</td><td>" . $row['PropertyID'] . "</td></tr>";
            echo "<tr><td>Type</td><td>" . $row['Type'] . "</td></tr>";
            echo "<tr><td>Cost Per Month</td><td>$" . $row['CostPerMonth'] . "</td></tr>";
            echo "<tr><td>Manager Name</td><td>" . $row['ManagerFirstName'] . " " . $row['ManagerLastName'] . "</td></tr>";
            echo "<tr><td>Owner Names</td><td>" . $row['OwnerNames'] . "</td></tr>";
            echo "<tr><td>Address</td><td>" . $row['Address'] . "</td></tr>";
            echo "<tr><td>City</td><td>" . $row['City'] . "</td></tr>";
            echo "<tr><td>Province</td><td>" . $row['Province'] . "</td></tr>";
            echo "<tr><td>Postal Code</td><td>" . $row['PostalCode'] . "</td></tr>";
            echo "<tr><td>Apartment Number</td><td>" . $row['StreetOrApartmentNumber'] . "</td></tr>";
            echo "<tr><td>Unit Type</td><td>" . $row['Type'] . "</td></tr>";
            echo "<tr><td>Number of Beds</td><td>" . $row['NumberOfBedrooms'] . "</td></tr>";
            echo "<tr><td>Number of Baths</td><td>" . $row['NumberOfBathrooms'] . "</td></tr>";
            echo "<tr><td>Parking</td><td>" . ($row['Parking'] ? 'Yes' : 'No') . "</td></tr>";
            echo "<tr><td>Laundry Type</td><td>" . $row['LaundryType'] . "</td></tr>";
            echo "<tr><td>Listing Date</td><td>" . $row['ListingDate'] . "</td></tr>";
            echo "</table>";
        } else {
            echo "No property found with the specified ID.";
        }
    } else {
        echo "No property selected.";
    }

    ?>

    <a href="rental.php">Back to Property List</a>
</body>

</html>