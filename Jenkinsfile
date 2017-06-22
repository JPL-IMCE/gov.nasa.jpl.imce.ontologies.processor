pipeline {
	agent {
		label 'IMCE'
	}

	environment {
        DOCKER_EMAIL = 'rcastill@jpl.nasa.gov'
    }
    
	stages {
		stage('Clone Repositories') {
		steps {
			checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'fuseki']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.fuseki']]])
			checkout([$class: 'GitSCM', branches: [[name: 'feature/IMCEIS-1350-adapt-ontologies-public-and-ontologi']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'workflow']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.workflow']]])
			checkout([$class: 'GitSCM', branches: [[name: 'feature/IMCEIS-1352-adapt-ontologies-workflow-for-CAESAR']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'analysis']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.analysis']]])
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
		    	script {
		    		docker.build("jplimce/gov.nasa.jpl.imce.ontologies.processor:0.1.3-caesar_demo");
				}
			}
		}

		stage('Push Docker Image') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding',
						  credentialsId: 'IMCE-Docker-Hub',
						  usernameVariable: 'DOCKER_USERNAME',
						  passwordVariable: 'DOCKER_PASSWORD']]) {
					sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD -e $DOCKER_EMAIL; docker push jplimce/gov.nasa.jpl.imce.ontologies.processor:0.1.3-caesar_demo'
	 			}	
			}
		}
	}
}