Class {
	#name : #Rtrn,
	#superclass : #Exp,
	#instVars : [
		'expression'
	],
	#category : #'OOTypeInference-Language'
}

{ #category : #'as yet unclassified' }
Rtrn class >> exp: anExpression [
	^self new exp: anExpression.
]

{ #category : #'as yet unclassified' }
Rtrn >> exp: anExpression [
	expression := anExpression.
]

{ #category : #'as yet unclassified' }
Rtrn >> typeOf: environment [
	^expression typeOf: environment.
]
