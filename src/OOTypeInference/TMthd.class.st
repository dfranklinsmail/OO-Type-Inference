Class {
	#name : #TMthd,
	#superclass : #TArrow,
	#instVars : [
		'selector',
		'returnType',
		'parentTCls'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TMthd class >> selector: selector arguments: args result: aTyp [

	^ self new
		  selector: selector;
		  returnType: aTyp;
		  type: args arrow: aTyp
]

{ #category : #'instance creation' }
TMthd class >> selector: selector result: aTyp [

	^ self new
		  selector: selector;
		  returnType: aTyp;
		  type: OrderedCollection new arrow: aTyp
]

{ #category : #accessing }
TMthd >> argumentTypes [

	^ argTyps
]

{ #category : #accessing }
TMthd >> equals: aType [

	aType isTMthd ifFalse: [ ^ false ].
	^ aType returnType equals: returnType
]

{ #category : #accessing }
TMthd >> isSameType: aTTyp [

	"check if the passed in type is a ToyTArrow"
	aTTyp isTMthd ifFalse: [ 
		^ aTTyp isSameType: self "ask the nonTArrow aToyTyp if they are the same type." ].

	^ selector = aTTyp selector and: (super isSameType: aTTyp)
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
TMthd >> parentTCls [
	^parentTCls
]

{ #category : #accessing }
TMthd >> parentTCls: aTCls [
	parentTCls := aTCls 
]

{ #category : #accessing }
TMthd >> printOn: aStream [
	aStream nextPutAll: selector , ' FOR: '.
	super printOn: aStream
]

{ #category : #accessing }
TMthd >> returnType [

	^ returnType
]

{ #category : #accessing }
TMthd >> returnType: aType [

	returnType := aType.
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
TMthd >> selector: aSelector arguments: args result: aTyp [

	selector := aSelector.
	self type: args arrow: aTyp
]

{ #category : #accessing }
TMthd >> unifyWith: aTMthd [
	aTMthd isTMthd ifFalse: [ ^ Error new. ].
	selector = aTMthd selector ifFalse: [ ^Error new. ].
	argTyps size = aTMthd argTyps size ifFalse: [ ^ Error new. ].
	argTyps with: aTMthd argTyps do: [ :argA :argB | argA unifyWith: argB ].
	resultTyp unifyWith: aTMthd resultTyp. 
	^self.
]
