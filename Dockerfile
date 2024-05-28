FROM alpine:3.15.11

RUN apk --no-cache add openssh-server git

WORKDIR /git-server

# -D flag avoids password generation
# -s flag changes user's shell
RUN mkdir keys \
  && adduser -Ds /usr/bin/git-shell git \
  && echo -n git:111 | chpasswd \
  && mkdir /home/git/.ssh \
  && ssh-keygen -A

COPY start.sh .
COPY sshd_config /etc/ssh/

EXPOSE 22

CMD ["sh", "start.sh"]
