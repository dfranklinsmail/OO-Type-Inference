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
	^expression typeOf: (varname arrow: varname prependTo: env).

]

{ #category : #'as yet unclassified' }
Asn >> varname: aVarname expression: anExpression [
	varname := aVarname.
	expression := anExpression.
]
