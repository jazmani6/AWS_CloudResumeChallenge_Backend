import json
import boto3

print('Loading function')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('VisitorTable')

    

def lambda_handler(event, context):
    count = 0
    table.update_item(
        Key={'id': 'Visitors'},
        UpdateExpression= "ADD visits:inc",
        ExpressionAttributeValues= {':inc': 1},
        ReturnValues="UPDATED_NEW",
        )
     
    response = table.get_item(
        Key={'id': 'Visitors'},
        ProjectionExpression= 'visits',
        )
        
    count = (response["Item"]['visits'])
    
        
    return {
        'statusCode': 200,
         'headers': {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Headers': "Content-Type",
            'Access-Control-Allow-Methods': '*',
            },
        'body': json.dumps({'Visitors': str(count)})
       
    }
    