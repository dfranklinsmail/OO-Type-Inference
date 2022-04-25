Class {
	#name : #ExpressionPrinter,
	#superclass : #ExpressionGrammar,
	#category : #'OOTypeInference-Parser'
}

{ #category : #accessing }
ExpressionPrinter >> add [

	^ super add ==> [ :nodes | nodes first , '+' , nodes third ]
]

{ #category : #accessing }
ExpressionPrinter >> mul [

	^ super mul ==> [ :nodes | nodes first , '*' , nodes third ]
]

{ #category : #accessing }
ExpressionPrinter >> number [

	^ super number ==> [ :num | num printString ]
]

{ #category : #accessing }
ExpressionPrinter >> parens [

	^ super parens ==> [ :nodes | '(', nodes second, ')' ]
]
