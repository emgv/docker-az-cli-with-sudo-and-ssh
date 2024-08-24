FROM mcr.microsoft.com/azure-cli:latest
LABEL maintainer="<maintainer-name>"
RUN apk --no-cache update \
    && apk --no-cache add sudo
RUN apk add --no-cache tzdata
ENV TZ=<time-zone> # e.g. "Europe/Brussels"
RUN apk add --update --no-cache openssh 
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN adduser -h /home/emgv -s /bin/sh -D emgv
RUN echo -n '<username>:<yourpassword>' | chpasswd
RUN echo '<username> ALL=(ALL) /bin/su' >>  /etc/sudoers
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY entrypoint.sh /
