Class {
	#name : #Cls,
	#superclass : #Exp,
	#instVars : [
		'methods',
		'variables',
		'selector'
	],
	#category : #'OOTypeInference-LanguageValues'
}

{ #category : #accessing }
Cls >> addMethod: method [
	methods = nil ifTrue: [ methods := OrderedCollection new. ].
	methods add: method.
]

{ #category : #accessing }
Cls >> typeOf: environment [
	^ TCls new.
]
