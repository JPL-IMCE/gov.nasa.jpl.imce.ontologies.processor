node('IMCE') {
	stage('Clone Repository') {
		checkout scm
	}	

	stage('Setup Tools') {
		withCredentials([[$class: 'UsernamePasswordMultiBinding',
						  credentialsId: 'IMCE-CI',
						  usernameVariable: 'USERNAME',
						  passwordVariable: 'PASSWORD']]) {

			sh 'gradle extractTools -PartifactoryUser=$USERNAME -PartifactoryPassword=$PASSWORD'
	 	}	
	}

	stage('Build Docker Image') {
		sh 'sudo docker build -t jplimce/gov.nasa.jpl.imce.ontologies.processor'
	}

	stage('Push Image') {

	}
}