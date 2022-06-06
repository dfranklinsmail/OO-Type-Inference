Class {
	#name : #ParseSampleClass,
	#superclass : #Object,
	#category : #'OOTypeInference-Parser-Tests'
}

{ #category : #accessing }
ParseSampleClass >> start [
^ self.
]

{ #category : #accessing }
ParseSampleClass >> startWithLocalVars [

	| x y z |

]

{ #category : #accessing }
ParseSampleClass >> startWithLocalVarsAndExpressions [

	| x y z |
	x := 3.
	y := 4.
	z := 5.
	^x+y+z.
]

{ #category : #accessing }
ParseSampleClass >> startWithNoArgsOneExp [

	^ self
]

{ #category : #accessing }
ParseSampleClass >> startWithoutBody [
]
