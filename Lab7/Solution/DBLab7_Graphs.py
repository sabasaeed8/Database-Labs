from google.cloud import bigquery
import matplotlib.pyplot as plt

from reportlab.pdfgen import canvas

from google.cloud import bigquery
from google.oauth2 import service_account
credentials = service_account.Credentials.from_service_account_file(
'project2-db-342508-68107c3ae178.json')


client = bigquery.Client(credentials= credentials,project=credentials.project_id)


########### Payment released for patients with renal failure

query_5e = client.query("""
   SELECT
   Avg_payment AS Avg_payment
FROM (
  SELECT
    AVG(a.average_medicare_payments) AS Avg_payment
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2011`a
  WHERE
    a.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    AVG(b.average_medicare_payments) AS Avg_payment
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2012`b
  WHERE
    b.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    AVG(c.average_medicare_payments) AS Avg_payment
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2013`c
  WHERE
    c.drg_definition LIKE '%RENAL FAILURE%'
  UNION ALL
  SELECT
    AVG(d.average_medicare_payments) AS Avg_payment
  FROM
    `bigquery-public-data.cms_medicare.inpatient_charges_2014`d
  WHERE
    d.drg_definition LIKE '%RENAL FAILURE%' )


 """)

years = ['2011','2012','2013','2014']
payments = []
results_5e = query_5e.result() 
for i in results_5e:
   payments.append(i[0])

plt.figure()

plt.bar(years, payments)
plt.title("Payment released for patients with renal failure")
plt.xlabel("Renal failure")
plt.ylabel("Payments")


c = canvas.Canvas("DBLab7_Graphs_2019_CE_04.pdf")
c.drawImage('graph.png', 100, 500);
c.save()