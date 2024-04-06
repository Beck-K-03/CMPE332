<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Rental Company</title>
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
    <?php
    include 'connectdb.php'

        ?>
    <h1>Welcome to Beck's Land Management Company</h1>
    <img src="https://media.istockphoto.com/id/637457706/photo/sagging-abandon-house.jpg?s=612x612&w=0&k=20&c=1JszCJcQhOtkawYdm64lZSQ6zozLk9Y3JrO8otDJVWk="
        alt="A beautiful landscape">
    <h2>Properties We Manage</h2>
    <form action="getPropertyDetails.php" method="post">
        <?php
        include 'getdata.php';
        ?>
        <input type="submit" value="Get Detailed Selected Property Info">
    </form>
    <br>
    <form action="RentalGroupList.php" method="post">
        <?php

        ?>
        <input type="submit" value="Link To Rental Group Page">
    </form>
    <?php
    $connection = NULL;
    ?>
</body>

</html>