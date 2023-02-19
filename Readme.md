# Create an extension for PostgreSQL

# The result is as follows
<img src="images/advanced database_Li Yuan_120210970.png" width=500px />


# Table of contents

Why create extensions for databases?

What are database native types?

Benefits of database native types?

Create a plugin\(add new native types for postgresql)?

# Why create an extension for the database?

Generally speaking, we create extensions for the database to support some data types or index types that the database does not support, <span style="color:#FF0000">to achieve unified management and efficient processing of data. </span>

Such as unified management of spatial data and attribute data (postgis)

Such as the unified management of large image data and attribute data (PostPic)

And other index plugins for efficient processing, which will not be discussed here.

# What is a database native type?

The database provides specific underlying support for <span style="color:#FF0000">a specific type of processing, representation, storage, and conversion</span>, rather than developing new types or combinations based on the original data of the database. (my understanding)

# What are the benefits of database native types?

1\. Although there are complex database mechanisms that can guarantee user-defined database types and specific functions, these user-defined types have many limitations, such as <span style="color:#FF0000"> __ can not be customized corresponding to the type Complex functions, such as hash functions, cannot customize the index, and the data type can only be a combination (that is, a subset) of existing types__ </span> <span style="color:#FF0000">__…__</ span>

2\. In order to realize _type customization, multiple types of warehousing and unified data management, as well as fast processing of some data and algorithm customization (database index customization), many people develop plug-ins to introduce third-party native database types. _

# Benefits of native database types (personal experience)

<span style="color:#0000FF">CREATE</span> <span style="color:#0000FF">OR</span> <span style="color:#795E26">REPLACE</span> <span style="color:#0000FF">FUNCTION</span> <span style="color:#545454">loopinsert</span> <span style="color:#545454">70</span> <span style= "color:#545454">\(</span>

<span style="color:#545454">n</span> <span style="color:#0000FF">INTEGER</span> <span style="color:#545454">DEFAULT</span> <span style="color:#098658">70</span>

<span style="color:#545454">\)</span>

<span style="color:#0000FF">RETURNS</span> <span style="color:#545454">VOID</span> <span style="color:#0000FF">AS</span> <span style="color:#545454">$$</span>

<span style="color:#0000FF">DECLARE</span>

<span style="color:#545454">rec RECORD;</span>

<span style="color:#0000FF">counter</span> <span style="color:#0000FF">INTEGER</span> <span style="color:#545454">:=</span> < span style="color:#098658">0</span> <span style="color:#545454">;</span>

<span style="color:#0000FF">BEGIN</span>

<span style="color:#545454">FOR rec</span> <span style="color:#0000FF">IN</span> <span style="color:#0000FF">select</span> < span style="color:#545454">\*</span> <span style="color:#0000FF">from</span> <span style="color:#545454">beijingPOI</span>

<span style="color:#0000FF">LOOP</span>

<span style="color:#0000FF">insert</span> <span style="color:#0000FF">into</span> <span style="color:#545454">ss30</span>

<span style="color:#0000FF">select</span> <span style="color:#545454">rec\.id</span> <span style="color:#0000FF">as</span > <span style="color:#545454">id\,</span> <span style="color:#545454">rec\.type</span> <span style="color:#0000FF">as </span> <span style="color:#0000FF">type</span> <span style="color:#545454">\,</span> <span style="color:#795E26">string\ _agg</span> <span style="color:#545454">\(</span> <span style="color:#545454">shit\.type</span> <span style="color:#545454 ">\,</span> <span style="color:#A31515">';'</span> <span style="color:#545454">\)</span> <span style="color: #0000FF">as</span> <span style="color:#545454">contexttype\,array\_to\_string</span> <span style="color:#545454">\(</span> < span style="color:#545454">array\_agg</span> <span style="color:#545454">\(</span> <span style="color:#545454">shit\.dis< /span> <span style="color:#545454">\)\,</span> <span style="color:#A31515">'\,'</span> <span style="color:#545454 ">\,</span> <span style="colo r:#A31515">'\*'</span> <span style="color:#545454">\)</span> <span style="color:#0000FF">as</span> <span style ="color:#545454">dis</span> <span style="color:#0000FF">from</span>

<span style="color:#545454">\(</span> <span style="color:#0000FF">select</span> <span style="color:#545454">a\.type</span> span> <span style="color:#0000FF">as</span> <span style="color:#0000FF">type</span> <span style="color:#545454">\, \(< /span> <span style="color:#545454">a\.geodata</span> <span style="color:#545454">\<\-></span>

<span style="color:#545454">\(</span> <span style="color:#0000FF">select</span> <span style="color:#545454">geodata</span> < span style="color:#0000FF">from</span> <span style="color:#545454">wuhuanpoi</span> <span style="color:#0000FF">where</span> <span style ="color:#545454">id =</span> <span style="color:#545454">rec\.id</span> <span style="color:#545454">\)\)</ span> <span style="color:#0000FF">as</span> <span style="color:#545454">dis</span>

<span style="color:#0000FF">from</span> <span style="color:#545454">wuhuanpoi</span> <span style="color:#0000FF">as</span> <span style="color:#545454">a</span>

<span style="color:#0000FF">where</span> <span style="color:#545454">a\.id</span> <span style="color:#545454">\!=< /span> <span style="color:#545454">rec\.id</span>

<span style="color:#0000FF">order by</span> <span style="color:#545454">dis</span>

<span style="color:#0000FF">limit</span> <span style="color:#545454">n\)</span> <span style="color:#0000FF">as</span> <span style="color:#545454">shit ;</span>

<span style="color:#0000FF">counter</span> <span style="color:#545454">:=</span> <span style="color:#0000FF">counter</span> < span style="color:#545454">\+</span> <span style="color:#098658">1</span> <span style="color:#5
\
