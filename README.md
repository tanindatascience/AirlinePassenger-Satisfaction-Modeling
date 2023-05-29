Taken from Maven Analytics' Data Playground, this data contains feedback scores by airline passengers for various services offered by the airline company with the final feedback - 'Satisfied' or 'Neutral/Dissatisfied' also given by passengers. The main objective is to answer the following questions posed by Maven Analytics.
1. Which percentage of airline passengers are satisfied? 
2. What is the customer profile for a repeating airline passenger?
3. Does flight distance affect customer preferences or flight patterns?
4. What are the features contributing to customer satisfaction the most?

Built data visualizations on MS Power BI post which I built a logit classification model to predict what factors determine a satisfactory travel experience and how accurately can a passenger's feedback be predicted so that the airline can improve its services accordingly. 
Data visualizations on PBI:
![image](https://github.com/tanindatascience/Multivariate-Regression-and-Predictive-Modeling/assets/131387030/1fce2673-f5ac-44ff-be7a-639ed682b983)
![image](https://github.com/tanindatascience/Multivariate-Regression-and-Predictive-Modeling/assets/131387030/51cdf1a9-6dd4-404a-bf4c-26ac8946d15b)
![image](https://github.com/tanindatascience/Multivariate-Regression-and-Predictive-Modeling/assets/131387030/65a45300-d8a8-464a-ad6b-cf01f75293a5)

Results:
1. About 77% of the passengers were ‘Returning’ type of passengers. Of 1.3L passengers, 46% were ‘Business Class travelers, 42% were ‘Economy Class travelers and the remaining were ‘Economy Plus Class travelers. 
2. The binary logit model was built with an accuracy of 88% and a precision of 87.3%:
‘Departure Delay’ and ‘Arrival Delay’ had extremely high VIF values (close to 14) and hence, were dropped. The logit model after dropping these variables had a significantly higher AIC value. Improving the ease of online boarding, their check-in services, on-board services, and their in-flight WiFi service results in an 80%, 37%, 35%, and 50% significant increase in the odds of customers feeling ‘Satisfied’. Cleanliness only led to a 24% increase in getting ‘Satisfied’ feedback and the ‘Personal’ type of travel led to a 93% decrease in the odds of receiving positive customer feedback. 

Recommendation:
The airline company should focus on retaining their economy and economy plus passengers by providing higher quality on-board services, in-flight entertainment, in-flight WiFi service, and easy online boarding services. They have a loyal returning Business travel base and hence, can turn their focus on Personal trip travelers.
