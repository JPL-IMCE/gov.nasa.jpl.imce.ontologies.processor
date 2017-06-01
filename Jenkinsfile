node('imce-infr-dev-01.jpl.nasa.gov') {
	def img

	stage('Clone Repository') {
		checkout scm
	}	

	stage('Build Image') {
		img = docker.build("jplimce/gov.nasa.jpl.imce.ontologies.processor")
	}

	stage('Push Image') {

	}
}