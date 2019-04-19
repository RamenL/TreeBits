# SERVD
Web application for the Community Engaged Learning (CEL) administrators, local community service organizations, and college students to list, manage, and volunteer for upcoming opportunities in the local area.

## Development Setup

Install Ruby on Rails & PostgreSQL for your machine:
Ruby (2.3.1) & Rails (5.0.7): 
https://gorails.com/setup/

Clone this repository: 

    git clone https://github.com/TCNJSwEngg/servd.git

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
