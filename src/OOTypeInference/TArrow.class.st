Class {
	#name : #TArrow,
	#superclass : #Typ,
	#instVars : [
		'argTypes',
		'typ2'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TArrow class >> argTypes: argTypes arrow: aTyp2 [ 
	^ self new argTypes: argTypes arrow: aTyp2 
]

{ #category : #'instance creation' }
TArrow class >> type: argTypes arrow: aTyp2 [ 
	^ self new type: argTypes arrow: aTyp2 
]

{ #category : #comparing }
TArrow >> addTypeMap: aToyTyp to: aMap [
	self class = aToyTyp class ifFalse: [ ^ aToyTyp addTypeMap: self to: aMap ].
	^ (argTypes addTypeMap: aToyTyp argTypes to: aMap) and: [
			typ2 addTypeMap: aToyTyp typ2 to: aMap
		]
]

{ #category : #accessing }
TArrow >> argTypes [
	^ argTypes
]

{ #category : #accessing }
TArrow >> argTypes: someArgTypes arrow: aTyp2 [
	argTypes := someArgTypes.
	typ2 := aTyp2.

]

{ #category : #printing }
TArrow >> gen [
	"what does gen do?"
	TArrow type: (argTypes collect: [:typ | typ gen]) arrow: (typ2 gen).
	
]

{ #category : #comparing }
TArrow >> isSameType: aToyTyp env: aEnv [
	"check if the passed in type is a ToyTArrow"
	| aArgsList |
	"ask the nonTArrow aToyTyp if they are the same type."
	aToyTyp isTArrow ifFalse: [ ^ aToyTyp isSameType: self env: aEnv ].
	
	"verifty the args to the methods have the same types"
	aArgsList := aToyTyp argTypes.
	(((aArgsList isCollection)
							   and: (argTypes size = aArgsList size))
							   and: (argTypes isSameTypes: aArgsList env: aEnv))
	ifTrue: [
		"verify the return is the same type"
		argTypes with: aArgsList do: [:argTyp1 :argTyp2 | argTyp1 addTypeMap: argTyp2 to: aEnv.].
		^typ2 isSameType: aToyTyp typ2 env: aEnv.
	].

^false
]

{ #category : #printing }
TArrow >> isTArrow [
	^ true.
	
]

{ #category : #printing }
TArrow >> printNestedOn: aStream [
	aStream nextPut: $(.
	argTypes do: [ :typ | typ printOn: aStream].
	aStream nextPutAll: ' -> '.
	typ2 printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #printing }
TArrow >> printOn: aStream [
	aStream nextPutAll: ' [ '.
	argTypes do: [ :typ | typ printOn: aStream. aStream nextPutAll: ' '.].
	aStream nextPutAll: ' ] '.
	aStream nextPutAll: ' -> '.
	typ2 printNestedOn: aStream.

	
]

{ #category : #accessing }
TArrow >> typ2 [
	^ typ2
]

{ #category : #accessing }
TArrow >> type: someArgTypes arrow: aTyp2 [
	argTypes := someArgTypes.
	typ2 := aTyp2.

]

{ #category : #'type unification' }
TArrow >> unify: aTyp with: someArgTypes arrow: aTyp2 [
	someArgTypes unify: argTypes.
	aTyp2 unify: typ2.

]

{ #category : #'type unification' }
TArrow >> unifyWith: aTyp [
	aTyp unify: self with: argTypes arrow: typ2.

]
