Class {
	#name : #TestPititParser,
	#superclass : #TestCase,
	#category : #'OOTypeInference-Parser-Tests'
}

{ #category : #tests }
TestPititParser >> testExpressionEvaluator [

	| parser |
	parser := ExpressionEvaluator new.
	self assert: (parser parse: '1 + 2 * 3') equals: 7.
	self assert: (parser parse: '(1 + 2) * 3') equals: 9
]

{ #category : #tests }
TestPititParser >> testExpressionGrammer [
| parser |
	parser := ExpressionGrammar new.
	parser parse: '1 + 2 * 3'.
	parser parse: '(1+2)*3'
]

{ #category : #tests }
TestPititParser >> testExpressionPrinter [
| parser |
	parser := ExpressionPrinter new.

	parser parse: '1 + 2 * 3'.
	parser parse: '(1 + 2) * 3'
]

{ #category : #tests }
TestPititParser >> testIdentifierParser [

	| identifier identifier2 |

	identifier := #letter asParser , #word asParser star.
	identifier parse: 'a987jlkj'.
	
	identifier matchingSkipRangesIn: 'foo 123 bar12'. "an OrderedCollection((1 to: 3) (9 to: 13))"
	
	identifier2 := #letter asParser , (#letter asParser / #digit asParser) star.
	identifier2 parse: 'a987jlkj'.
]
