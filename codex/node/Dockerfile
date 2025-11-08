FROM node:16
ARG filepath
WORKDIR /usr/app
COPY --chown=node:node . .
RUN echo "#!/bin/sh" >> ./entrypoint.sh
RUN echo "node ./$filepath" >> ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
