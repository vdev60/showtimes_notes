# Project Name

## Prerequisites

To set up and run this project, ensure you have the following installed:

- **Ruby** (version 3.0.0 or newer)
- **Rails** (version 7.0 or newer)
- **MySQL**
- **Redis**

## Setup

### 1. Install Gems
```sh
bundle install
```

### 2. Setup Database
```sh
rails db:create
rails db:migrate
```

## Running

### 1. Start Redis
```sh
redis-server
```

### 2. Start Rails Server
```sh
rails s
```

### 3. Start Resque Worker
```sh
QUEUE=* bundle exec rake resque:work
```

### 4. Start Resque Scheduler
```sh
bundle exec rake environment resque:scheduler
```

To run commands 2, 3, and 4 together, use:
```sh
foreman start
```

## Testing  

### 1. Run All Tests
```sh
bundle exec rspec spec
```

### 2. See Coverage
```sh
open coverage/index.html
```
