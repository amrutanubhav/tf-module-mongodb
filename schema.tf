resource "null_resource" "docdb" {

    depends_on = [
      aws_db_instance.docdb
    ]

  provisioner "local-exec" {
    command =  <<EOF

    curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
    cd /tmp
    unzip mongodb.zip
    cd mongodb-main
    mongo -h aws_docdb_cluster.docdb.endpoint <catalogue.js
    mongo -h aws_docdb_cluster.docdb.endpoint <user.js

    EOF
  }
}

resource "null_resource" "docdb-schema" {
  
  # This is how we can create depenency and ensure this will only run after the creation if the RDS Instance.
  depends_on = [aws_docdb_cluster.docdb]

  provisioner "local-exec" {
        command = <<EOF
        cd /tmp 
        wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
        curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
        unzip -o mongodb.zip
        cd mongodb-main
        mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile /tmp/rds-combined-ca-bundle.pem --username admin1 --password roboshop1 < catalogue.js 
        mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile /tmp/rds-combined-ca-bundle.pem --username admin1 --password roboshop1 < users.js 
        EOF
    }  
}