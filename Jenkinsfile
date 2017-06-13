pipeline {
	agent {
		label 'IMCE'
	}
	stages {
	stage('Clone Repository') {
		steps {
			checkout scm
		}
	}	

	stage('Setup Tools') {
		steps {
		withCredentials([[$class: 'UsernamePasswordMultiBinding',
						  credentialsId: 'IMCE-CI',
						  usernameVariable: 'USERNAME',
						  passwordVariable: 'PASSWORD']]) {

			sh './gradlew clean extractTools -PartifactoryUser=$USERNAME -PartifactoryPassword=$PASSWORD'
	 	}	
	 	}
	}

	stage('Build Docker Image') {
		steps {
		        timeout(time: 30, unit: 'MINUTES') {
					sh returnStdout: true, script: 'sudo docker build -t jplimce/gov.nasa.jpl.imce.ontologies.processor .'
                }
		}
	}

	stage('Push Image') {
		steps {
			echo 'Pushing!'
		}
	}
	}
}