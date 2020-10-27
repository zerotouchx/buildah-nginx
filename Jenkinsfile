pipeline {
    agent none
    stages {
        stage('BUILD') {
            agent{label "buildah"}
            steps {
                sh 'sudo ./buildah-build.sh'
            }
        }

    
        stage('GETVAULTCREDS') {
            agent{label "buildah"}
            steps {
            withVault(configuration: [timeout: 60, vaultCredentialId: '835dadcc-6e30-4a33-8983-7ac3cd065ebe', vaultUrl: 'http://devops:8200'], vaultSecrets: [[path: 'secret/dockerhub', secretValues: [[vaultKey: 'username'], [vaultKey: 'password'], [vaultKey: 'registry_url']]]]) {
             sh 'sudo buildah login --username "${username}" --password "${password}" "${registry_url}"'
             }
        }
    }
            
        stage('PUSH'){
            agent {label "buildah"}
            steps{
                sh 'sudo buildah push buildah-nginx docker://docker.io/manintheit/buildah-nginx:latest'
            }
        }
  }
}


