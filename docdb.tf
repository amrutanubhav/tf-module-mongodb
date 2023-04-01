#this block provisions documentdb

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}-docdb"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
  db_subnet_group_name    = aws_docdb_subnet_group.docdb.name
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"  #uncheck all 3 in production
#   skip_final_snapshot     = true
}

#creates subnet group
resource "aws_docdb_subnet_group" "docdb" {
  name       = "roboshop-${var.ENV}-docdb-subnet-grp"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-docdb-subnet-grp"
  }
}