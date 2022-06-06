Class {
	#name : #TArrow,
	#superclass : #Typ,
	#instVars : [
		'argTypes',
		'resultTyp'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TArrow class >> argTypes: argTypes arrow: aTyp2 [ 
	^ self new argTypes: argTypes arrow: aTyp2 
]

{ #category : #'instance creation' }
TArrow class >> type: argTypes arrow: aTyp2 [ 

	| temp |
	argTypes isCollection 
				ifTrue: [ temp := argTypes. ]
				ifFalse: [ temp := OrderedCollection new.
				  			  temp add: argTypes.].
	^ self new type: temp arrow: aTyp2 
]

{ #category : #comparing }
TArrow >> addTypeMap: aToyTyp to: aMap [
	self class = aToyTyp class ifFalse: [ ^ aToyTyp addTypeMap: self to: aMap ].
	argTypes with: (aToyTyp argTypes) do: [:argTyp1 :argTyp2 | argTyp1 addTypeMap: argTyp2 to: aMap.].
	resultTyp addTypeMap: aToyTyp resultTyp to: aMap.
		
]

{ #category : #accessing }
TArrow >> argTypes [
	^ argTypes
]

{ #category : #accessing }
TArrow >> argTypes: someArgTypes arrow: aTyp2 [
	argTypes := someArgTypes.
	resultTyp := aTyp2.

]

{ #category : #printing }
TArrow >> gen [
	"what does gen do?"
	TArrow type: (argTypes collect: [:typ | typ gen]) arrow: (resultTyp gen).
	
]

{ #category : #comparing }
TArrow >> isSameType: aToyTyp [

	"check if the passed in type is a ToyTArrow"

	| aArgsList |
	"ask the nonTArrow aToyTyp if they are the same type."
	aToyTyp isTArrow ifFalse: [ ^ aToyTyp isSameType: self ].

	"verifty the args to the methods have the same types"
	aArgsList := aToyTyp argTypes.
	(aArgsList isCollection and: argTypes size = aArgsList size) ifTrue: [ 
		argTypes with: aArgsList do: [ :argA :argB | 
			(argA isSameType: argB ) ifFalse: [ 
				TypeMismatch signal: 'the types are not the same' ] ].
		
		"verify the return type typ2 and aToyTyp typ2 has the same type"
		^ resultTyp isSameType: aToyTyp resultTyp].

	^ false
]

{ #category : #comparing }
TArrow >> isSameType: aToyTyp env: aEnv [

	"check if the passed in type is a ToyTArrow"

	| aArgsList |
	"ask the nonTArrow aToyTyp if they are the same type."
	aToyTyp isTArrow ifFalse: [ ^ aToyTyp isSameType: self env: aEnv ].

	"verifty the args to the methods have the same types"
	aArgsList := aToyTyp argTypes.
	(aArgsList isCollection and: argTypes size = aArgsList size) ifTrue: [ 
		argTypes with: aArgsList do: [ :argA :argB |
			(argA isSameType: argB env: aEnv) ifFalse: [ TypeMismatch signal: 'the types are not the same'] ].
		"add the arguments to the enrvironment"
		argTypes
			with: aArgsList
			do: [ :argTyp1 :argTyp2 | argTyp1 addTypeMap: argTyp2 to: aEnv ].
		"verify the return type typ2 and aToyTyp typ2 has the same type"
		^ resultTyp isSameType: aToyTyp resultTyp env: aEnv ].

	^ false
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
	resultTyp printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #printing }
TArrow >> printOn: aStream [
	aStream nextPutAll: ' [ '.
	argTypes do: [ :typ | typ printOn: aStream. aStream nextPutAll: ' '.].
	aStream nextPutAll: ' ] '.
	aStream nextPutAll: ' -> '.
	resultTyp printNestedOn: aStream.

	
]

{ #category : #accessing }
TArrow >> resultTyp [
	^ resultTyp
]

{ #category : #accessing }
TArrow >> type: someArgTypes arrow: aTyp2 [
	argTypes := someArgTypes.
	resultTyp := aTyp2.

]

{ #category : #'type unification' }
TArrow >> unify: aTyp with: someArgTypes arrow: aTyp2 [
	someArgTypes unify: argTypes.
	aTyp2 unify: resultTyp.

]

{ #category : #'type unification' }
TArrow >> unifyWith: aTyp [
	aTyp unify: self with: argTypes arrow: resultTyp.

]
