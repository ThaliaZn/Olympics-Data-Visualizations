# Olympics Data Visualizations
<br><br>

## _Project Overview_

Hey there, let's explore the fascinating world of Olympic data! 
In this project, we delve into the rich history of the Olympic Games from 1896 to 2022. Using data sourced from Kaggle and meticulously cleaned using <b>MySQL</b>, I've crafted a series of captivating visualizations in <b>Tableau</b>. Join me on this journey as we uncover insights into medal achievements, participation trends, and more.
<br><br>

<p align="center">
  <img src= "https://github.com/ThaliaZn/FilesforOtherProjects/blob/79820a9011cd3321776d0cf7308970dcdbe819b0/TrendTrackersImage.png" alt="Project Logo" width="720"/>
</p>

<br><br>

 

## _Data Source_

The original dataset was downloaded from [Kaggle](https://www.kaggle.com/datasets/josephcheng123456/olympic-historical-dataset-from-olympediaorg?select=Olympics_Games.csv). 

It includes three CSV files:

- <b> Olympic_Athlete_Event_Results.csv </b>: Contains data on athletes, events, and medals with over 314,000 rows and columns including olympic editions, country_noc, sports, events, medals, and more.

- <b> Olympic_Games_Medal_Tally.csv </b>: Includes information on medal tallies per edition and country with 1,808 rows and columns such as olympic editions, country_noc, gold, silver, bronze, and total.

- <b> Olympics_Country.csv </b>: Provides a mapping between country_noc and country names with 235 rows. This file is used to link NOC (i.e. National Olympic Committee) with country names for visualization purposes.


<br><br>



## _Directory Structure_

- /Data

  Contains the original CSV files downloaded from Kaggle and the outputs from MySQL after cleaning.

  *Note: The original Olympic_Athlete_Event_Results.csv file is too large to upload directly to GitHub due to GitHub's file size limitations. You can download the file from Kaggle if needed.*
  <br><br>

- /MySQL_code

  Contains the SQL code used for data cleaning in MySQL.<br><br>

- /Visualizations

  Dive into the captivating world of Olympic data visualizations! This folder is home to interactive Tableau dashboards that showcase insights gleaned from the datasets. Explore a variety of dynamic visualizations designed to uncover trends and achievements in Olympic history. Don't miss out on the opportunity to navigate through these 3 informative dashboards and gain deeper insights into the fascinating realm of Olympic data exploration.


<br><br>



## _Visualization_

### [Tableau Dashboards](https://public.tableau.com/views/ExploringOlympicDataDynamics_17091485158530/MedalMarvels-Achievements?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)   


#### 1. Medal Marvels - Achievements
Dive into the dynamic realm of Olympic medal achievements! The visualizations include:

- Medal Density Map - Global Performance: Explore the distribution of Olympic medals across countries.
- Medals of Former/No Flag Countries: Discover the medal counts for countries that no longer exist or lack an official flag.
- Top 10 Medalists across Olympic Events: Witness the top medalists dynamically change by year and season.<br><br>

#### 2. Trend Trackers
Uncover intriguing trends in Olympic participation with these visualizations:

- Gender Distribution in Participation Over Time: Witness the evolution of gender distribution in Olympic participation from 1896 till today.
- Number of Countries Attending Olympic Events Over Time: Track the participation of countries over the years, with a parameter for summer/winter seasons.
- Athlete Distribution in Sports: Explore the distribution of athletes across different sports, with a parameter for summer/winter seasons.
- Nations' Engagement in Team Sports: Gain insights into countries' engagement in team sports.<br><br>

#### 3. Olympics By the Numbers
Delve into statistical insights with these visualizations:

- Top Countries in Olympic Medals: See how the top medal-winning countries evolve over the years.
- Top Countries with Most Appearances in Olympics: Visualize countries with the most appearances in the Olympics and their participation in the Winter Olympics.
- Athlete Participation Over Time: Explore the trend of athlete participation across Olympic editions.
- Athlete Participation Trend Over Time: Analyze the fluctuation in athlete participation compared to previous events, with a parameter for summer/winter seasons.



<br><br>



## _Acknowledgments_

Special thanks to Joseph Cheng and Kaggle for providing the comprehensive Olympic Games dataset, which served as the backbone of this project. 
Additionally, gratitude to the Tableau and MySQL communities for their invaluable resources and support in visualizing and analyzing the data.

Background images used in visualizations courtesy of Adobe Stock.

This README provides an overview of the project. For a closer look at the visualizations and insights, please refer to the respective files in the repository.


<br><br>



## _Contributions_

Feel free to explore the code and visuals. Feedback and suggestions are always welcome!
