 resource "aws_dynamodb_table" "visitors_dynamodb_table" {
  name           = "VisitorTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }


  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}

resource "aws_dynamodb_table_item" "visits" {
    depends_on = [
      aws_dynamodb_table.visitors_dynamodb_table
    ]
    table_name = aws_dynamodb_table.visitors_dynamodb_table.name
    hash_key = aws_dynamodb_table.visitors_dynamodb_table.hash_key

    item = <<ITEM
    {
        "id": {"S": "Visitors"},
        "visits": {"N": "0"}
    }
    ITEM
}

