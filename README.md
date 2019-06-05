# TreeBits
This project is a web application that uses Ruby on Rails. It uses a BST structure to organize information into topics and subtopics. For example, a topic such as "What is Racism" could have a more specific learning topic nested underneath like "Model Minority" or "Defining Discrimination". This allows the user to learn about a topic and pick which learning path they want to take to learn more. 

## Development Setup

Install Ruby on Rails & PostgreSQL for your machine:
Ruby (2.3.1) & Rails (5.0.7): 
https://gorails.com/setup/

Clone this repository: 

    git clone https://github.com/darkhawk0000/TreeBits.git

Once cloned, navigate to the servd/code directory and install the project dependencies. 

    bundle install

Ensure postgres is running (ex: mac).

    pg_ctl -D /usr/local/var/postgres start

Create the databases and perform migration:

    rake db:create
    rake db:migrate

Finally, run the app.
    
    rails server
    
The app should be available in the browser at [localhost:3000](localhost:3000).
