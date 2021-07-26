Class {
	#name : #Int,
	#superclass : #Exp,
	#instVars : [
		'varname'
	],
	#category : #'OOTypeInference-LanguageValues'
}

{ #category : #accessing }
Int >> printOn: aStream [
	aStream nextPutAll: ' Int '.
]

{ #category : #accessing }
Int >> typeOf: environment [
	^ TCls class: (self class).
]
