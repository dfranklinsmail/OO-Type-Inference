Class {
	#name : #ExpressionEvaluatorTest,
	#superclass : #ExpressionGrammarTest,
	#category : #'OOTypeInference-Parser-Tests'
}

{ #category : #accessing }
ExpressionEvaluatorTest >> parserClass [

	^ ExpressionEvaluator
]

{ #category : #accessing }
ExpressionEvaluatorTest >> testASN [

	super testASN.
	self assert: result equals: 105
]

{ #category : #accessing }
ExpressionEvaluatorTest >> testAdd [ 
super testAdd.
self assert: result equals:200
]

{ #category : #accessing }
ExpressionEvaluatorTest >> testArgs [

	super testArgs.
	self assert: result equals: #('x' 'y' 'z')
]

{ #category : #accessing }
ExpressionEvaluatorTest >> testNumber [

	super testNumber.
	self assert: result equals: 123
]

{ #category : #accessing }
ExpressionEvaluatorTest >> testRtn [

	super testRtn.
	self assert: result equals: #self
]
