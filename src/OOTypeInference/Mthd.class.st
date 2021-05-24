Class {
	#name : #Mthd,
	#superclass : #Exp,
	#instVars : [
		'arguments',
		'statements',
		'selector'
	],
	#category : #'OOTypeInference-LanguageValues'
}

{ #category : #'as yet unclassified' }
Mthd class >> selector: aSelector arguments: listOfArguments [
	"Creates a new method with the given anme and list of arguments"	
	^self new selector: aSelector.
]

{ #category : #accessing }
Mthd >> selector [
	^selector
]

{ #category : #accessing }
Mthd >> selector: aSelector [
	selector := aSelector.
]
