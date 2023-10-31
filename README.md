# Spilled Tea - Subscription Service API

## Overview

### JSON Contract
<details>
  <summary> <b>POST api/v0/subscriptions </b></summary><br/>

Description: Create a new subscription.

Requirements: Must provide valid data and datatypes as follows:
- title [String]
- price [Float]
- frequency [Integer] (Options: 0 = weekly, 1 = monthly, 2 = qu
arterly, 3 = annually)
- customer_id [Integer]
- tea_id [Integer]
<br/><br/>

Request Body Example:

```
{
  "title": "Monthly Tea is Fundamental",
  "price": 9.99,
  "frequency": 1,
  "customer_id": 1,
  "tea_id": 7
}
```
---
<details>
<summary>Successful Response Example:</summary>

```
{
  "data": {
    "id": "1",
    "type": "subscription",
    "attributes": {
      "title": "Monthly Tea is Fundamental",
      "price": 9.99,
      "status": "active",
      "frequency": "monthly",
      "tea_id": 7,
      "customer_id": 1
    }
  }
}
```

**Status Code:** 

The subscription has not been successfully created due to invalid ids, invalid data types, or missing values. The response contains the detailed error message.
</details>

---
<details>
<summary>Error Response Example:</summary>

```
{
  
}
```

**Status Code:** 201 (Created) 

The subscription has been successfully created. The response contains the newly created subscription's details with the status set to "active" as a default.
</details>