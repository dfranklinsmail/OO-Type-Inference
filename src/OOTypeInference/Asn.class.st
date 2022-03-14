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
	env at: varname put: (TVar tv: typeOfExp). "TODO: does this make sense? or should I call class?"
															"TODO: is the nesting of the type into a TVar necessary?"
	self flag: #TODO.
	^TVar tv: typeOfExp.


]

{ #category : #'as yet unclassified' }
Asn >> varname: aVarname expression: anExpression [
	varname := aVarname.
	expression := anExpression.
]
