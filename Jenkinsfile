node {
	stage('Clone Repository') {
		checkout scm
	}	

	stage('Setup Tools') {
		sh 'gradle extractTools'
	}

	stage('Build Docker Image') {
		sh 'sudo docker build -t jplimce/gov.nasa.jpl.imce.ontologies.processor'
	}

	stage('Push Image') {

	}
}