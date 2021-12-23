Class {
	#name : #TMthd,
	#superclass : #TArrow,
	#instVars : [
		'selector'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TMthd class >> selector: selector type: aTyp1 arrow: aTyp2 [
	^ self new selector: selector; type: aTyp1 arrow: aTyp2.
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
TMthd >> printOn: aStream [
	aStream nextPutAll: selector, ' FOR: '.
	super printOn: aStream
]

{ #category : #accessing }
TMthd >> selector [
	^selector.
]

{ #category : #accessing }
TMthd >> selector: aSelector [
	selector := aSelector.
]

{ #category : #accessing }
TMthd >> selector: aSelector type: aTyp1 arrow: aTyp2 [
	selector := aSelector.
	self type: aTyp1 arrow: aTyp2.
]

{ #category : #accessing }
TMthd >> unifyWith: aTMthd [
	aTMthd isTMthd ifFalse: [ ^ Error new. ].
	selector = aTMthd selector ifFalse: [ ^Error new. ].
	
]
