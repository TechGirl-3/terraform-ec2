from terraform_validator.ValidateUtility import ValidateUtility

config_dict = {}
config_dict['suppress_errors'] = True
config_dict['template_file'] = '/tmp/template.tf'
validator = ValidateUtility(config_dict)
real_result =  validator.validate()
print(real_result)

[
    {
        'failure_count': '0',
        'filename': '/tmp/template.tf',
        'file_results': [
            {
                'id': 'W1',
                'type': 'VIOLATION::WARNING',
                'message': 'Specifying credentials in the template itself is probably not the safest thing',
                'logical_resource_ids': [
                    'EC2I4LBA1'
                ]
            }
        ]
    }
]
