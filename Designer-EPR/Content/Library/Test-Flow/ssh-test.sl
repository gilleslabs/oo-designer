namespace: Test-Flow
flow:
  name: ssh-test
  workflow:
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - password: "${get_sp('linux-password')}"
            - username: "${get_sp('linux-user')}"
            - host: "${get_sp('linux-server')}"
            - command: ls /etc
        publish:
          - CommandResult: '${return_result}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: send_mail
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail:
            - password: "${get_sp('mail-password')}"
            - username: "${get_sp('mail-user')}"
            - subject: Designer EPR - SSH TEST - SUCCESS
            - body: "${'The SSH-TEST Flow ran successfully, below is the output of the command :'+CommandResult}"
            - from: "${get_sp('mail-user')}"
            - to: "${get_sp('to-user')}"
            - port: '587'
            - hostname: "${get_sp('mail-server')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - on_failure:
        - send_mail_1:
            do:
              io.cloudslang.base.mail.send_mail:
                - password: "${get_sp('mail-password')}"
                - username: "${get_sp('mail-user')}"
                - body: "${'The ssh-test has failed with below error'+CommandResult}"
                - subject: DESIGNER-EPR - SSH TEST - FAILED
                - to: "${get_sp('to-user')}"
                - from: "${get_sp('mail-user')}"
                - port: '587'
                - hostname: "${get_sp('mail-server')}"
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
