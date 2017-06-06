node {
	def img

	stage('Clone Repository') {
		checkout scm
	}	
	stage('Start docker') {
		sh 'ps -ef | grep docker'
	}
	stage('Build Image') {
		img = docker.build("jplimce/gov.nasa.jpl.imce.ontologies.processor")
	}
	stage('Push Image') {

	}
}