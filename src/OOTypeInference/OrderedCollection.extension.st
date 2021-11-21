Extension { #name : #OrderedCollection }

{ #category : #'*OOTypeInference' }
OrderedCollection >> isSameTypes: aCollection [
	| result |
	result := true.
	self size = aCollection size ifTrue: [ 
		1 to: (self size) do: [ :i |
  			result := result and: ((self at: i) isSameType: (aCollection at: i)).
		].
		^result.
	].
	^false.
	
	
]

{ #category : #'*OOTypeInference' }
OrderedCollection >> isSameTypes: aCollection env: anEnviroment [
	| result |
	result := true.
	self size = aCollection size ifTrue: [ 
		1 to: (self size) do: [ :i |
  			result := result and: ((self at: i) isSameType: (aCollection at: i) env: anEnviroment).
		].
		^result.
	].
	^false.
	
	
]
