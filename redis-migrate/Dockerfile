FROM python:2

RUN pip install redis termcolor

ADD migrate.py /

ENTRYPOINT ["/usr/local/bin/python", "/migrate.py"]
CMD ["-h"]
