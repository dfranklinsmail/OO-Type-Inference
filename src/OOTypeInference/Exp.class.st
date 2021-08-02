"
Implementing Remy's Type inference from http://okmij.org/ftp/ML/generalization.html
"
Class {
	#name : #Exp,
	#superclass : #Stmnt,
	#category : #'OOTypeInference-Language'
}

{ #category : #'as yet unclassified' }
Exp >> newvar [
	^ TVar newvar
]
