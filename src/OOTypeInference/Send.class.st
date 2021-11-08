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

{ #category : #accessing }
Send >> selector: aSelector [
	selector := aSelector.
]

{ #category : #accessing }
Send >> target: aTarget [
	target := aTarget.
]

{ #category : #accessing }
Send >> typeOf: environment [
	"A Sens's type is a TInterface with a possibly empty collection of selectors"
	| typeOf |
	environment at: self 
		ifPresent: [ "should we do anything here? Should we unify the value in the environment with the latest typeof"
						 ^environment at:self. ] 
		ifAbsentPut: [ typeOf := TInterface new.
							environment at: self put: typeOf].
		
	^environment at:self.
]
