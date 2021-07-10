# **Task Managment**

Task managmnet system helps user to manange all tasks at single place, Where user can abl to create tasks, assign task, comment on task, complete the tasks and so on.

By defualt every task is created on incompleted state. later on it will be assigned to users and change the status accordigly. User can also add attach/remove documents from the task. 


## Implemented Features

- Login
- Registraion
- Invite users
- User confirmation (send email)
- User listing
- List, Create, Update, view, list (With pagination) Tasks
- Task filter (by assignee, label, status, document, solicitation, Time)
- Task sorting (by title, assigness, labels, solicitation)
- Task searching (by title, description, due date)
- Add, View, Delete, Update, list comments on the task
- Change task status (incompleted , inprogress, completed, archive, unarchive)
- Show task activities (using papertrail_gem)
- Task assignments
- List, Create, Update, view, list labels
- List, Create, Update, view, list task documents
- List, Create, Update, view, list solicitations

## Remaining Features
- Task permission
- Tag user on the task and comments
- Document section

## Compatibility

* Ruby versions: 2.7.1
* Rails versions: 6.0.4
* ImageMagick 

 
## Walkthrough

**1) To checkout repository:**
 Create a local clone of the repository
 ```
 git clone https://github.com/mayur-simformsolutions/task_managment
 ```
**2) Simply follow these easy instructions to instal and run the app:**
 ```
 bundle install
 ```
**3)Execute the database migrations/schema setup procedure next:**
 ```
 bundle exec rake db:setup
 ```
**4)Start a rails server**
 ```
 rails server 
 ```
 
## Schema Description
 [Database scheme ](https://innovate-documents.s3.us-east-2.amazonaws.com/task_managment.png)



## postman collaction
[Postman collection ](https://innovate-documents.s3.us-east-2.amazonaws.com/Task+Managment.postman_collection.json)
