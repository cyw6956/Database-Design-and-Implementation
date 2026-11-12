--question1
SELECT quantityOnHand
FROM item
WHERE itemDescription LIKE '%antibiotics%';
--question2
SELECT volunteerName
FROM volunteer
WHERE volunteerTelephone NOT LIKE '2%' AND volunteerName NOT LIKE '%Jones';
--question3
SELECT volunteerName
FROM volunteer
JOIN assignment
ON volunteer.volunteerId = assignment.volunteerId
JOIN task
ON assignment.taskCode = task.taskCode
JOIN task_type
ON task.taskTypeId = task_type.taskTypeId
WHERE taskTypeName = 'transporting';
--question4
SELECT taskDescription
FROM task
JOIN assignment
ON task.taskCode = assignment.taskCode
WHERE task.taskCode IS NULL;
--question5
SELECT DISTINCT packageTypeName
FROM package_type
JOIN package
ON package_type.packageTypeId = package.packageTypeId
JOIN package_contents
ON package.packageId = package_contents.packageId
JOIN item
ON package_contents.itemId = item.itemId
WHERE itemDescription LIKE '%bottle%';
--question6
SELECT 
item.itemDescription
FROM item
LEFT JOIN package_contents 
ON item.itemId = package_contents.itemId
WHERE 
package_contents.itemId IS NULL;
--question7
SELECT DISTINCT taskDescription
FROM task
JOIN assignment
ON task.taskCode = assignment.taskCode
JOIN volunteer
ON assignment.volunteerId = volunteer.volunteerId
WHERE volunteerAddress LIKE '%NJ%';
--question8
SELECT volunteerName
FROM volunteer
JOIN assignment ON volunteer.volunteerId = assignment.volunteerId
WHERE assignment.startDateTime >= '2021-01-01' AND assignment.startDateTime < '2021-07-01';
--question9
SELECT DISTINCT volunteerName
FROM volunteer
JOIN assignment 
ON volunteer.volunteerId = assignment.volunteerId
JOIN task
ON assignment.taskCode = task.taskCode
JOIN package
ON task.taskCode = package.taskCode
JOIN package_contents
ON package.packageId = package_contents.packageId
JOIN item
ON package_contents.itemId = item.itemId
WHERE item.itemDescription LIKE '%spam%';
--question10
SELECT itemDescription
FROM item
JOIN package_contents
ON item.itemId = package_contents.itemId
WHERE (item.itemValue * package_contents.itemQuantity) = 100;
--question11
SELECT 
    ts.taskStatusName,
    COUNT(DISTINCT a.volunteerId) AS volunteerCount
FROM task_status ts
LEFT JOIN task t ON ts.taskStatusId = t.taskStatusId
LEFT JOIN assignment a ON t.taskCode = a.taskCode
GROUP BY ts.taskStatusId, ts.taskStatusName
ORDER BY volunteerCount DESC;
--question12
SELECT 
    taskCode,
    SUM(package.packageWeight) AS totalWeight
FROM package
GROUP BY taskCode
ORDER BY totalWeight DESC LIMIT 1;
--question13
SELECT COUNT(*)
FROM task
JOIN task_type
ON task.taskTypeId = task_type.taskTypeId
WHERE taskTypeName NOT LIKE 'packing';
--question14
SELECT itemDescription
FROM item
JOIN package_contents
ON item.itemId = package_contents.itemId
JOIN package
ON package_contents.packageId = package.packageId
LEFT JOIN task
ON package.taskCode = task.taskCode
LEFT JOIN assignment
ON task.taskCode = assignment.taskCode
GROUP BY item.itemId, item.itemDescription HAVING COUNT(DISTINCT assignment.volunteerId) < 3;
--question15
SELECT 
    package.packageId,
    SUM(package_contents.itemQuantity * item.itemValue) AS totalValue
FROM package
JOIN package_contents
ON package.packageId = package_contents.packageId
JOIN item
ON package_contents.itemId = item.itemId
GROUP BY package.packageId HAVING SUM(package_contents.itemQuantity * item.itemValue) > 100
ORDER BY totalValue ASC;
