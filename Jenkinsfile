pipeline {
    agent none
    stages {
        stage('BUILD') {
            agent{label "buildah"}
            steps {
                sh 'sudo ./buildah-build.sh'
            }
        }

        stage('GETVAULCREDS') {
            agent{label "vault"}
            steps {
            
            withVault(configuration: [timeout: 60, vaultCredentialId: '835dadcc-6e30-4a33-8983-7ac3cd065ebe', vaultUrl: 'http://127.0.0.1:8200'], vaultSecrets: [[path: 'secret/homelabio/dev/dockerhubmanintheit', secretValues: [[vaultKey: 'username'], [vaultKey: 'password'], [vaultKey: 'registry_url']]]]) {

}
            }
        }
    
        stage('PUSH') {
            agent{label "buildah"}
            steps {
            
            sh 'buildah login --username {$username} --password {$password}'
            sh 'buildah push buildah-nginx docker://docker.io/manintheit/buildah-nginx:latest'

}
            }
        }
    }


