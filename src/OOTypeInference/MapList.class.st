"
Essentially a linked dictionary... access is O(n) but can contain duplicates and can discard front of list O(0)
"
Class {
	#name : #MapList,
	#superclass : #Link,
	#instVars : [
		'key',
		'value'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #initialization }
MapList >> add: anObject arrow: anotherObject prependTo: aMapList [ 
	key := anObject.
	value := anotherObject.
	nextLink := aMapList.

]

{ #category : #accessing }
MapList >> at: aKey [
	key = aKey ifTrue: [ ^ value ].
	^ nextLink at: aKey
]

{ #category : #testing }
MapList >> includesKey: aKey [
	key = aKey ifTrue: [ ^ true ].
	nextLink = nil ifTrue: [ ^ false ].
	^ nextLink includesKey: aKey
]

{ #category : #printing }
MapList >> printMapListOn: aStream [
	aStream nextPut: $,.
	key printOn: aStream.
	aStream nextPutAll: '->'.
	value printOn: aStream.
	nextLink printMapListOn: aStream.

]

{ #category : #printing }
MapList >> printOn: aStream [
	aStream nextPut: $[.
	key printOn: aStream.
	aStream nextPutAll: '->'.
	value printOn: aStream.
	nextLink printMapListOn: aStream.
	aStream nextPut: $].

]
