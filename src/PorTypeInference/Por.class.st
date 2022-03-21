Class {
	#name : #Por,
	#superclass : #Exp,
	#instVars : [
		'leftExp',
		'rightExp'
	],
	#category : #PorTypeInference
}

{ #category : #'instance creation' }
Por class >> left: exp1 right: exp2 [
^self new left: exp1 right: exp2.
]

{ #category : #'instance creation' }
Por >> left: exp1 right: exp2 [
leftExp := exp1.
rightExp := exp2.
]
