#!/bin/bash
/opt/SshManagerApi/sshmanagerapi --port $(cat /opt/SshManagerApi/port.txt) --token $(cat /opt/SshManagerApi/token.txt)