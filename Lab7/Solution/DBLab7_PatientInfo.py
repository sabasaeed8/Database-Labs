from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from google.cloud import bigquery
from google.oauth2 import service_account
credentials = service_account.Credentials.from_service_account_file(
'project2-db-342508-68107c3ae178.json')


client = bigquery.Client(credentials= credentials,project=credentials.project_id)

print('############################## Query5a ##############################')
# Total number of in-patients in all medical centers
query_5a = client.query("""
   SELECT
  SUM(Total_Inpatient) AS Total_inpatients
FROM (
  SELECT
    SUM(a.total_discharges) AS Total_Inpatient
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2011`a
  WHERE
    a.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(b.total_discharges) AS Total_Inpatient
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2012`b
  WHERE
    b.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(c.total_discharges) AS Total_Inpatient
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2013`c
  WHERE
    c.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(d.total_discharges) AS Total_Inpatient
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2014`d
  WHERE
    d.drg_definition LIKE '%RENAL FAILURE%' )
 """)

results_5a = query_5a.result() 
q5a = 0;
for i in results_5a:
    print(i[0])
    q5a = str(i[0])
    
print("")
print('############################## Query5b ##############################')
# Total number of outpatients in all medical centers
query_5b = client.query("""
   SELECT
  SUM(Total_outpatient) AS Total_outpatients
FROM (
  SELECT
    SUM(a.outpatient_services) AS Total_outpatient
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2011`a
  WHERE
    a.apc LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(b.outpatient_services) AS Total_outpatient
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2012`b
  WHERE
    b.apc LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(c.outpatient_services) AS Total_outpatient
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2013`c
  WHERE
    c.apc LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(d.outpatient_services) AS Total_outpatient
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2014`d
  WHERE
    d.apc LIKE '%RENAL FAILURE%' )
LIMIT
  20
 """)

results_5b = query_5b.result() 
q5b = 0;
for i in results_5b:
    print(i[0])
    q5b = str(i[0])
   
print("")
print('############################## Query5c ##############################')
# Total average amount paid to inpatients
query_5c = client.query("""
   SELECT
  SUM(Total_avgAmount_Inpatient) AS Total_avgAmount_Inpatient
FROM (
  SELECT
    SUM(a.average_total_payments) AS Total_avgAmount_Inpatient
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2011`a
  WHERE
    a.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(b.average_total_payments) AS Total_avgAmount_Inpatient
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2012`b
  WHERE
    b.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(c.average_total_payments) AS Total_avgAmount_Inpatient
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2013`c
  WHERE
    c.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(d.average_total_payments) AS Total_avgAmount_Inpatient
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2014`d
  WHERE
    d.drg_definition LIKE '%RENAL FAILURE%' )
 """)

results_5c = query_5c.result() 
q5c = 0;
for i in results_5c:
    print(i[0])
    q5c = str(i[0])

print("")
print('############################## Query5d ##############################')
# Total average paid to outpatients.
query_5d = client.query("""
   SELECT
  SUM(Total_avgAmount_outpatient) AS Total_avgAmount_outpatient
FROM (
  SELECT
    SUM(a.average_total_payments) AS Total_avgAmount_outpatient
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2011`a
  WHERE
    a.apc LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(b.average_total_payments) AS Total_avgAmount_outpatient
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2012`b
  WHERE
    b.apc LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(c.average_total_payments) AS Total_avgAmount_outpatient
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2013`c
  WHERE
    c.apc LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    SUM(d.average_total_payments) AS Total_avgAmount_outpatient
  FROM
    `bigquery-public-data.cms_medicare.outpatient_charges_2014`d
  WHERE
    d.apc LIKE '%RENAL FAILURE%' )
LIMIT
  20 
 """)

results_5d = query_5d.result() 
q5d = 0;
for i in results_5d:
    print(i[0])
    q5d = str(i[0])

c = canvas.Canvas("DBLab7_PatientInfo_2019_CE_04.pdf")
c.translate(inch,inch)
c.rect(0,570, width=450, height=170, stroke=1,fill=0);
c.rect(20,600, width=397, height=120, stroke=1,fill=0);
c.setFont('Helvetica', 18);
c.drawString(33,660,'Payment Details for Patients with Renal Failure')

c.setFont('Helvetica', 12);
c.rect(0,470, width=180, height=70, stroke=1,fill=0);
c.drawString(10,517,'Total number of in-patients')
c.drawString(10,493,'in all medical centers')
c.rect(280,470, width=170, height=70, stroke=1,fill=0);
c.drawString(335,503,q5a)

c.rect(0,370, width=180, height=70, stroke=1,fill=0);
c.drawString(10,417,'Total number of outpatients')
c.drawString(10,393,'in all medical centers')
c.rect(280,370, width=170, height=70, stroke=1,fill=0);
c.drawString(340,403,q5b)

c.rect(0,270, width=180, height=70, stroke=1,fill=0);
c.drawString(10,317,'Total average amount paid')
c.drawString(10,293,'to inpatient')
c.rect(280,270, width=170, height=70, stroke=1,fill=0);
c.drawString(312,303,q5c)

c.rect(0,170, width=180, height=70, stroke=1,fill=0);
c.drawString(10,217,'Total average amount paid')
c.drawString(10,193,'to outpatient')
c.rect(280,170, width=170, height=70, stroke=1,fill=0);
c.drawString(340,203,q5d)
c.save()

