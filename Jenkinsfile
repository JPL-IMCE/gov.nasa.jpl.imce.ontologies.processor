node('IMCE') {
	stage('Clone Repository') {
		checkout scm
	}	

	stage('Setup Tools') {
		withCredentials([[$class: 'UsernamePasswordMultiBinding',
						  credentialsId: 'IMCE-CI',
						  usernameVariable: 'USERNAME',
						  passwordVariable: 'PASSWORD']]) {

			sh './gradlew extractTools -PartifactoryUser=$USERNAME -PartifactoryPassword=$PASSWORD'
	 	}	
	}

	stage('Build Docker Image') {
		def app = docker.build "jplimce/gov.nasa.jpl.imce.ontologies.processor"
	}

	stage('Push Image') {

	}
}