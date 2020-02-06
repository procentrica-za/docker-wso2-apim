node {
    def app

    stage('Clone repository') {

        checkout scm
    }

    stage('Build image') {

        app = docker.build("procentricadocker/wso2apim")
    }

    stage('Test image') {
        
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'jenkinsprocentrica_dockerhub') {
            app.push("2.6.0")
            app.push("latest")
        }
    }
}
