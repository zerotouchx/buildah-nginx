pipeline {
    agent none
    stages {
        stage('BUILD') {
            agent{label "podman"}
            steps {
                sh 'sudo ./buildah-build.sh'
            }
        }

        stage('PUSH') {
            agent{label "podman"}
            steps {
            
            withVault(configuration: [timeout: 60, vaultCredentialId: '835dadcc-6e30-4a33-8983-7ac3cd065ebe', vaultUrl: 'http://127.0.0.1:8200'], vaultSecrets: [[path: 'secret/homelabio/dev/dockerhubmanintheit', secretValues: [[vaultKey: 'username'], [vaultKey: 'password'], [vaultKey: 'registry_url']]]]) {
            buildah login --username {$username} --password {$password}
            buildah push buildah-nginx docker://docker.io/manintheit/buildah-nginx:latest
}
            }
        }
    
    }
}
