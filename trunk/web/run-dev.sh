#!/bin/bash
cd ../sharedMap
ant
cd ../forum
ant
cd ../web
grails run-app
