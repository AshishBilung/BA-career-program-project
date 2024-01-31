--1.Create a table “Station” to store in formation about weather observation stations:

Create table Station (ID Int, City char(20),
State char(2), Lat_n Int, Long_w Int, Primary key(ID));

--2.Insert the following records into the table:

Insert into Station(ID, City, State, Lat_n, Long_w)values('13','Phoenix','AZ','33','112');
Insert into Station(ID, City, State, Lat_n, Long_w)values('44','Denver','CO','40','105');
Insert into Station(ID, City, State, Lat_n, Long_w)values('66','Caribou','ME','47','68');

--3.Execute a query to look at table STATION in undefined order.

Select * from Station;

--4.Execute a query to select Northern stations(Northern latitude > 39.7).

Select * from Station
where Lat_n > 39.7;

--5.Create another table, ‘STATS’, to store normalized temperature and precipitation data:

Create Table Stats(ID int, Month int, Temp_F Decimal(3,1), Rain_I Decimal(3,2), Foreign key(ID) References Station(ID));

--6.Populate the table STATS with some statistics for January and July:

Insert into Stats(ID, Month, Temp_F, Rain_I)Values('13','1','57.4','.31');
Insert into Stats(ID, Month, Temp_F, Rain_I)Values('13','7','91.7','5.15');
Insert into Stats(ID, Month, Temp_F, Rain_I)Values('44','1','27.3','.18');
Insert into Stats(ID, Month, Temp_F, Rain_I)Values('44','7','74.8','2.11');
Insert into Stats(ID, Month, Temp_F, Rain_I)Values('66','1','6.7','2.1');
Insert into Stats(ID, Month, Temp_F, Rain_I)Values('66','7','65.8','4.52');

--7.Execute a query to display temperature stats(from STATS table) for each city(from Station table).

Select City, Month,Temp_F from Station S1
join Stats S2
on S1.ID = S2.ID;

--8.Execute a query to look at the table STATS, ordered by month and greatest rainfall, 
with columns rearranged. It should also show the corresponding cities.

Select S2.ID, City, Month, Temp_F, Rain_I from Stats S2
join Station S1
on S2.ID = S1.ID
order by Rain_I desc;

--9.Execute a query to look at temperatures for July from table STATS, lowest temperatures first, picking up city name and latitude.

Select S2.ID, City, lat_n, Month, Temp_F from Stats S2
join Station S1
on S2.ID = S1.ID
Where Month = 7
Order by Temp_F Asc;

--10.Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.

Select City, Round(Avg(Rain_I),1) Avg_Rain, Max(Temp_F), Min(Temp_F) from Stats S2
Join Station S1
on S2.ID = S1.ID
Group by City;

--11.Execute a query to display each city’s monthly temperature in Celcius and rainfall in Centimeter.

Select City, Round((Temp_F-32)*5/9,2) Temp_celcius, Round(Rain_I*2.54,2) Rain_Centimeter from Stats S2
join Station S1
on S2.ID = S1.ID;

--12.Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low.

Update Stats set Rain_I = Rain_I+0.01;
Select*from Stats;

--13.Update Denvers July temperature reading as 74.9.

Update Stats set Temp_F = 74.9
Where Rain_I = 2.11;
