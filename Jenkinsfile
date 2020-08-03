node {
    def app

    stage('Clone repository') {

        checkout scm
    }

    stage('Build image - Procentrica') {

        app = docker.build("procentricadocker/wso2apim")
    }

    stage('Test image - Procentrica') {
        
    }

    stage('Push image - Procentrica') {
        docker.withRegistry('https://registry.hub.docker.com', 'jenkinsprocentrica_dockerhub') {
            app.push("2.6.0")
            app.push("latest")
        }
    }

    stage('Build image - Krugercorp') {

        app = docker.build("wso2apim")
    }

    stage('Test image - Krugercorp') {
        
    }

    stage('Push image - Krugercorp') {
        docker.withRegistry('https://registry.krugercorp.co.za', 'jenkinsprocentrica_dockerhub') {
            app.push("2.6.0")
            app.push("latest")
        }
    }
}
