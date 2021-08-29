Class {
	#name : #Send,
	#superclass : #Exp,
	#instVars : [
		'target',
		'selector',
		'arguments'
	],
	#category : #'OOTypeInference-Language'
}

{ #category : #accessing }
Send >> selector: aSelector [
	selector := aSelector.
]

{ #category : #accessing }
Send >> target: aTarget [
	target := aTarget.
]
