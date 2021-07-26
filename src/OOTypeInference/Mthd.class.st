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
Mthd class >> new [
	^self basicNew statements: OrderedCollection new arguments: OrderedCollection new.
]

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

{ #category : #accessing }
Mthd >> statements [
	^statements 
]

{ #category : #accessing }
Mthd >> statements: someStatements arguments: someArguments [
	statements := someStatements.
	arguments := someArguments.
]

{ #category : #accessing }
Mthd >> typeOf: environment [
	"A Method's type is a TArror (a->b), where a is the type of the arguments and b is the results type"
	^TArrow type: (self typeOfArguments: environment) arrow: (self typeOfSteatments: environment).
	
]

{ #category : #accessing }
Mthd >> typeOfArguments: environment [
	arguments isEmpty ifTrue: [ ^ TVar newvar. ]
	ifFalse: [ arguments do: [ :arg | ^arg typeOf: environment. ] ]
]

{ #category : #accessing }
Mthd >> typeOfSteatments: environment [
	statements  isEmpty ifTrue: [ ^ TVar newvar. ]
	ifFalse: [ statements do: [ :exp | ^exp typeOf: environment. ] ]
	
]
