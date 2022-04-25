Class {
	#name : #ExpressionEvaluator,
	#superclass : #ExpressionGrammar,
	#category : #'OOTypeInference-Parser'
}

{ #category : #accessing }
ExpressionEvaluator >> add [
 ^ super add ==> [ :nodes | nodes first + nodes last ]
]

{ #category : #accessing }
ExpressionEvaluator >> asn [

	"What should an asn evaluate to?"

	"1. Add the left side to the environment with the value of the right? And return nil"

	"2. return the value of the right?"

	"3. something else"

	^ super asn ==> [ :nodes | nodes last ]
]

{ #category : #accessing }
ExpressionEvaluator >> mul [

	^ super mul ==> [ :nodes | nodes first * nodes last ]
]

{ #category : #accessing }
ExpressionEvaluator >> parens [

	^ super parens ==> [ :nodes | nodes second ]
]
