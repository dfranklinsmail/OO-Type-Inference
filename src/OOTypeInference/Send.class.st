Class {
	#name : #Send,
	#superclass : #Exp,
	#instVars : [
		'target',
		'selector',
		'arguments'
	],
	#category : #'OOTypeInference-Language'
}

{ #category : #'as yet unclassified' }
Send class >> target: aTarget selector: aMethodSelector arguments: argList [
	^self new target: aTarget selector: aMethodSelector arguments: argList
]

{ #category : #accessing }
Send >> arguments: argList [
	arguments := argList.
]

{ #category : #accessing }
Send >> selector: aSelector [
	selector := aSelector.
]

{ #category : #accessing }
Send >> target: aTarget [
	target := aTarget.
]

{ #category : #accessing }
Send >> target: aTarget selector: aMethodSelector arguments: argList [
	selector := aMethodSelector.
	target := aTarget.
	arguments := argList.
]

{ #category : #accessing }
Send >> typeOf: environment [
	"A Sens's type is a TInterface with a possibly empty collection of selectors"
	| typeOf |
	environment at: self 
		ifPresent: [ "should we do anything here? Should we unify the value in the environment with the latest typeof"
						 ^environment at:self. ] 
		ifAbsentPut: [ typeOf := TInterface new.
							typeOf addSelector: selector.
							environment at: self put: typeOf].
		
	^environment at:self.
]
