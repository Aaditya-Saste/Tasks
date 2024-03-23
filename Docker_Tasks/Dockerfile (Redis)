#step1 - specify the base image 
FROM alpine

#step2 - Download and install dependencies
RUN apk add --update redis

#step3 - setup the startup command
CMD ["redis-server"]