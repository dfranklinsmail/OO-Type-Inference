Class {
	#name : #Mthd,
	#superclass : #Object,
	#instVars : [
		'arguments',
		'statements',
		'selector'
	],
	#category : #'OOTypeInference-Language'
}

{ #category : #'as yet unclassified' }
Mthd class >> new [
	^self basicNew statements: OrderedCollection new arguments: OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Mthd class >> selector: aSelector arguments: listOfArguments [
	"Creates a new method with the given anme and list of arguments"	
	^self new selector: aSelector; setArguments:  listOfArguments
]

{ #category : #accessing }
Mthd >> addArgument: anArgument [
	arguments add: anArgument.
	
]

{ #category : #accessing }
Mthd >> addStatement: aStatement [
	statements add: aStatement.
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
Mthd >> setArguments: someArguments [
	arguments := someArguments.
	
]

{ #category : #accessing }
Mthd >> statements: someStatements arguments: someArguments [
	statements := someStatements.
	arguments := someArguments.
]

{ #category : #accessing }
Mthd >> typeOf: environment [
	"A Method's type is a TArror (a->b), where a is the type of the arguments and b is the results type"
	^TMthd selector: selector type: (self typeOfArguments: environment) arrow: (self typeOfSteatments: environment).
]

{ #category : #accessing }
Mthd >> typeOfArguments: environment [
	^arguments collect: [ :exp | exp typeOf: environment. ].
]

{ #category : #accessing }
Mthd >> typeOfSteatments: environment [
	| result |
	"the type of the statments can,
	 - have a number of side effect
			1. assign values to class variables
			2. send messages to arguments, resulting in method calls of other classes
	 - will return one or more types."
	statements  isEmpty ifTrue: [ ^ TCls class: (self class). ] "This should return the type of self, and return it as a list!"
	ifFalse: [ statements do: [ :exp | result := exp typeOf: environment. ] ]. "This should return a list and not just the result of the last type, muliple returns are possible."
	^result.
]
