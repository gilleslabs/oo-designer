namespace: Test-Flow
flow:
  name: ssh-test
  workflow:
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command: []
        publish:
          - CommandResult: '${return_result}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: send_mail
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - on_failure:
        - send_mail_1:
            do:
              io.cloudslang.base.mail.send_mail: []
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      ssh_command:
        x: 65
        y: 116
      send_mail:
        x: 327
        y: 113
    results:
      SUCCESS:
        10c0fe67-5cab-612a-3c57-b7d2e958f479:
          x: 624
          y: 105
    navigations:
      d4c2fbb4-cba1-41fd-9334-f0a3d8979a90:
        name: SUCCESS
        sourceId: ssh_command
        sourcePortName: SUCCESS
        targetId: send_mail
      dc34f0ad-f8ad-4ab7-96ea-e4c56c071d11:
        name: SUCCESS
        sourceId: send_mail
        sourcePortName: SUCCESS
        targetId: 10c0fe67-5cab-612a-3c57-b7d2e958f479
