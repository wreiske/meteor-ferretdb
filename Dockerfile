# Credits to https://github.com/disney/meteor-base/blob/main/example/default.dockerfile for this file

# The tag here should match the Meteor version of your app, per .meteor/release
FROM geoffreybooth/meteor-base:2.7.3

# Copy app package.json and package-lock.json into container
COPY ./blaze-tutorial/src/simple-todos/step06/package*.json $APP_SOURCE_FOLDER/

RUN bash $SCRIPTS_FOLDER/build-app-npm-dependencies.sh

# Copy app source into container
COPY ./blaze-tutorial/src/simple-todos/step06 $APP_SOURCE_FOLDER/

RUN bash $SCRIPTS_FOLDER/build-meteor-bundle.sh


# Use the specific version of Node expected by your Meteor release, per https://docs.meteor.com/changelog.html; this is expected for Meteor 2.7.3
FROM node:14.20.0-bullseye

ENV APP_BUNDLE_FOLDER /opt/bundle
ENV SCRIPTS_FOLDER /docker

RUN apt-get update
# Runtime dependencies; if your dependencies need compilation (native modules such as bcrypt) or you are using Meteor <1.8.1, use app-with-native-dependencies.dockerfile instead
RUN apt-get install -y \
		bash \
		ca-certificates \
		build-essential

# Copy in entrypoint
COPY --from=0 $SCRIPTS_FOLDER $SCRIPTS_FOLDER/

# Copy in app bundle
COPY --from=0 $APP_BUNDLE_FOLDER/bundle $APP_BUNDLE_FOLDER/bundle/

RUN bash $SCRIPTS_FOLDER/build-meteor-npm-dependencies.sh

RUN node $APP_BUNDLE_FOLDER/bundle/programs/server/npm-rebuild.js

# Start app
ENTRYPOINT ["/docker/entrypoint.sh"]

CMD ["node", "main.js"]