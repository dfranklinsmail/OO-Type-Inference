Class {
	#name : #ExpressionPrinterTest,
	#superclass : #ExpressionGrammarTest,
	#category : #'OOTypeInference-Parser-Tests'
}

{ #category : #accessing }
ExpressionPrinterTest >> parserClass [ 
^ExpressionPrinter 
]

{ #category : #accessing }
ExpressionPrinterTest >> testAdd [

	super testAdd. self assert: result equals: '123+77'
]

{ #category : #accessing }
ExpressionPrinterTest >> testNumber [

	super testNumber.
	self assert: result equals: '123'
]

{ #category : #accessing }
ExpressionPrinterTest >> testRtn [

	super testRtn.
	self assert: result equals: '^ self'
]
