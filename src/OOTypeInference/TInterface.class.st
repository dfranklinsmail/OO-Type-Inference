Class {
	#name : #TInterface,
	#superclass : #Typ,
	#instVars : [
		'selectors'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'as yet unclassified' }
TInterface >> addSelector: aSelector [
	selectors add: aSelector.
]

{ #category : #'as yet unclassified' }
TInterface >> isTInterface [
	^ true.
]
