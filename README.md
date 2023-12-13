# Viewing Party Lite - Week 3 Version

This repo can be used by any students during BE week 3.

## Set Up

1. fork and clone
2. bundle install
3. rails db:{drop,create,migrate,seed}


# Authorization and Sessions Challenge
For this challenge, focus on using Behavior Driven Development (BDD) over Test Driven Development (TDD).  


# Part 1: Sessions Challenge 

## Task 1: Remember a user upon successful log in/registration
  * In your users#create action, and your users#login_user (or sessions#create if you've refactored) action, add that authenticated users id into the session `session[:user_id] = user.id`

## Task 2: Log out a user
  ```
  As a logged in user 
  When I visit the landing page
  I no longer see a link to Log In or Create an Account
  But I see a link to Log Out.
  When I click the link to Log Out
  I'm taken to the landing page
  And I can see that the Log Out link has changed back to a Log In link
  ```
  
  ### Steps to consider
  1. Add a conditional in your view to show the correct Link (Remember, you can access session data in your views)
  2. Create a new route for logging out
     - This action should remove the user_id from the session so that the user id doesn't persist.

<br>
<hr>

# Part 2: Authorization Challenge

## Task 3: User Story 1
```
As a visitor
When I visit the landing page
I do not see the section of the page that lists existing users
```

## Task 4: User Story #2
```
As a registered user
When I visit the landing page
The list of existing users is no longer a link to their show pages
But just a list of email addresses
```
* Note: this story isn't necessarily 'authorization', this functionality is just not necessary anymore, now that we have basic auth in place. 


## Task 5: User Story #3 
```
As a visitor
When I visit the landing page
And then try to visit '/dashboard'
I remain on the landing page
And I see a message telling me that I must be logged in or registered to access my dashboard
```

## Task 6: User Story #4
```
As a visitor
If I go to a movies show page 
And click the button to create a viewing party
I'm redirected to the movies show page, and a message appears to let me know I must be logged in or registered to create a movie party. 
```

<hr>

# Part 3: Refactor Routing (IF you have more time)

## Update routes to not include user id
  * **Do this ONE AT A TIME** - change a route to not have the user id passed in, run your tests, fix your code/tests to get them green again.
    * Important items to note: 
        1. It would be most conventional to change your user show route (`/users/:id`) to something like `/dashboard`. Still, have it go to the same controller#action, but make the URI more friendly. All other routes, you can simply just take off the `/user/:id` section of the uri. 
        2. Now that your user id will get stored into the session ONLY upon succesful authentication (registration and logging in), you will need to update your tests to either log in or register a user. I'd suggest putting this into a before action. You could also create a method that grabbed the value from `session[:user_id]`, and stub that method in your tests. 

<br>

# Extensions
* If you want to do the below extensions, you may find it helpful to take a look at [this tutorial](https://backend.turing.edu/module3/lessons/sessions_cookies_authorization#:~:text=Authorization%20%E2%80%93%20Are%20you%20ALLOWED%20to%20do%20that%3F%3F)


## Extension - User Story #5
```
When I log in as an admin user
I'm taken to my admin dashboard `/admin/dashboard`
I see a list of all default user's email addresses
When I click on a default user's email address
I'm taken to the admin users dashboard. `/admin/users/:id`
Where I see the same dashboard that particular user would see
```

## Extension - User Story #6
```
As a visitor or default user 
If I try to go to any admin routes ('/admin/dashboard' or '/admin/users/:id')
I get redirected to the landing page
And I see a message pop up telling me I'm not authorized to access those pages. 
```

