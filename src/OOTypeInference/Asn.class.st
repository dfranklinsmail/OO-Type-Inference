Class {
	#name : #Asn,
	#superclass : #Exp,
	#instVars : [
		'varname',
		'expression'
	],
	#category : #'OOTypeInference-Language'
}

{ #category : #'as yet unclassified' }
Asn class >> varname: aVarname expression: anExpression [
	^self new varname: aVarname expression: anExpression
]

{ #category : #'as yet unclassified' }
Asn >> typeOf: env [
	| typeOfExp |
	typeOfExp := expression typeOf: env.
	env at: varname put: typeOfExp. "does this make sense? or should I call class?"
	^TVar tv: typeOfExp.


]

{ #category : #'as yet unclassified' }
Asn >> varname: aVarname expression: anExpression [
	varname := aVarname.
	expression := anExpression.
]
