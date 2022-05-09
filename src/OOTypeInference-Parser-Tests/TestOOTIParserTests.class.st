Class {
	#name : #TestOOTIParserTests,
	#superclass : #PPCompositeParserTest,
	#category : #'OOTypeInference-Parser-Tests'
}

{ #category : #tests }
TestOOTIParserTests >> parserClass [

	^ ExpressionGrammar
]

{ #category : #tests }
TestOOTIParserTests >> testParseSampleClass [

	| startMethod startMethodNodes |
	startMethod := (ParseSampleClass >> #startWithoutBody) ast.

	startMethodNodes := self parse: startMethod sourceCode rule: #method.
	self assert: (startMethodNodes at: 1) equals: #startWithoutBody.
	self assert: (startMethodNodes at: 2) equals: ''.
]

{ #category : #tests }
TestOOTIParserTests >> testParseSampleClassMethodReturnSelf [

	| startMethod startMethodNodes |
	startMethod := (ParseSampleClass >> #startWithNoArgsOneExp) ast.

	startMethodNodes := self parse: startMethod sourceCode rule: #method.
	self assert: (startMethodNodes at: 1) equals: #startWithNoArgsOneExp.
	self assert: (((startMethodNodes at: 2) at: 1) at: 1) equals: $^.
	self assert: (((startMethodNodes at: 2) at: 1) at: 2) equals: #self
]

{ #category : #tests }
TestOOTIParserTests >> testParseSampleClassMethodWithLocalVars [

	| startMethod startMethodNodes |
	startMethod := (ParseSampleClass >> #startWithLocalVars) ast.

	startMethodNodes := self parse: startMethod sourceCode rule: #method.
	self assert: (startMethodNodes at: 1) equals: #startWithoutBody.
	self assert: (startMethodNodes at: 2) equals: ''
]

{ #category : #tests }
TestOOTIParserTests >> testParseSampleClassMethodWithoutBody [

	| startMethod startMethodNodes |
	startMethod := (ParseSampleClass >> #startWithoutBody) ast.

	startMethodNodes := self parse: startMethod sourceCode rule: #method.
	self assert: (startMethodNodes at: 1) equals: #startWithoutBody.
	self assert: (startMethodNodes at: 2) equals: ''
]
