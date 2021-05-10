Class {
	#name : #TITest,
	#superclass : #TestCase,
	#category : #'OOTypeInference-Tests'
}

{ #category : #asserting }
TITest >> assert: actual equals: expected [ 
	self assert: (actual isSameType: expected env: IdentityDictionary new)
			description: [self comparingStringBetween: actual and: expected]
]

{ #category : #asserting }
TITest >> deny: actual equals: expected [ 
	self deny: (actual isSameType: expected env: IdentityDictionary new)
			description: [self comparingStringBetween: actual and: expected]
]

{ #category : #running }
TITest >> setUp [
	super setUp.
	TVUnbound initialize.

]
