**AIRLINE PASSENGER SATISFACTION FEEDBACK: EDA & LOGIT MODEL**

Customer satisfaction scores from 120,000+ airline passengers, including additional information about each passenger, their flight, and type of travel, as well as ther evaluation of different factors like cleanliness, comfort, service, and overall experience.

Taken from Maven Analytics' Data Playground, this data contains feedback scores by airline passengers for various services offered by the airline company with the final feedback - 'Satisfied' or 'Neutral/Dissatisfied' also given by passengers. The main objective is to answer the following questions posed by Maven Analytics.
1. Which percentage of airline passengers are satisfied? 
2. What is the customer profile for a repeating airline passenger?
3. Does flight distance affect customer preferences or flight patterns?
4. What are the features contributing to customer satisfaction the most?

**DATA DICTIONARY**
1. ID: Unique customer ID
2. Gender: Male/Female
3. Age: Integer values
4. Customer Type: First time travelers or returning travelers
5. Type of Travel: Business or Leisure
6. Class: Business, Economy or Economy Plus
7. Flight Distance, Departure Delay and Arrival Delay: All 3 are integer values
8. All other categorical variables including 'Satisfaction', 'Check-In Service' etc.: These are marked on a scale of 0 to 5 with 0 being the worst feedback given by a passenger and 5 being the best.

**TASK AT-HAND**
Built data visualizations on MS Power BI post which I built a logit classification model to predict what variables determine a satisfactory travel experience and how accurately can a passenger's feedback be predicted so that the airline can improve its services accordingly. 

Data visualizations on MS Power BI:

![image](https://github.com/tanindatascience/Multivariate-Regression-and-Predictive-Modeling/assets/131387030/1fce2673-f5ac-44ff-be7a-639ed682b983)

![image](https://github.com/tanindatascience/Multivariate-Regression-and-Predictive-Modeling/assets/131387030/51cdf1a9-6dd4-404a-bf4c-26ac8946d15b)

![image](https://github.com/tanindatascience/Multivariate-Regression-and-Predictive-Modeling/assets/131387030/65a45300-d8a8-464a-ad6b-cf01f75293a5)

**RESULTS**

1. About 77% of the passengers were ‘Returning’ type of passengers. Of 1.3L passengers, 46% were 'Business Class' travellers, 42% were 'Economy Class' travellers and the remaining were 'Economy Plus Class' travellers. 

2. The binary logit model was built with an accuracy of 88% and a precision of 87.3%:
‘Departure Delay’ and ‘Arrival Delay’ had extremely high VIF values (close to 14) and hence, were dropped. The logit model after dropping these variables had a significantly lower AIC value. Improving the ease of online boarding, their check-in services, on-board services, and their in-flight WiFi service results in an 80%, 37%, 35%, and 50% significant increase in the odds of customers feeling ‘Satisfied’. Cleanliness only led to a 24% increase in getting ‘Satisfied’ feedback and the ‘Personal’ type of travel led to a 93% decrease in the odds of receiving positive customer feedback. 

**RECOMMENDATION**:
The airline company should focus on retaining their economy and economy plus passengers by providing higher quality on-board services, in-flight entertainment, in-flight WiFi service, and easy online boarding services. They have a loyal returning Business travel base and hence, can turn their focus on Personal trip travellers.
A point to be noted here is that business class travellers usually are of the 'Returning' type since they have to frequently travel. Hence, it is likely that they will form the majority of the 'Returning' class. The airline can move its focus and perform a cost analysis to understand the leverage it could potentially have over other airlines for attracting and retaining economy and economy-plus passengers. 
Providing cheaper tickets might not be the precise solution since that will lead to further losses and there will always be another airline that could provide much cheaper tickets by using the advantage of more accessibility to tier-3 cities etc. Thus, a cost analysis at this stage will provide further insights into the quality of services provided to the said passengers. The cost analysis will open further scope for deep-diving into quality control checks on particular services that passengers prefer with this airline over others - which also leads me to suggest a competitor analysis to check where this airline stands with its ticket prices and quality of customer service.
