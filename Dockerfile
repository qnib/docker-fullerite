# QNIBTerminal image
FROM qnib/alpn-consul

RUN wget -qO /usr/local/bin/go-github https://github.com/qnib/go-github/releases/download/0.2.2/go-github_0.2.2_Linux && \
    chmod +x /usr/local/bin/go-github
RUN wget -qO /usr/local/bin/fullerite $(/usr/local/bin/go-github rLatestUrl --ghorg ChristianKniep --ghrepo fullerite --regex "fullerite.*inux") && \
    chmod +x /usr/local/bin/fullerite
ADD conf/fullerite.conf /etc/fullerite/
ADD opt/qnib/fullerite/start.sh /opt/qnib/fullerite/
ADD etc/supervisord.d/fullerite.ini /etc/supervisord.d/
