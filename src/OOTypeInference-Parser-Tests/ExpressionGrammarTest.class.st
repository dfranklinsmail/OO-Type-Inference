Class {
	#name : #ExpressionGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #'OOTypeInference-Parser-Tests'
}

{ #category : #accessing }
ExpressionGrammarTest >> parserClass [ 

	^ ExpressionGrammar
]

{ #category : #accessing }
ExpressionGrammarTest >> testASN [

	self parse: 'x = 100 + 5' rule: #asn
]

{ #category : #accessing }
ExpressionGrammarTest >> testASN_cannotASN_to_ASN [

	self parse: 'y = x = 100 + 5' rule: #asn
]

{ #category : #accessing }
ExpressionGrammarTest >> testAdd [

	self parse: '123+77' rule: #add
]

{ #category : #accessing }
ExpressionGrammarTest >> testArgs [

	self parse: '| x y z |' rule: #args
]

{ #category : #accessing }
ExpressionGrammarTest >> testBoolean [

	self parse: 'true' rule: #boolean
]

{ #category : #accessing }
ExpressionGrammarTest >> testExpNew [

	self parse: 'new classname' rule: #exp
]

{ #category : #accessing }
ExpressionGrammarTest >> testExpSnd [

	self parse: 'new classname' rule: #exp
]

{ #category : #accessing }
ExpressionGrammarTest >> testNew [

	self parse: 'new classname' rule: #new
]

{ #category : #accessing }
ExpressionGrammarTest >> testNumber [

	self parse: '123' rule: #number
]

{ #category : #accessing }
ExpressionGrammarTest >> testRtn [

	self parse: '^ self' rule: #rtn
]

{ #category : #accessing }
ExpressionGrammarTest >> testSelector [

	self parse: 'methodName' rule: #selector
]

{ #category : #accessing }
ExpressionGrammarTest >> testSelectorWithArg [

	self parse: 'methodName: value' rule: #selector
]

{ #category : #accessing }
ExpressionGrammarTest >> testSend [

	self parse: 'x methodName' rule: #snd
]

{ #category : #accessing }
ExpressionGrammarTest >> testSendWithArg [

	self parse: 'x methodName: 123' rule: #snd
]
