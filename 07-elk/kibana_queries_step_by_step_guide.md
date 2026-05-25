# Kibana Queries Step-by-Step Guide

# Objective

Learn how to:
- Search logs in Kibana
- Filter application logs
- Analyze failures
- Investigate security events
- Monitor Kubernetes-style events
- Create realistic live demos

---

# Step 1 — Open Kibana

Open browser:

```text
http://<VM-IP>:5601
```

---

# Step 2 — Open Discover

Navigate:

```text
Analytics
→ Discover
```

---

# Step 3 — Select Data View

Choose:

```text
ecommerce-logs-*
```

---

# Step 4 — Verify Logs Are Flowing

Run query:

```text
*
```

You should see:
- payment logs
- orders logs
- auth logs
- inventory logs

---

# Step 5 — Add Useful Columns

On left side panel add:

- service
- level
- status
- response_time
- user
- client_ip

This makes the logs much easier to read.

---

# Step 6 — Filter ERROR Logs

Query:

```text
level:ERROR
```

Use Case:
- Show application failures
- Simulate production incidents

---

# Step 7 — Filter WARN Logs

Query:

```text
level:WARN
```

Use Case:
- Show warnings
- Analyze degraded systems

---

# Step 8 — Filter INFO Logs

Query:

```text
level:INFO
```

Use Case:
- Show normal application activity

---

# Step 9 — View Payment Service Logs

Query:

```text
service:payment
```

Use Case:
- Payment monitoring
- Transaction tracking

---

# Step 10 — View Orders Service Logs

Query:

```text
service:orders
```

Use Case:
- Order analytics
- E-commerce tracking

---

# Step 11 — View Authentication Logs

Query:

```text
service:auth
```

Use Case:
- Login monitoring
- Security analysis

---

# Step 12 — View Failed Transactions

Query:

```text
status:FAILED
```

Use Case:
- Failure analysis
- Incident monitoring

---

# Step 13 — Failed Payment Transactions

Query:

```text
service:payment AND status:FAILED
```

Use Case:
- Payment gateway failures
- Banking demo

---

# Step 14 — Authentication Failures

Query:

```text
service:auth AND status:FAILED
```

Use Case:
- Security dashboard
- Login attack simulation

---

# Step 15 — ERROR + FAILED Together

Query:

```text
level:ERROR AND status:FAILED
```

Use Case:
- Critical production issues

---

# Step 16 — Slow Transactions

Query:

```text
response_time > 2000
```

Use Case:
- API latency monitoring
- Performance issues

---

# Step 17 — Very Slow Payment APIs

Query:

```text
service:payment AND response_time > 2500
```

Use Case:
- Payment service degradation

---

# Step 18 — Fast Transactions

Query:

```text
response_time < 500
```

Use Case:
- Healthy API responses

---

# Step 19 — Logs for Specific User

Query:

```text
user:alice
```

Use Case:
- User activity tracking

---

# Step 20 — Failed Requests by User

Query:

```text
user:bob AND status:FAILED
```

Use Case:
- User issue investigation

---

# Step 21 — Failed Login Attempts

Query:

```text
service:auth AND status:FAILED
```

Use Case:
- Security monitoring

---

# Step 22 — Filter Client IP Range

Query:

```text
client_ip:192.168.1.*
```

Use Case:
- Internal traffic analysis

---

# Step 23 — Filter Specific Client IP

Query:

```text
client_ip:"192.168.1.10"
```

Use Case:
- Threat investigation
- User tracking

---

# Step 24 — Kubernetes Pod Failures

Query:

```text
status:CrashLoopBackOff
```

Use Case:
- Kubernetes monitoring

---

# Step 25 — Production Namespace Logs

Query:

```text
namespace:production
```

Use Case:
- Production cluster monitoring

---

# Step 26 — Specific Kubernetes Pod

Query:

```text
pod:"payment-api-123"
```

Use Case:
- Pod troubleshooting

---

# Step 27 — Advanced Production Incident Query

Query:

```text
service:payment AND level:ERROR AND response_time > 2000
```

Use Case:
- Critical payment outage

---

# Step 28 — Failed High Value Orders

Query:

```text
service:orders AND status:FAILED AND order_value > 10000
```

Use Case:
- Revenue-impacting incidents

---

# Step 29 — Multiple Services Together

Query:

```text
service:(payment OR auth)
```

Use Case:
- Combined service analysis

---

# Step 30 — Exclude INFO Logs

Query:

```text
NOT level:INFO
```

Use Case:
- Focus only on warnings/errors

---

# Step 31 — Severe Production Issues

Query:

```text
(level:ERROR OR status:FAILED) AND response_time > 1500
```

Use Case:
- Executive dashboard
- Incident response

---

# Step 32 — Enable Auto Refresh

In Kibana top-right corner:

```text
Refresh every 5 seconds
```

This makes dashboards live.

---

# Step 33 — Adjust Time Range

Top-right time filter.

Recommended:
- Last 15 minutes
- Last 1 hour

For demos:
- Last 15 minutes works best

---

# Step 34 — Save Searches

In Discover:

```text
Save Search
```

Recommended saved searches:
- Failed Payments
- Security Events
- Slow APIs
- ERROR Logs

These can later be added to dashboards.

---

# Step 35 — Create Dashboard Panels

Go to:

```text
Analytics
→ Dashboard
```

Create panels using:
- Saved searches
- Lens visualizations

---

# Recommended Dashboard Visualizations

| Visualization | Best Use |
|---|---|
| Metric | KPIs |
| Pie Chart | Service distribution |
| Donut Chart | Error breakdown |
| Line Chart | Trends |
| Bar Chart | Comparisons |
| Data Table | Detailed logs |

---

# Tip

Inject a live error:

```bash
echo '{"timestamp":"2026-05-25T10:00:00Z","service":"payment","level":"ERROR","status":"FAILED","response_time":2800}' >> /var/log/ecommerce-app.log
```

Refresh Discover.

You will immediately see:
- ERROR spikes
- Failed transactions
- High latency
