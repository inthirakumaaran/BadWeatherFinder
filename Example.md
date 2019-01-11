##Example


**This is the sample queries to travel from dehiwala to palm grove**

--------------------------------------------------------------------
*Type the start and end points*
> Enter startAddress: dehiwala  
> Enter destination: palm grove, kollupittiya
--------------------------------------------------------------------
*Select the mode of travel available for route calculation in those points*
>Select the mode from  
>["DRIVING", "WALKING"]  
>Enter Mode: driving
--------------------------------------------------------------------

*Output prediction will have weather summary for no of routes 
available in google direction api*
>For route 1 through Colombo Plan Rd

>enjoy happy journey in nice day. With expected journey time of 30 mins

*Above travel points have only one route in direction api*

--------------------------------------------------------------------
*We can delay the journey in mins,hours and days. Usually we will calculate
the prediction from the current time*

>Do you want to delay the travel?(yes or no): yes  
>Enter delay mins :  30  
>Enter delay hours :  8  
>Enter delay days :  0  

*This will lead to new prediction for that route*
>For route 1 through Colombo Plan Rd

>In the travel-time 100% will be rainny. With expected journey time of 30 mins

--------------------------------------------------------------------
*We can exit the program by saying no to delay query*
>Do you want to delay the travel?(yes or no): no  

>End of Weather Prediction  

--------------------------------------------------------------------
*If the google api cannot find a route, it will 
show the bellow response. We can avoid this by giving more specific 
travel points*
>Enter startAddress: dehiwala  
>Enter destination: palm grove  

>Select the mode from  
>["DRIVING", "WALKING"]  
>Enter Mode: driving  
>NO routes is selected. Please enter more specific address  
>Enter startAddress:  

--------------------------------------------------------------------
*Following will happen if we input wrong queries*
 
>Do you want to delay the travel?(yes or no): yes  
>Enter delay mins : 
>Enter delay hours :   
>Enter delay days :  
>enter time properly  


>Do you want to delay the travel?(yes or no): yes  
>Enter delay mins :  hi  
>Enter delay hours :  hello  
>Enter delay days :  
>enter time properly  

>Do you want to delay the travel?(yes or no): hi  
>enter yes or no properly


