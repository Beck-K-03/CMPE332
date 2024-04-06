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

        /* Style for submit buttons */
        input[type="submit"] {
            background-color: #4CAF50;
            /* Green background */
            color: white;
            /* White text */
            padding: 12px 20px;
            /* Padding around the text */
            border: none;
            /* No border */
            border-radius: 4px;
            /* Rounded corners */
            cursor: pointer;
            /* Change mouse cursor to pointer */
            font-size: 16px;
            /* Text size */
            transition: background-color 0.3s;
            /* Smooth background color transition on hover */
        }

        /* Style for submit buttons on hover and focus */
        input[type="submit"]:hover,
        input[type="submit"]:focus {
            background-color: #45a049;
            /* Darker shade of green when hovered or focused */
            outline: none;
            /* Remove outline on focus */
        }

        /* Style for submit buttons when active (being clicked) */
        input[type="submit"]:active {
            background-color: #3e8e41;
            /* Even darker shade of green when active */
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            /* Add an inset shadow for a "pressed" effect */
        }
    </style>
</head>

<body>
    <h1>Groups</h1>
    <?php
    include 'connectdb.php';
    if (isset($_POST['groupinfo'])) {
        $GroupID = $_POST['groupinfo'];
        $query = $connection->prepare("SELECT RentalGroup.*,
    GROUP_CONCAT(DISTINCT Renter.FirstName, ' ', Renter.LastName SEPARATOR ', ') AS renterNames
    FROM RentalGroup
    JOIN Renter ON RentalGroup.GroupID = Renter.GroupID WHERE RentalGroup.GroupID=:GroupID
    GROUP by RentalGroup.GroupID");

        $query->execute([':GroupID' => $GroupID]);

        if ($row = $query->fetch(PDO::FETCH_ASSOC)) {
            echo "<form action='updateRentalGroup.php' method='post'>";
            echo "<input type='hidden' name='GroupID' value='" . $row["GroupID"] . "'>";
            echo "<input type='hidden' name='AccomodationType' value='" . $row["AccomodationType"] . "'>";
            echo "<input type='hidden' name='PreferredNumBath' value='" . $row["PreferredNumBath"] . "'>";
            echo "<input type='hidden' name='PreferredNumBed' value='" . $row["PreferredNumBed"] . "'>";
            echo "<input type='hidden' name='PreferredLaundry' value='" . $row["PreferredLaundry"] . "'>";
            echo "<input type='hidden' name='PreferredAccessibility' value='" . $row["PreferredAccessibility"] . "'>";
            echo "<input type='hidden' name='ParkingDesired' value='" . $row['ParkingDesired'] . "'>";
            echo "<input type='hidden' name='MaxRent' value='" . $row["MaxRent"] . "'>";

            echo "<table>";
            echo "<tr><th>Attribute</th><th>Value</th></tr>";
            echo "<tr><td>Group ID</td><td>" . $row["GroupID"] . "</td></tr>";
            echo "<tr><td>Member Names</td><td>" . $row['renterNames'] . "</td></tr>";
            echo "<tr><td>Accommodation Type</td><td><input type='text' name='AccomodationType' value='" . $row["AccomodationType"] . "'></td></tr>";
            echo "<tr><td>Preferred Number of Baths</td><td><input type='number' name='PreferredNumBath' value='" . $row["PreferredNumBath"] . "'></td></tr>";
            echo "<tr><td>Preferred Number of Beds</td><td><input type='number' name='PreferredNumBed' value='" . $row["PreferredNumBed"] . "'></td></tr>";
            echo "<tr><td>Preferred Laundry</td><td><input type='text' name='PreferredLaundry' value='" . $row["PreferredLaundry"] . "'></td></tr>";
            echo "<tr><td>Preferred Accessibility</td><td><input type='text' name='PreferredAccessibility' value='" . $row["PreferredAccessibility"] . "'></td></tr>";
            echo "<tr><td>Parking Desired</td><td><input type='text' name='ParkingDesired' value='" . ($row['ParkingDesired'] ? 'Yes' : 'No') . "'></td></tr>";
            echo "<tr><td>Maximum Rent</td><td><input type='text' name='MaxRent' value='" . $row["MaxRent"] . "'></td></tr>";
            echo "</table>";
            echo "<input type='submit' value='Update Group Details'>";
            echo "</form>";
        } else {
            echo "No property found with the specified ID.";
        }

    } else {
        echo "No property selected.";
    }
    ?>
    <a href="RentalGroupList.php">Back to Rental Group List</a>
</body>

</html>