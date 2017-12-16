   # The worker containers simply execute the Laravel artisan queue:work
   # command instead of php-fpm
   TaskDefinitionWorker:
       Type: AWS::ECS::TaskDefinition
       Properties:
           Family: laravel-workers
           ContainerDefinitions:
               - Name: app
                 Essential: true
                Image: !Join [ ".", [ !Ref "AWS::AccountId", "dkr.ecr", !Ref "AWS::Region", !Join [ ":", [ !Join [ "/", [ "amazonaws.com", !Ref ECR ] ], "laravel" ] ] ] ]
                Command:
                  - "/bin/sh"
                  - "-c"
                  - "php artisan queue:work"
                Memory: 128
                LogConfiguration:
                  LogDriver: awslogs
                  Options:
                      awslogs-group: !Ref AWS::StackName
                      awslogs-region: !Ref AWS::Region
                Environment:
                  - Name: APP_NAME
                    Value: Laravel
                    ......
 
   # The cron container command is a bit more intricate
   # since we need to load the container's environment
   # variables in the same console session context than cron
   # for Laravel to use them
   TaskDefinitionCron:
       Type: AWS::ECS::TaskDefinition
       Properties:
          Family: laravel-cron
          ContainerDefinitions:
              - Name: app
                Essential: true
                Image: !Join [ ".", [ !Ref "AWS::AccountId", "dkr.ecr", !Ref "AWS::Region", !Join [ ":", [ !Join [ "/", [ "amazonaws.com", !Ref ECR ] ], "laravel" ] ] ] ]
                EntryPoint:
                  - /bin/bash
                  - -c
                Command:
                  - env /bin/bash -o posix -c 'export -p' > /etc/cron.d/project_env.sh && chmod +x /etc/cron.d/project_env.sh && crontab /etc/cron.d/artisan-schedule-run && cron && tail -f /var/log/cron.log
                Memory: 128
                LogConfiguration:
                  LogDriver: awslogs
                  Options:
                      awslogs-group: !Ref AWS::StackName
                      awslogs-region: !Ref AWS::Region
                Environment:
                  - Name: APP_NAME
                    Value: Laravel
