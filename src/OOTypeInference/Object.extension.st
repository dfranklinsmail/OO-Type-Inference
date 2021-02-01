Extension { #name : #Object }

{ #category : #'*OOTypeInference' }
Object >> arrow: anObject prependTo: aMapList [ 
	^ MapList new add: self arrow: anObject prependTo: aMapList
]
