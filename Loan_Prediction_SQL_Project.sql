CREATE TABLE loan_prediction (
   loan_id VARCHAR(20),
   gender VARCHAR(20),
   married VARCHAR(20),
   dependents VARCHAR(10),
   education VARCHAR(30),
   self_employed VARCHAR(20),
   applicantincome NUMERIC,
   coapplicantincome NUMERIC,
   loanamount NUMERIC,
   loan_amount_term NUMERIC,
   credit_history NUMERIC,
   property_area VARCHAR(30),
   loan_status VARCHAR(10),
   total_income NUMERIC,
   loan_to_income_ratio NUMERIC

);

--Step 1: View the Dataset
SELECT *
FROM loan_prediction;

--Explanation: Provides an overall view of the loan application dataset. 

--Step 2: Count Total Loan Applications
SELECT COUNT(*) AS
total_applications
FROM loan_prediction;

--Explanation: Shows the total number of loan applications available for analysis.

--Step 3: Check Unique Loan IDs
SELECT COUNT(DISTINCT loan_id) AS
unique_loan_ids
FROM loan_prediction;

--Explanation: Checks whether each loan application has a unique identifier.

--Step 4: Check Missing Values
SELECT
   COUNT(*) FILTER(WHERE gender
   IS NULL) AS missing_gender,
COUNT(*) FILTER(WHERE married
   IS NULL) AS missing_married,
   COUNT(*) FILTER(WHERE dependents
   IS NULL) AS missing_dependents,
   COUNT(*) FILTER(WHERE education
   IS NULL) AS missing_education,
   COUNT(*) FILTER(WHERE self_employed
   IS NULL) AS missing_self_employed,
   COUNT(*) FILTER(WHERE applicantincome
   IS NULL) AS missing_applicantincome,
   COUNT(*) FILTER(WHERE coapplicantincome
   IS NULL) AS missing_coapplicantincome,
   COUNT(*) FILTER(WHERE loanamount
   IS NULL) AS missing_loanamount,
   COUNT(*) FILTER(WHERE loan_amount_term
   IS NULL) AS missing_loan_amount_term,
   COUNT(*) FILTER(WHERE credit_history
   IS NULL) AS missing_credit_history
FROM loan_prediction;   

--Explanation: Verifies whether important applicant and loan  variables still contain missing values after 
data cleaning.

--Step 5: Loan Approval Distribution
SELECT
   loan_status,
   COUNT(*) AS applications
FROM loan_prediction
GROUP BY loan_status
ORDER BY applications DESC;
   
--Explanation: Shows the number of approved and rejected loan applications.

--Step 6: Overall Loan Approval Rate
SELECT
   ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction;

--Explanation: Calculates the overall percentage of applications that were approved.

--Step 7: Gender-wise Applications
SELECT
   gender,
   COUNT(*) AS applications
FROM loan_prediction
GROUP BY gender
ORDER BY applications DESC;

--Explanation: Shows the distribution of loan applications by gender.

--Step 8: Gender-wise Approval Rate
SELECT
   gender,
   COUNT(*) AS total_applications,
   COUNT(*) FILTER (WHERE
loan_status = 'Y') AS approved,
ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY gender
ORDER BY approval_rate DESC;

--Explanation: Compares loan approval rates between different genders.

--Step 9: Marital Status Analysis
SELECT
   married,
   COUNT(*) AS applications,
  COUNT(*) FILTER (WHERE
loan_status = 'Y') AS approved 
FROM loan_prediction
GROUP BY married
ORDER BY applications DESC;

--Explanation: Analyzes loan applications and approvals based on marital status.

--Step 10: Dependents-wise Approval Rate
SELECT
   dependents,
   COUNT(*) AS applications,
   ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY dependents
ORDER BY approval_rate DESC;

--Explanation: Examines whether the number of dependents is associated with loan approval.

--Step 11: Education-wise Approval Rate
SELECT
   education,
   COUNT(*) AS applications,
   ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY education
ORDER BY approval_rate DESC;

--Explanation: Compares loan approval rates between different education levels.

--Step 12: Self-employed vs Non-Self-employed  
SELECT
    self_employed,
   COUNT(*) AS applications,
   ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY self_employed
ORDER BY approval_rate DESC;

--Explanation: Compares loan approval patterns between self-employed and non-self-employed applicants.

--Step 13: Applicant Income Analysis
SELECT
   ROUND(AVG(applicantincome),2) AS average_income,
   MIN(applicantincome) AS minimum_income,
   MAX(applicantincome) AS maximum_income 
 FROM loan_prediction; 

--Explanation: Summarizes the income range and average income of loan applicants.

--Step 14: Average Income by Loan Status
SELECT
   loan_status,
   ROUND(AVG(applicantincome),2) AS average_applicant_income
    FROM loan_prediction
	GROUP BY loan_status;

--Explanation: Compares the average applicant income between approved and rejected applicants.

--Step 15: Total Income Analysis
SELECT
   loan_status,
   ROUND(AVG(total_income),2) AS average_total_income
    FROM loan_prediction
	GROUP BY loan_status
	ORDER BY average_total_income DESC;

--Explanation: Compares combined applicant and co-applicant income across loan outcomes.

--Step 16: Income Category Analysis
SELECT
   CASE
      WHEN total_income < 5000
THEN 'Low Income'
       WHEN total_income < 10000
THEN 'Medium Income'
        ELSE 'High Income'
	END AS income_category,
	COUNT(*) AS applications,
	ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY income_category
ORDER BY approval_rate DESC;

--Explanation: Compares loan approval rates across different total-income categories.

--Step 17: Average Loan Amount
SELECT
   ROUND(AVG(loanamount),2) AS average_loan_amount,
   MIN(loanamount) AS minimum_loan_amount,
   MAX(loanamount) AS maximum_loan_amount
 FROM loan_prediction; 

--Explanation: Provides an overview of the loan amounts requested by applicants.

--Step 18: Loan Amount by Approval Status
SELECT
   loan_status,
   ROUND(AVG(loanamount),2) AS average_loan_amount
FROM loan_prediction 
GROUP BY loan_status
ORDER BY average_loan_amount DESC;    

--Explanation: Compares the average requested loan amount for approved and rejected applications.

--Step 19: Loan Term Analysis
SELECT
   loan_amount_term,
   COUNT(*) AS applications
FROM loan_prediction 
GROUP BY loan_amount_term
ORDER BY applications DESC;    

--Explanation: Identifies the most common loan repayment terms requested by applicants.

--Step 20: Credit History Distribution
SELECT
   credit_history,
   COUNT(*) AS applications
FROM loan_prediction 
GROUP BY credit_history
ORDER BY applications DESC;    

--Explanation: Shows the distribution of applicants according to their credit history.

--Step 21: Credit History and Approval Rate
SELECT
   credit_history,
   COUNT(*) AS applications,
   COUNT(*) FILTER
		(WHERE loan_status = 'Y') AS approved,
    ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY credit_history
ORDER BY approval_rate DESC;   

--Explanation: Evaluates the relationship between credit history and loan approval, an important factor
in lending decisions.

--Step 22: Property Area Analysis
SELECT
   property_area,
   COUNT(*) AS applications,
       ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY property_area
ORDER BY approval_rate DESC;   

--Explanation: Compares loan approval rates across different property areas.

--Step 23: Loan-to-Income Ratio Analysis

SELECT
   loan_status,
   ROUND(AVG(loan_to_income_ratio),2) AS average_loan_to_income_ratio
FROM loan_prediction 
GROUP BY loan_status
ORDER BY average_loan_to_income_ratio;    

--Explanation: Compares the loan burden relative to income between approved and rejected applicants.

--Step 24: High Loan-to-Income Applicants
SELECT
   COUNT(*) AS
high_ratio_applications
FROM loan_prediction 
WHERE loan_to_income_ratio > 5;

--Explanation: Identifies applicants requesting relatively large loans compared with their total income.

--Step 25: High Loan-to-Income Ratio and Approval
SELECT
   CASE
      WHEN loan_to_income_ratio <= 5
THEN 'Lower Ratio'
              ELSE 'Higher Ratio'
	END AS ratio_category,
COUNT(*) AS applications,
       ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY ratio_category
ORDER BY approval_rate DESC;   

--Explanation: Examines whether higher borrowing relative to income is associated with lower 
loan approval.

--Step 26: Top Applicant Profiles by Income
SELECT  
   loan_id, 
   total_income,      
   loanamount,        
   loan_to_income_ratio,          
   credit_history,      
    loan_status    
FROM loan_prediction
ORDER BY total_income DESC
LIMIT 10;
   
--Explanation: Identifies the highest-income applicants and their corresponding loan characteristics
and outcomes.

--Step 27: High-risk Loan Applications
SELECT  
   loan_id, 
   total_income,      
   loanamount,        
   loan_to_income_ratio,          
   credit_history,      
    loan_status    
FROM loan_prediction
WHERE credit_history = 0
  OR loan_to_income_ratio > 5
ORDER BY loan_to_income_ratio DESC;

--Explanation: Highlights applications with weaker credit history or relatively high loan burden 
for risk analysis.

--Step 28: Combined Applicant Analysis
SELECT
  education,
  self_employed,
  credit_history,
   COUNT(*) AS applications,
       ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY  education, self_employed, credit_history
ORDER BY approval_rate DESC;   

--Explanation: Combines multiple applicant characteristics to identify patterns associated with 
loan approval.

--Step 29: Approval Rate by Multiple Factors
SELECT
    property_area,
	education,
   credit_history,
   COUNT(*) AS applications,
       ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS approval_rate
FROM loan_prediction
GROUP BY property_area,education,credit_history
HAVING COUNT(*) >= 5
ORDER BY approval_rate DESC;   

--Explanation: Provides a deeper comparison of loan approval patterns across property area,education,
 and credit history.

 --Step 30: Final Loan Approval Summary
SELECT
     COUNT(*) AS 
	 total_applications,
	 COUNT(*) FILTER
		(WHERE loan_status = 'Y') AS 
		approved_loans,
		COUNT(*) FILTER
		(WHERE loan_status = 'N') AS 
		rejected_loans,
       ROUND(
        100.0 * COUNT(*) FILTER
		(WHERE loan_status = 'Y') /
		COUNT(*),2
   ) AS overall_approval_rate,
   ROUND(AVG(total_income),2) AS average_total_income,
   ROUND(AVG(loanamount),2) AS average_loan_amount,
   ROUND(AVG(loan_to_income_ratio),2) AS average_loan_to_income_ratio
FROM loan_prediction; 

--Explanation: Summarizes the key loan portfolio metrics and provides an overall view of application
volume, approval performance, income, loan amount, and borrowing burden.









