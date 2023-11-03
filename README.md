# Spilled Tea - Subscription Service API

## Overview
Spilled tea is a quick project done as a technical assessment to create a backend rails API for a tea subscription service based off of minimal details on the requirements.


<br/>

### Model Schema and Associations
**Model Schema**
```
Customers
- id (Primary Key | Integer)
- name (String)
- email (String)
- address (String)
- created_at (Datetime)
- updated_at (Datetime)

Teas
- id (Primary Key | Integer)
- name (String)
- description (String)
- brew_temp (String)
- brew_time (String)
- created_at (Datetime)
- updated_at (Datetime)

Subscriptions
- id (Primary Key | Integer)
- title (String)
- price (Float)
- status (Integer, Default: 0)
- frequency (Integer)
- customer_id (Foreign Key)
- tea_id (Foreign Key)
- created_at (Datetime)
- updated_at (Datetime)
```

**Associations**
```
- Customers have many Subscriptions.
- Teas have many Subscriptions.
- Subscriptions belong to a Customer and a Tea
```

**Validations** - _The following lists the required data for creating each model object_
```
Customers
- name (String)
- email (String)
- address (String)

Teas
- name (String)
- description (String)
- brew_temp (String)
- brew_time (String)


Subscriptions
- title (String)
- price (Float)
- frequency (Integer) (Options: 0 = weekly, 1 = monthly, 2 = quarterly, 3 = annually)
- customer_id (Foreign Key)
- tea_id (Foreign Key)
Uniqueness Note: If a customer already subscribes to a specific tea, the subscription must be updated to make
any changes. A new subscription for the same tea cannot be created.
```

<br/>

### JSON Contract
<details>
  <summary> <b>POST api/v0/subscriptions </b></summary><br/>

  Description: Create a new subscription.

  Requirements: Must provide valid data and datatypes as follows.
  - title [String]
  - price [Float]
  - frequency [Integer] (Options: 0 = weekly, 1 = monthly, 2 = quarterly, 3 = annually)
  - customer_id [Integer]
  - tea_id [Integer]
  <br/><br/>

  
  <br/>
  <details>
    <summary> Successful Request</summary>
    <br/>
    Request Body:
    
      ```
      {
        "title": "Monthly Tea is Fundamental",
        "price": 9.99,
        "frequency": 1,
        "customer_id": 1,
        "tea_id": 7
      }
      ```
    
   Response:

    
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

  The subscription has been successfully created. The response contains the newly created subscription details with the status set to "active" as a default.
  <br/><br/>
  </details>

  <details>
    <summary>Errored Request</summary>
    <br/>
    Request Body:

    ```
    { 
        "customer_id": 99999999, 
        "tea_id": 7,
        "title": null, 
        "price": 9.99, 
        "frequency": 1
    }
    ```
    
  Response:

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

  The subscription has not been successfully created due to invalid IDs, invalid data types, or missing values. The response contains a detailed error message.
  </details>
  <br/><br/><br/>
</details>

---

<details>
  <summary> <b>PATCH api/v0/subscriptions/:id </b></summary><br/>

  Description: Update a subscription's attributes or status (Cancel a subscription).

  Requirements: 
  * *If updating data of the subscription*
    - title [String]
    - price [Float]
    - frequency [Integer] (Options: 0 = weekly, 1 = monthly, 2 = quarterly, 3 = annually)
    - customer_id [Integer]
    - tea_id [Integer]

  * *If canceling a subscription*
    - status [Integer] (Options: 0 = active, 1 = canceled)

  <br/><br/>
  

  <br/>
  <details>
    <summary>Successful Request</summary>
    <br/>
    Request Body:

    ```
    {
      "status": 1
    }
    ```

  Response:
    
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

  The subscription has been successfully updated with the status "canceled".
  <br/> <br/><br/>
  </details>

  <details>
    <summary>Errored Request - Invalid Attribute</summary>
     <br/>
    Request Body:

    ```
    {
      "status": 9
    }
    ```
  Response:
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

  The subscription has not been updated as an invalid status enums (integer) was used. Only the values 0 (active) and 1 (canceled) are allowed. The response contains a detailed error message.
  <br/><br/><br/>
  </details>
  

  <details>
    <summary>Errored Request - Invalid Subscription ID</summary>
     <br/>
    Request Body:

    ```
    {
      "status": 9
    }
    ```
  Response:
    ```
    {
      "errors": [
        {
          "details": "Couldn't find Subscription with 'id'=999999999"
        }
      ]
    }
    ```

  **Status Code:** 404 :not_found

  The subscription has not been updated as an invalid subscription ID was used in the URL of the call. The response contains a detailed error message.
  </details>
  <br/><br/><br/>
</details>

---

<details>
  <summary> <b>GET api/v0/customers/:id/subscriptions </b></summary><br/>

  Description: Get a list of all subscriptions for a customer.

  Requirements: 
  * *Must pass a valid customer ID*

  Request Body: No request body is required

  <br/>
  <details>
    <summary>Successful Response</summary>
  
    ```
    {
      "data": [
        {
          "id": "1",
          "type": "subscription",
          "attributes": {
              "title": "Sissy that walk.",
              "price": 60.75,
              "status": "active",
              "frequency": "annually",
              "tea_id": 1,
              "customer_id": 1
          }
        },
        {
          "id": "2",
          "type": "subscription",
          "attributes": {
              "title": "Put the bass in your walk.",
              "price": 57.79,
              "status": "active",
              "frequency": "quarterly",
              "tea_id": 2,
              "customer_id": 1
          }
        },
        {
          "id": "3",
          "type": "subscription",
          "attributes": {
              "title": "She done already done had herses.",
              "price": 51.89,
              "status": "canceled",
              "frequency": "weekly",
              "tea_id": 3,
              "customer_id": 1
          }
        }
      ]
    }
    ```

  **Status Code:** 200 :ok

  The list of the customer's subscriptions has successfully been retrieved.
  <br/><br/><br/>
  </details>

  <details>
    <summary>Successful Response (no subscriptions)</summary>

    ```
    {
      "data": []
    }
    ```

  **Status Code:** 200 :ok

  The customer has no subscriptions, so the data is a blank array.'
  <br/><br/><br/>
  </details>
  
  <details>
    <summary>Invalid customer ID Error Response</summary>

    ```
    {
      "errors": [
        {
            "details": "Couldn't find Customer with 'id'=123123123123"
        }
    ]
}
    ```

  **Status Code:** 404 :not_found 

  The customer ID was not found, so no records could be returned. The response contains a detailed error message.
  </details>
</details>

---
