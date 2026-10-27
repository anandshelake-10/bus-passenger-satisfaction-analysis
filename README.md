<h1 align="center">Passenger Satisfaction Analysis</h1>
<p align="center"><b>Service quality survey for a regional bus operator, analyzed with MySQL and Excel</b></p>

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" alt="Excel">
  <img src="https://img.shields.io/badge/Google_Forms-673AB7?style=for-the-badge" alt="Google Forms">
  <img src="https://img.shields.io/badge/Respondents-104-1F3864?style=for-the-badge" alt="104 respondents">
</p>

---

## Table of Contents
- [Overview](#overview)
- [At a Glance](#at-a-glance)
- [Workflow](#workflow)
- [Dataset](#dataset)
- [Key Findings](#key-findings)
- [SQL Analysis](#sql-analysis)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [Repository Structure](#repository-structure)
- [How to Run](#how-to-run)
- [Skills Demonstrated](#skills-demonstrated)
- [Author](#author)

## Overview
This MBA field project studies how passengers of a regional bus operator in
the Bhoom and Dharashiv area experience the service. A structured survey
collected opinions on punctuality, bus condition, crowding, staff behavior,
pricing, booking and overall satisfaction. The responses were cleaned in
Excel, queried in MySQL, and summarized into findings and practical
recommendations.

**Business question:** where is the service falling short, and what should
the operator improve first to raise satisfaction and retain passengers?

## At a Glance

| Respondents | Survey fields | Want online booking | Satisfied or very satisfied |
|:-----------:|:-------------:|:-------------------:|:---------------------------:|
| **104** | **22** | **85.6%** | **54.8%** |

## Workflow

```mermaid
flowchart LR
    A[Google Forms survey] --> B[Excel: clean and organize]
    B --> C[MySQL: filter, group, summarize]
    C --> D[Excel: tables and charts]
    D --> E[Findings and recommendations]
```

## Dataset
- **Source:** primary survey collected with Google Forms
- **Sample:** 104 passengers, convenience sampling
- **Coverage:** demographics, travel habits, booking and payment
  preferences, 8 service-quality ratings and overall satisfaction
- **Privacy:** passenger names were removed and replaced with anonymous
  IDs (R001 to R104)

<details>
<summary><b>View the data dictionary</b></summary>

| Column | Description |
|--------|-------------|
| Respondent_ID | Anonymous ID |
| Age | Below 18, 18 - 25, 26 - 35, 36 - 50, Above 50 |
| Gender | Male, Female |
| Occupation | Student, Private sector employee, Government employee, Business, Homemaker, Other |
| Monthly_Income | Five income bands |
| Travelling | Travel frequency (Daily to Rarely) |
| Time_preference | Morning or Night |
| Online_Booking_Preference | Wants online ticket booking (Yes/No) |
| Way_of_payment | Cash, Online Payment, Through Agent |
| Factor_influence | Factors behind operator choice (multi-select) |
| Awareness_Other_Operators | Aware of other operators (Yes/No) |
| Comparison_with_other | Much Better to Much Worse |
| Bus_Condition, Punctuality, Staff_Behavior, Ticket_Pricing, Booking_process | Very Poor to Excellent |
| Delays_Frequency | Never to Very often |
| Overcrowded | Rarely to Always |
| Route_Satisfaction, Overall_Satisfaction | Very Dissatisfied to Very Satisfied |
| Understanding_needs | Company understands passenger needs (Yes/No) |

</details>

## Key Findings

### Who the passengers are
| Segment | Result |
|---------|--------|
| Age | 18-25 is the largest group (48.1%), followed by above 50 (18.3%) |
| Gender | 58.7% male, 41.3% female |
| Occupation | Students 34.6%, private sector employees 28.8%, government employees 15.4% |
| Travel frequency | Occasionally 28.8%, rarely 26.0%, daily only 7.7% |

### How they travel and book
- **Night travel is preferred:** 55.8% choose night over morning (44.2%)
- **Strong demand for online booking:** 89 of 104 passengers (85.6%) want it
- **Payment:** online 51.0%, cash 34.6%, through an agent 14.4%
- **Against competitors:** 59.6% rate the operator better or much better,
  19.2% worse or much worse

### Where service falls short
Share of respondents rating each area Poor or Very Poor (crowding: Often or
Always; route: Dissatisfied or Very Dissatisfied):

```
Overcrowding (Often/Always)   ███████████████████████  46.2%
Punctuality                   █████████████████        34.6%
Bus condition                 ████████████████         31.7%
Staff behavior                ████████████████         31.7%
Booking process               ███████████████          29.8%
Ticket pricing                ██████████████           28.8%
Route satisfaction            █████████████            26.9%
```

### Overall satisfaction
```
Very Satisfied      ███████████              21.2%
Satisfied           █████████████████        33.7%
Neutral             █████████████            26.9%
Dissatisfied        ██████                   11.5%
Very Dissatisfied   ███                       6.7%
```
More than half (54.8%) are satisfied, but 45.2% are neutral or dissatisfied,
so there is clear room to improve. 67.3% feel the company understands
passenger needs.

## SQL Analysis
All queries are in [`sql/Passenger_Survey.sql`](sql/Passenger_Survey.sql).
They cover areas of improvement, online booking preference, travel-time
preference, age distribution, payment methods, factors influencing choice
and overall satisfaction.

**Example: overall satisfaction with percentage share**
```sql
SELECT Overall_Satisfaction,
       COUNT(*) AS Total_Respondents,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Passenger_Survey) AS Percentage
FROM Passenger_Survey
GROUP BY Overall_Satisfaction
ORDER BY Percentage DESC;
```

| Overall_Satisfaction | Total_Respondents | Percentage |
|----------------------|:-----------------:|:----------:|
| Satisfied | 35 | 33.7 |
| Neutral | 28 | 26.9 |
| Very Satisfied | 22 | 21.2 |
| Dissatisfied | 12 | 11.5 |
| Very Dissatisfied | 7 | 6.7 |

**Example: passengers unhappy with punctuality**
```sql
SELECT Respondent_ID, Gender, Punctuality
FROM Passenger_Survey
WHERE Punctuality IN ('Poor', 'Very Poor');   -- returns 36 respondents
```

## Recommendations

| Recommendation | Evidence from the survey |
|----------------|--------------------------|
| Improve punctuality and communicate delays clearly | 34.6% rate punctuality Poor or Very Poor |
| Upgrade bus maintenance and cleanliness | 31.7% rate bus condition Poor or Very Poor |
| Add capacity, especially at night, to reduce crowding | 46.2% report crowding Often or Always; 55.8% prefer night travel |
| Launch online or app-based booking with digital-payment offers | 85.6% want online booking; 51.0% already pay online; 29.8% rate the booking process Poor or Very Poor |
| Train staff in customer service | 31.7% rate staff behavior Poor or Very Poor |
| Review fares against service quality | 28.8% rate pricing Poor or Very Poor |
| Expand route coverage based on demand | 26.9% are dissatisfied with route options |
| Run regular feedback surveys (Google Forms or SMS) | 32.7% feel the company does not understand passenger needs |

## Limitations
- Small convenience sample (104) from one region, so results may not
  represent all passengers
- Opinions are self-reported
- "Factors influencing choice" was a multi-select question stored as
  combined text, so counts are by combination, not by individual factor

## Repository Structure
```
bus-passenger-satisfaction-analysis/
├── data/
│   ├── Passenger_Survey_Data.csv
│   └── Passenger_Survey.xlsx
├── sql/
│   └── Passenger_Survey.sql
├── report/
│   └── Passenger_Survey_Project_Report.pdf
└── README.md
```

## How to Run
1. Open MySQL Workbench and run the first two lines of
   `sql/Passenger_Survey.sql` to create and select the `google_form`
   database.
2. Right-click the `google_form` schema, choose **Table Data Import Wizard**,
   and import `data/Passenger_Survey_Data.csv` as a new table named
   `passenger_survey`.
3. Run the remaining queries one by one.

## Skills Demonstrated
Survey design and data collection · Data cleaning in Excel · SQL (filtering,
grouping, aggregation, subqueries) · Descriptive statistics · Insight
generation and business recommendations

## Author
**[Anand Shelake]**
[LinkedIn](https://www.linkedin.com/in/your-profile) ·
[GitHub](https://github.com/your-username)

*Respondent names were removed to protect privacy. Data was collected for
academic research.*
