Extension { #name : #OrderedCollection }

{ #category : #'*OOTypeInference' }
OrderedCollection >> isSameTypes: aCollection env: anEnviroment [
	| result |
	result := true.
	self size = aCollection size ifTrue: [ 
		1 to: (self size) do: [ :i |
  			result := result and: ((self at: i) isSameType: (aCollection at: i) env: anEnviroment).
		].
	].
	^result.
	
	
]

{ #category : #'*OOTypeInference' }
OrderedCollection >> unify: anOrderedCollection [
	(self size = anOrderedCollection size) ifFalse: [ ^ Exception new. ].
	self with: anOrderedCollection do: [ :typ1 :typ2 | typ1 unify: typ2. ].
	
	
	
]
