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

**Status Code:** 201 :created

The subscription has been successfully created. The response contains the newly created subscription's details with the status set to "active" as a default.
</details>

---
<details>
<summary>Error Response Example:</summary>

```
{
  "errors":[
    {
      "Validation failed: Title can't be blank"
    }
  ]
}
```

**Status Code:** 422 :unprocessable_entity

The subscription has not been successfully created due to invalid ids, invalid data types, or missing values. The response contains the detailed error message.
</details>
</details>

---

<details>
  <summary> <b>PATCH api/v0/subscriptions/:id </b></summary><br/>

Description: Update a subscription status (Cancel a subscription).

Requirements: 
* *If updating data of the subscription*
  - title [String]
  - price [Float]
  - frequency [Integer] (Options: 0 = weekly, 1 = monthly, 2 = qu
arterly, 3 = annually)
  - customer_id [Integer]
  - tea_id [Integer]

* *If cancelling a subscription*
  - status [Integer] (Options: 0 = active, 1 = canceled)

<br/><br/>
Cancellation Request Body Example:

```
{
  "status": 1
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
      "status": "canceled",
      "frequency": "monthly",
      "tea_id": 7,
      "customer_id": 1
    }
  }
}
```

**Status Code:** 200 :ok

The subscription has been successfully updated with a status "canceled".
</details>

---
<details>
<summary>Cancelation Error Response Example:</summary>

```
{
  "errors":[
    {
      "details":"'9' is not a valid status"
    }
  ]
}
```

**Status Code:** 400 :bad_request 

The subscription has not been updated as an invalid status enums (integer) was used. Only the values 0 (active) and 1 (canceled) are allowed. The response contains the detailed error message.
</details>
</details>