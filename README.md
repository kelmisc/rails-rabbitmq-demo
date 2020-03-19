# rails-rabbitmq-demo

this demo uses rabbitmq as a message queue.

procedure to start the whole demo:
1. execute "docker-compose up" at project root path to start message queue.
2. cd ./producer and execute "rails db:reset && rails s" to 
   start producer service hosted at localhost:4000 and create random balances for three account.
3. cd ./cosumer and execute "rails s" to start producer service hosted at localhost:3000
4. post to localhost:3000/consume/start to start consumer service
5. post to localhost:4000/transaction/produce to start producer service

The transaction log will be streamed from producer to consumer 
by the message queue and be displayed in the console.

To stop the services, post to localhost:4000/transaction/stop and localhost:3000/consume/stop
press ctrl-c on all the consoles where the "rails server" and "docker-compose" up ran at.
