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
    <form action="getRentalGroup.php" method="post">
        <?php
        include 'connectdb.php';
        $result = $connection->query("SELECT * from RentalGroup");


        echo "<table border='1'>";
        echo "<tr>
        <th>Select</th>
        <th>Group ID</th>
        </tr>";

        while ($row = $result->fetch()) {
            echo "<tr>";
            echo '<td><input type="radio" name="groupinfo" value="' . $row["GroupID"] . '"></td>';
            echo "<td>" . $row["GroupID"] . "</td>";
        }
        echo "</table>";
        ?>
        <input type="submit" value="Selected Groups Information">
    </form>


    <a href="rental.php">Back to Property List</a>
</body>

</html>