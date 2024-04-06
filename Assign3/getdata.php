<?php
$result = $connection->query("SELECT RentalProperty.*, PropertyManager.FirstName AS ManagerFirstName, PropertyManager.LastName AS ManagerLastName,
GROUP_CONCAT(DISTINCT Owner.FirstName, ' ', Owner.LastName SEPARATOR ', ') AS OwnerNames 
FROM RentalProperty
JOIN PropertyManager ON RentalProperty.ManagerID = PropertyManager.ManagerID
JOIN OwnerProperty ON RentalProperty.PropertyID = OwnerProperty.PropertyID
JOIN Owner ON OwnerProperty.OwnerID = Owner.OwnerID
GROUP BY RentalProperty.PropertyID, PropertyManager.FirstName, PropertyManager.LastName");

echo "Select Rental Property For Detailed Info On Property<br/>";

echo "<table border='1'>";

echo "<tr>
        <th>Select</th>
        <th>Property ID</th>
        <th>Type</th>
        <th>Cost Per Month</th>
        <th>Manager Name</th>
        <th>Owner Names</th>
      </tr>";

while ($row = $result->fetch()) {
  echo "<tr>";
  echo '<td><input type="radio" name="propertyinfo" value="' . $row["PropertyID"] . '"></td>';
  echo "<td>" . $row["PropertyID"] . "</td>";
  echo "<td>" . $row["Type"] . "</td>";
  echo "<td>$" . $row["CostPerMonth"] . "</td>";
  echo "<td>" . $row["ManagerFirstName"] . " " . $row["ManagerLastName"] . "</td>";
  echo "<td>" . $row["OwnerNames"] . "</td>";
  echo "</tr>";
}
echo "</table>";

$avgRentQuery = "SELECT Type, AVG(CostPerMonth) AS AverageRent
FROM RentalProperty
GROUP BY Type";

$avgResult = $connection->query($avgRentQuery);
echo "<table border='1'>";
echo "<tr><th>Type of Unit</th><th>Average Monthly Rent</th></tr>";
while ($avgRow = $avgResult->fetch(PDO::FETCH_ASSOC)) {
  echo "<tr>";
  echo "<td>" . htmlspecialchars($avgRow['Type']) . "</td>";
  echo "<td>$" . number_format((float) $avgRow['AverageRent'], 2) . "</td>";
  echo "</tr>";
}


?>