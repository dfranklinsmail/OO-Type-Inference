Class {
	#name : #ExpressionGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'prod',
		'term',
		'prim',
		'number',
		'add',
		'mul',
		'parens',
		'asn',
		'identifier',
		'exp',
		'boolean',
		'selector',
		'snd',
		'arg',
		'new'
	],
	#category : #'OOTypeInference-Parser'
}

{ #category : #grammar }
ExpressionGrammar >> add [

	^ prod , $+ asParser trim , term
]

{ #category : #grammar }
ExpressionGrammar >> arg [

	^ #letter asParser plus flatten trim / #digit asParser plus flatten trim
]

{ #category : #grammar }
ExpressionGrammar >> asn [

	^ identifier , $= asParser trim , exp
]

{ #category : #grammar }
ExpressionGrammar >> boolean [

	^ #word asParser trim matches: 'true'
]

{ #category : #grammar }
ExpressionGrammar >> exp [

	^ new / identifier / snd / add
]

{ #category : #grammar }
ExpressionGrammar >> identifier [

	^ #letter asParser plus flatten trim
]

{ #category : #grammar }
ExpressionGrammar >> mul [

	^ prim , $* asParser trim , prod
]

{ #category : #grammar }
ExpressionGrammar >> new [

	^ 'new' asParser , identifier
]

{ #category : #grammar }
ExpressionGrammar >> number [
^#digit asParser plus flatten trim ==> [ :str | str asNumber ]
]

{ #category : #grammar }
ExpressionGrammar >> parens [ 

^ $( asParser trim, term, $) asParser trim
]

{ #category : #grammar }
ExpressionGrammar >> prim [

	^ parens / number
]

{ #category : #grammar }
ExpressionGrammar >> prod [

	^ mul / prim
]

{ #category : #grammar }
ExpressionGrammar >> selector [

	^ identifier , $: asParser , arg / identifier 
]

{ #category : #grammar }
ExpressionGrammar >> snd [

	^ identifier , selector
]

{ #category : #grammar }
ExpressionGrammar >> start [

	^ term end
]

{ #category : #grammar }
ExpressionGrammar >> term [

	^ add / prod / asn / boolean / snd / arg
]
