# Chromecastwebapp
The purpose of this repo is to better understand the requirements that a
webapp must meet in order to connect to a Google Chromecast. Specifically, in
regards to protocol (http/https), hostname/ip, network interface (loopback vs physical),  point of dns resolution (local, intranet, public).

<br />


## Build docker image
    make image

<br />


## Run docker container
    make run
This will bind to all interfaces on port 80  

<br />
  
  
## Tests
protocol (http/https), network interface (loopback vs physical), hostname/ip, point of dns resolution (local, intranet, public), and with/without legitimate TLS certificates.

| #  | Tested URL        | Network Interface  | DNS resolution | Resolved IP | Results |
|----|-------------------|--------------------|----------------|-------------|---------|
| 1  | http://127.0.0.1  | loopback           | N/A            | 127.0.0.1   | Success |
| 2  | http://127.0.0.2  | loopback           | N/A            | 127.0.0.2   | Success |
| 3  | http://10.0.0.2   | physical           | N/A            | 10.0.0.2    | Failed  |
| 4  | http://localhost  | loopback           | local          | 127.0.0.1   | Success |
| 5  | http://localhost  | physical           | local          | 10.0.0.2    | Success |
| 6  | http://localhost-127-0-0-1 | loopback  | local          | 127.0.0.1   | Failed  |
| 7  | http://localhost-127-0-0-2 | loopback  | local          | 127.0.0.2   | Failed  |
| 8  | https://chromecastwebapp.jeffguymon.com/ | physical | public   | (hidden) | Success |
| 9  | https://chromecastwebapp.jeffguymon.com/ | physical | intranet | 10.0.0.2 | Success |
| 10 | https://chromecastwebapp.jeffguymon.com/ | physical | local    | 10.0.0.2 | Success |

<br />

## Conclusion & Interpretation
From the above tests, I find there are 3 permitted ways to access a webapp that will not inhibit casting:
  + **https://[Hostname]** - Standard deployment with a legitimate TLS certificate.
  + **http://[Loopback IP]** - Loopback IP can be anywhere within the 127.0.0.0/8 range
  + **http://localhost/** - Interestingly, if localhost locally resolves to a non-loopback ip it will still work.

<br />  

## Final Thoughts
This repo on tested the most basic form of casting media. I believe there is 
another more complicated approach inwhich a second webapp is deployed to be run
ON the chromecast itself. And in such a configuration, it will likely have its own
constraints for what protocols are permissible.