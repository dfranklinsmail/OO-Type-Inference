Class {
	#name : #TArrow,
	#superclass : #Typ,
	#instVars : [
		'typ1',
		'typ2'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TArrow class >> type: aTyp1 arrow: aTyp2 [ 
	^ self new type: aTyp1 arrow: aTyp2 
]

{ #category : #comparing }
TArrow >> addTypeMap: aToyTyp to: aMap [
	self class = aToyTyp class ifFalse: [ ^ aToyTyp addTypeMap: self to: aMap ].
	^ (typ1 addTypeMap: aToyTyp typ1 to: aMap) and: [
			typ2 addTypeMap: aToyTyp typ2 to: aMap
		]
]

{ #category : #printing }
TArrow >> gen [
	TArrow type: (typ1 gen) arrow: (typ2 gen).
	
]

{ #category : #comparing }
TArrow >> isSameType: aToyTyp env: aEnv [
	"check if the passed in type is a ToyTArrow"
	aToyTyp isTArrow ifFalse: [ ^ aToyTyp isSameType: self env: aEnv "ask the nonTArrow aToyTyp if they are the same type."].
	
	((typ1 isCollection) and: (aToyTyp typ1 isCollection)) ifTrue: [
		(typ1 isSameTypes: (aToyTyp typ1) env: aEnv) ifTrue: [
			^typ2 isSameType: aToyTyp typ2 env: aEnv.
		] ifFalse: [^false.]
	]
	ifFalse: [
	^ (typ1 addTypeMap: aToyTyp typ1 to: aEnv) and: [
			typ2 isSameType: aToyTyp typ2 env: aEnv
		]
	] 
]

{ #category : #printing }
TArrow >> isTArrow [
	^ true.
	
]

{ #category : #printing }
TArrow >> printNestedOn: aStream [
	aStream nextPut: $(.
	typ1 printOn: aStream.
	aStream nextPutAll: ' -> '.
	typ2 printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #printing }
TArrow >> printOn: aStream [
	typ1 printNestedOn: aStream.
	aStream nextPutAll: ' -> '.
	typ2 printNestedOn: aStream.

	
]

{ #category : #accessing }
TArrow >> typ1 [
	^ typ1
]

{ #category : #accessing }
TArrow >> typ2 [
	^ typ2
]

{ #category : #accessing }
TArrow >> type: aTyp1 arrow: aTyp2 [
	typ1 := aTyp1.
	typ2 := aTyp2.

]

{ #category : #'type unification' }
TArrow >> unify: aTyp with: aTyp1 arrow: aTyp2 [
	aTyp1 unify: typ1.
	aTyp2 unify: typ2.

]

{ #category : #'type unification' }
TArrow >> unifyWith: aTyp [
	aTyp unify: self with: typ1 arrow: typ2.

]
