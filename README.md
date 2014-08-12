catcha
======
Catch-a - Catching annotation

This software was created for the Harvard Library Labs project CATCH (https://osc.hul.harvard.edu/liblab/proj/catch) awarded to Phil Desenne, Martin Schreiner and Paolo Ciccarese

The software was originally written by:
* Dr. Paolo Ciccarese http://paolociccarese.info
* Justin Miranda

# Getting Started

## Developer Installation

### Download application source code
```
git clone https://github.com/annotationsatharvard/catcha.git
cd catcha
./install.sh
```

##### Create external configuration file 
If you changed the username or password, you need to edit an external configuration file.

NOTE: Do NOT change the database name as there is a bug I just discovered in the Liquibase changesets that hard-codes the schema name to "catch" when dealing with foreign key contstraints.

## Run application in development mode
```
$ grails run-app
```


