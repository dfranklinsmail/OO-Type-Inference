Class {
	#name : #TMthd,
	#superclass : #TArrow,
	#instVars : [
		'selector'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #initialization }
TMthd class >> selector: selector type: aTyp1 arrow: aTyp2 [
	^ self new selector: selector type: aTyp1 arrow: aTyp2.
]

{ #category : #accessing }
TMthd >> isSameType: aToyTyp env: aEnv [
	"check if the passed in type is a ToyTArrow"
	aToyTyp isTMthd ifFalse: [ ^ aToyTyp isSameType: self env: aEnv "ask the nonTArrow aToyTyp if they are the same type."].
	
	^(selector = aToyTyp selector) and: (super isSameType: aToyTyp env: aEnv).
	
]

{ #category : #accessing }
TMthd >> isTMthd [
	^true.
]

{ #category : #accessing }
TMthd >> selector [
	^selector.
]

{ #category : #accessing }
TMthd >> selector: aSelector type: aTyp1 arrow: aTyp2 [
	selector := aSelector.
	self type: aTyp1 arrow: aTyp2.
]
