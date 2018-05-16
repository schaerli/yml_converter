ARG foo
FROM ruby:2.5-alpine

# Build deps
RUN apk add --no-cache --update --virtual build-deps \
        build-base \
        linux-headers \
        git \
        openssh \
        gcc \
        postgresql-dev
# Run deps
RUN apk add --no-cache --update --virtual run-deps \
        postgresql-client \
        nodejs \
        tzdata

RUN mkdir -p ~/.ssh && \
  echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

# ADD id_rsa /root/.ssh/

#RUN chmod 700 /root/.ssh/id_rsa

#ENV PATH /usr/sbin/:$PATH
#ENTRYPOINT [ "crond -f" ]


#  before_script:
#    - eval $(ssh-agent -s)
#    - bash -c 'ssh-add <(echo "$SSH_PRIVATE_KEY")'
#    - mkdir -p ~/.ssh
#    - echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
#    - bundle install -j $(nproc)


ENV APP_PATH /yml_converter

ENV RAILS_ENV "production"

# RUN git clone ssh://gitlab-ci-token:${CI_JOB_TOKEN}@elu.noip.me:2022/dani/yml_converter.git $APP_PATH
RUN git clone http://gitlab-ci-token:${foo}@git.elu.noip.me/dani/yml_converter.git $APP_PATH

#RUN unset CI
#RUN unset DB

WORKDIR $APP_PATH

RUN bundle install --without development test
RUN rake assets:precompile
RUN touch $APP_PATH/config/production.log
RUN ln -sf /dev/stdout $APP_PATH/log/production.log
#RUN rake db:create
#RUN rake db:migrate

#EXPOSE 3000

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]

RUN apk del build-deps
